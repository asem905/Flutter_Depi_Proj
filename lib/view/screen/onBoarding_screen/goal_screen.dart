import 'package:flutter/material.dart';

import 'package:flutter_application_depi/view/screen/onBoarding_screen/customchoosecard.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/customcontainer.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/gender_screen.dart';

class ChooseYourGoalScreen extends StatefulWidget {
  static String id = "your goal";

  @override
  _ChooseYourGoalScreenState createState() => _ChooseYourGoalScreenState();
}

class _ChooseYourGoalScreenState extends State<ChooseYourGoalScreen> {
  String selectedGoal = "";

  void selectGoal(String goal) {
    setState(() {
      selectedGoal = goal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 100.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "What's your goal?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  "This is used in getting & personalized results & plans for you",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xffa1a5ae),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomChooseCard(
                      text: "LOSE WEIGHT",
                      icon: Icons.scale_rounded,
                      isSelected: selectedGoal == "LOSE WEIGHT",
                      onSelect: () => selectGoal("LOSE WEIGHT"),
                    ),
                    CustomChooseCard(
                      text: "GET FITTER",
                      icon: Icons.sports_gymnastics,
                      isSelected: selectedGoal == "GET FITTER",
                      onSelect: () => selectGoal("GET FITTER"),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Center(
                  child: CustomChooseCard(
                    text: "GAIN MUSCLE",
                    icon: Icons.fitness_center,
                    isSelected: selectedGoal == "GAIN MUSCLE",
                    onSelect: () => selectGoal("GAIN MUSCLE"),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          CustomContainer(
            onTapPrevious: () {
              Navigator.of(context).pop();
            },
            title: "previous",
            subtTitle: "Finish",
            onTapContinue: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => GenderScreen()));
            },
          ),
        ],
      ),
        
      
    );
  }
}
