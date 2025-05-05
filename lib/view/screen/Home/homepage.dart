import 'dart:async';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/constants/custom_colors.dart';
import 'package:flutter_application_depi/constants/exercises/exercises_home_constant.dart';
import 'package:flutter_application_depi/constants/fitness_calc/common_functions.dart';
import 'package:flutter_application_depi/constants/fitness_calc/steps_calc.dart';
import 'package:flutter_application_depi/view/screen/Home/exercises/exercises_home.dart';
import 'package:flutter_application_depi/view/screen/Notifications/notifications.dart';
import 'package:flutter_application_depi/view/screen/excercies/exercise_home.dart';
import 'package:heart_bpm/chart.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    // Load stored data before initializing platform
    loadStoredData().then((_) {
      initPlatformState();
    });

    // Set up a timer to update the UI every second
    updateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // If we haven't received new steps in 3 seconds, use the last recorded value
      if (DateTime.now().difference(lastStepTime).inSeconds > 3 &&
          lastRecordedSteps > 0 &&
          steps == "?") {
        setState(() {
          steps = lastRecordedSteps.toString();
        });
      }
    });
  }

  // Load stored data from SharedPreferences
  Future<void> loadStoredData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      // Load step count with fallback to default
      lastRecordedSteps = prefs.getInt(STEPS_KEY) ?? 0;
      if (lastRecordedSteps > 0) {
        steps = lastRecordedSteps.toString();
      }

      // Load heart rate with fallback to default
      currentBPM = prefs.getString(BPM_KEY) ?? "72";
    });

    print('Loaded stored data - Steps: $lastRecordedSteps, BPM: $currentBPM');
  }

  // Save data to SharedPreferences
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    // Save current step count
    if (steps != "?" && steps != "Step Count not available") {
      await prefs.setInt(STEPS_KEY, currentSteps);
    }

    // Save heart rate if it's not the default value
    if (currentBPM != "72") {
      await prefs.setString(BPM_KEY, currentBPM);
    }

    // Save timestamp of last update
    await prefs.setString(LAST_UPDATED_KEY, DateTime.now().toIso8601String());

    print('Saved data - Steps: $lastRecordedSteps, BPM: $currentBPM');
  }

  @override
  void dispose() {
    updateTimer?.cancel();
    saveData(); // Save data when widget is disposed
    super.dispose();
  }

  void onStepCount(StepCount event) {
    print(event);
    lastStepTime = DateTime.now();

    if (initialSteps == null) {
      // First reading in this session
      initialSteps = event.steps;
      // Keep the stored value for displaying
      currentSteps = lastRecordedSteps;
    } else {
      // Calculate new steps in this session only
      int sessionSteps = event.steps - initialSteps!;

      // Apply smoothing if needed
      if (sessionSteps < 0 || sessionSteps > 100) {
        // Likely a sensor reset or error, ignore this reading
        return;
      }

      // Set the current steps to display
      currentSteps = lastRecordedSteps + sessionSteps;
    }

    setState(() {
      steps = currentSteps.toString();
      // DON'T update lastRecordedSteps until app closes
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      status = 'Pedestrian Status not available';
    });
    print(status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      steps = 'Step Count not available';
    });
  }

  // Method to start heart rate measurement
  void startHeartRateMeasurement() {
    setState(() {
      isBPMEnabled = true;
      heartData.clear();
      bpmValues.clear();
    });

    // Show a bottom sheet with the camera view
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: Color(0xFF1A1D2A),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Heart Rate Measurement',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          isBPMEnabled = false;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Place your finger on the back camera and flash',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: HeartBPMDialog(
                  context: context,
                  sampleDelay: 1000 ~/ 30, // 30 Hz sampling rate
                  borderRadius: 10,
                  onRawData: (value) {
                    setState(() {
                      if (heartData.length >= 100) heartData.removeAt(0);
                      heartData.add(value);
                    });
                  },
                  onBPM: (value) {
                    setState(() {
                      if (bpmValues.length >= 100) bpmValues.removeAt(0);
                      bpmValues.add(SensorValue(
                          value: value.toDouble(), time: DateTime.now()));
                      currentBPM = value.toString();

                      // Save the BPM value when it changes
                      saveData();
                    });
                  },
                ),
              ),
              if (heartData.isNotEmpty)
                Container(
                  height: 120,
                  padding: const EdgeInsets.all(8.0),
                  child: BPMChart(heartData),
                ),
              const SizedBox(height: 10),
              Text(
                'Current BPM: $currentBPM',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    ).then((_) {
      // When bottom sheet is closed
      setState(() {
        isBPMEnabled = false;
        // Save data when heart rate measurement ends
        saveData();
      });
    });
  }

  Future<bool> checkActivityRecognitionPermission() async {
    bool granted = await Permission.activityRecognition.isGranted;

    if (!granted) {
      granted = await Permission.activityRecognition.request() ==
          PermissionStatus.granted;
    }

    return granted;
  }

  // Check camera permission for heart rate monitoring
  Future<bool> checkCameraPermission() async {
    bool granted = await Permission.camera.isGranted;

    if (!granted) {
      granted = await Permission.camera.request() == PermissionStatus.granted;
    }

    return granted;
  }

  Future<void> initPlatformState() async {
    bool granted = await checkActivityRecognitionPermission();
    if (!granted) {
      // tell user, the app will not work
    }

    pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    (pedestrianStatusStream.listen(onPedestrianStatusChanged))
        .onError(onPedestrianStatusError);

    stepCountStream = Pedometer.stepCountStream;
    stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Save data when navigating away
      onWillPop: () async {
        await saveData();
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1D2A),
        appBar: AppBar(
          toolbarHeight: 30.0,
          backgroundColor: const Color(0xFF1A1D2A),
          shadowColor: Colors.transparent, // Fix flickering issue
          title: ShaderMask(
            shaderCallback: (bounds) =>
                MyColors.customGradient.createShader(bounds),
            child: const Text(
              "Fitlytic",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon:
                  const Icon(Icons.notifications_outlined, color: Colors.white),
              onPressed: () async {
                // Save data before navigating
                await saveData();
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => const NotificationsScreen(),
                  ),
                )
                    .then((_) {
                  // Reload data when returning
                  loadStoredData();
                });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Good Afternoon, Alex!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Ready to crush your goals?',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),

                // Daily metrics row
                SizedBox(
                  width: double.maxFinite,
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: [
                      _buildMetricCard(
                        key: const ValueKey('steps'),
                        icon: Icons.directions_walk,
                        value: steps,
                        label: 'Steps',
                        color: Colors.blue,
                        goal: 1000, // You can customize this
                      ),
                      _buildMetricCard(
                        key: const ValueKey('calories'),
                        icon: Icons.local_fire_department,
                        value: "420",
                        label: 'Calories',
                        color: Colors.redAccent,
                        goal: 600, // You can customize this
                      ),
                      _buildMetricCard(
                        key: const ValueKey('active_minutes'),
                        icon: Icons.timer,
                        value: "45",
                        label: 'Active Minutes',
                        color: Colors.greenAccent,
                        goal: 60, // You can customize this
                      ),
                      InkWell(
                        onTap: () async {
                          bool hasPermission = await checkCameraPermission();
                          if (hasPermission) {
                            startHeartRateMeasurement();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Camera permission is required for heart rate monitoring'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: _buildMetricCard(
                          key: const ValueKey('heart_beat'),
                          icon: Icons.favorite,
                          value: currentBPM,
                          label: 'Heart Beat',
                          color: Colors.red,
                          goal: 80, // You can customize this
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          // Toggle to the other page when back button is pressed
                          _currentPage = 0;
                          // Also update the page controller to match
                          _pageController.animateToPage(
                            _currentPage,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOut,
                          );
                        });
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    const Text(
                      'Recommended Workouts',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          // Toggle to the other page when forward button is pressed
                          _currentPage = 1;
                          // Also update the page controller to match
                          _pageController.animateToPage(
                            _currentPage,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOut,
                          );
                        });
                      },
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Workout cards
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.46,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      // Display plans page
                      _categories_sections(),

                      // Features comparison page
                      _difficalties_secion(),
                    ],
                  ),
                ),
                const SizedBox(height: 50.0)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _categories_sections() {
    return GridView.builder(
      shrinkWrap: true, // Make GridView take only the space it needs
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return CategoryCard(category: categories[index]);
      },
    );
  }

  Widget _difficalties_secion() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildWorkoutCard(
            key: const ValueKey('workout_3'),
            title: 'Yoga Flow',
            trainer: 'Emma Wilson',
            duration: '20 min',
            difficulty: 'easy',
            image: 'assets/achievement/strength_2.jpg',
            onTap: () async {
              // Save data before navigation
              await saveData();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseListScreen(
                    difficulty: 'Easy',
                    exercises: easyExercises,
                  ),
                ),
              ).then((_) {
                // Reload data when returning
                loadStoredData();
              });
            },
          ),
          const SizedBox(height: 16),
          _buildWorkoutCard(
            key: const ValueKey('workout_1'),
            title: 'HIIT Cardio Blast',
            trainer: 'Sarah Johnson',
            duration: '30 min',
            difficulty: 'medium',
            image: 'assets/achievement/strength_2.jpg',
            onTap: () async {
              // Save data before navigation
              await saveData();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseListScreen(
                    difficulty: 'Medium',
                    exercises: mediumExercises,
                  ),
                ),
              ).then((_) {
                // Reload data when returning
                loadStoredData();
              });
            },
          ),
          const SizedBox(height: 16),
          _buildWorkoutCard(
            key: const ValueKey('workout_2'),
            title: 'Strength Foundation',
            trainer: 'Mike Chen',
            duration: '45 min',
            difficulty: 'Hard',
            image: 'assets/achievement/strength_2.jpg',
            onTap: () async {
              // Save data before navigation
              await saveData();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseListScreen(
                    difficulty: 'Advanced',
                    exercises: advancedExercises,
                  ),
                ),
              ).then((_) {
                // Reload data when returning
                loadStoredData();
              });
            },
          )
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required Key key,
    required IconData icon,
    required String value,
    required String label,
    required Color color,
    int? goal,
  }) {
    // Default goals for each metric
    final int defaultGoal = label == 'Steps'
        ? 10000
        : label == 'Calories'
            ? 600
            : label == 'Active Minutes'
                ? 60
                : label == 'Heart Beat'
                    ? 80
                    : 100;

    // Use provided goal or default
    final int targetGoal = goal ?? defaultGoal;

    // Calculate progress
    double progress = 0.0;
    if (value != "?" && value != "Step Count not available") {
      int currentValue = int.tryParse(value) ?? 0;

      // For heart rate, optimal is around the goal (not necessarily higher is better)
      if (label == 'Heart Beat') {
        // Consider 80 as optimal - too high or too low is not ideal
        double deviation = (currentValue - targetGoal).abs() / targetGoal;
        progress = 1.0 - deviation.clamp(0.0, 1.0);
      } else {
        progress = currentValue / targetGoal;
      }

      // Clamp progress between 0 and 1
      progress = progress.clamp(0.0, 1.0);
    }

    return Column(
      key: key,
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey[800],
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              Icon(
                icon,
                color: color,
                size: 24,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label == 'Steps'
              ? (value != "?" ? "$value / $targetGoal" : "0 / $targetGoal")
              : (label == 'Calories'
                  ? "$value kcal"
                  : label == 'Heart Beat'
                      ? "$value bpm"
                      : "$value min"),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkoutCard({
    required Key key,
    required String title,
    required String trainer,
    required String duration,
    required String difficulty,
    required String image,
    void Function()? onTap,
  }) {
    Color difficultyColor;
    if (difficulty == 'easy') {
      difficultyColor = Colors.green;
    } else if (difficulty == 'medium') {
      difficultyColor = Colors.orange;
    } else {
      difficultyColor = Colors.red;
    }

    return GestureDetector(
      key: key,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFF222533),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                image,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: difficultyColor,
                        ),
                        child: Text(
                          difficulty.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.grey[700],
                        child: Text(
                          trainer[0], // Show trainer's initial
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        trainer,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          color: Colors.grey, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        duration,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
