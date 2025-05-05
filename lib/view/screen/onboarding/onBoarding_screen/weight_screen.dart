import 'package:flutter/material.dart';
import 'package:flutter_application_depi/constants/Routes/route.dart';
import 'package:flutter_application_depi/constants/color.dart';
import 'package:flutter_application_depi/view/screen/onboarding/custom_onboarding_widgets/custom_buttons.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/custom_weight_body.dart';

class WeightScreen extends StatelessWidget {
  const WeightScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final height = media.size.height;

    return Scaffold(
      backgroundColor: AppColor.primaarybg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: Column(
            children: [
              SizedBox(height: height * 0.05),
              const Expanded(child: CustomWeightSlider()),
              CustomRowButton(
                  onBack: () {
                    Navigator.of(context).pop();
                  },
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.height);
                  },
                  width: width,
                  height: height),
            ],
          ),
        ),
      ),
    );
  }
}
