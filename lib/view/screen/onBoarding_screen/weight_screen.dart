import 'package:flutter/material.dart';
import 'package:flutter_application_depi/constants/color.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/custom_weight_body.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/cutom_positioned_arrow.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/hieght_screen.dart';
class WeightScreen extends StatelessWidget {
  const WeightScreen({super.key});
  static String id = "weightscreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColorScaffoldBoarding,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(color: AppColor.overlayBackgroundGrey),
          ),
          const CustomWeightSlider(),
    CustomPositionedArrow(onPressed: (){ Navigator.pushNamed(context, HeightWheelPicker.id);
})
        ],
      ),
    );
  }
}
