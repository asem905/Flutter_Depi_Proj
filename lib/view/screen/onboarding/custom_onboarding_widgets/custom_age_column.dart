import 'package:flutter/material.dart';
import 'package:flutter_application_depi/constants/color.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/custom_wheel_chooser.dart';

class CustomAgeColumn extends StatefulWidget {
  const CustomAgeColumn({super.key});

  @override
  State<CustomAgeColumn> createState() => _CustomAgeColumnState();
}

class _CustomAgeColumnState extends State<CustomAgeColumn> {
  int _selectedAge = 15;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final height = media.size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.05,
        horizontal: width * 0.03,
      ),
      child: Column(
        children: [
          Text(
            "Tell Us About Your Age",
            style: TextStyle(
              fontSize: width * 0.08,
              fontWeight: FontWeight.bold,
              color: AppColor.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height * 0.015),
          Text(
            "Make every year a new opportunity to grow and achieve a healthier, happier life!",
            style: TextStyle(
              color: AppColor.white70,
              fontSize: width * 0.04,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height * 0.06),
          CustomWheelChooser(
            maxValue: 100,
            minValue: 10,
            initValue: _selectedAge,
            onValueChanged: (value) {
              setState(() {
                _selectedAge = value;
              });
            },
          ),
          SizedBox(height: height * 0.02),
          Text(
            "Age: $_selectedAge years",
            style: TextStyle(
              color: AppColor.white,
              fontSize: width * 0.055,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
