import 'package:flutter/material.dart';
import 'package:flutter_application_depi/constants/color.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/custom_select_gender.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/cutom_positioned_arrow.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/weight_screen.dart';

class GenderScreen extends StatefulWidget {
  static String id = "GenderPage";
  @override
  _GenderScreenState createState() => _GenderScreenState();
}
class _GenderScreenState extends State<GenderScreen> {
  String? selectedGender;

  void _selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColorScaffoldBoarding,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'assets/images/genderphoto.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: AppColor.overlayBackgroundBlack,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
             const   Text(
                  "Your gender",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
            const    Text(
                  "To estimate your body’s",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                const Text(
                  "metabolic rate.",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 30),
                GenderSelected(
                  gender: "Male",
                  isSelected: selectedGender == "Male",
                  onTap: () => _selectGender("Male"),
                ),
                const SizedBox(height: 15),
                GenderSelected(
                  gender: "Female",
                  isSelected: selectedGender == "Female",
                  onTap: () => _selectGender("Female"),
                ),
                const Spacer(),
              ],
            ),
          ),
          CustomPositionedArrow(onPressed: () {
            Navigator.pushNamed(context, WeightScreen.id);
          })
        ],
      ),
    );
  }
}
