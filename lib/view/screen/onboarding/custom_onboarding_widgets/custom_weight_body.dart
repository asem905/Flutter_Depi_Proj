import 'package:flutter/material.dart';
import 'package:flutter_application_depi/constants/color.dart';

class CustomWeightSlider extends StatefulWidget {
  const CustomWeightSlider({super.key});

  @override
  State<CustomWeightSlider> createState() => _CustomWeightSliderState();
}

class _CustomWeightSliderState extends State<CustomWeightSlider> {
  double _currentValue = 0;

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
            "What is Your Weight ?",
            style: TextStyle(
              fontSize: width * 0.08,
              fontWeight: FontWeight.bold,
              color: AppColor.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height * 0.015),
          Text(
            "Your weight is just a number; fitness is the key to turning effort into results and reaching your goals!",
            style: TextStyle(
              color: AppColor.white70,
              fontSize: width * 0.04,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height * 0.07),
          Container(
            padding: EdgeInsets.all(width * 0.07),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColor.gradientStart, AppColor.gradientEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                SizedBox(height: height * 0.01),
                Text(
                  '${_currentValue.toStringAsFixed(1)} kg',
                  style: TextStyle(
                    fontSize: width * 0.05,
                    color: AppColor.white70,
                  ),
                ),
                Slider(
                  thumbColor: AppColor.thumbColor,
                  activeColor: AppColor.activeSliderColor,
                  max: 200,
                  min: 0,
                  value: _currentValue,
                  onChanged: (val) {
                    setState(() {
                      _currentValue = val;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
