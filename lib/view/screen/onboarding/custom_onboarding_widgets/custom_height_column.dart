import 'package:flutter/material.dart';
import 'package:flutter_application_depi/constants/color.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/custom_wheel_chooser.dart';

class CustomHeightColumn extends StatefulWidget {
  const CustomHeightColumn({super.key});

  @override
  State<CustomHeightColumn> createState() => _CustomHeightColumnState();
}

class _CustomHeightColumnState extends State<CustomHeightColumn> {
  int _selectedHeight = 150;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.05,
        horizontal: width * 0.03,
      ),
      child: Column(
        children: [
          Text(
            "What is Your Height?",
            style: TextStyle(
              fontSize: width * 0.08,
              fontWeight: FontWeight.bold,
              color: AppColor.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height * 0.01),
          Text(
            "Your height is a key part of your fitness journey!",
            style: TextStyle(
              color: AppColor.white70,
              fontSize: width * 0.04,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height * 0.05),
          CustomWheelChooser(
            maxValue: 220,
            minValue: 100,
            initValue: _selectedHeight,
            onValueChanged: (value) {
              setState(() {
                _selectedHeight = value;
              });
            },
          ),
          SizedBox(height: height * 0.03),
          Text(
            "Height: $_selectedHeight cm",
            style: TextStyle(
              color: AppColor.white,
              fontSize: width * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
