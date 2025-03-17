import 'package:flutter/material.dart';
import 'package:flutter_application_depi/constants/color.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/custom_age_column.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/cutom_positioned_arrow.dart';

class AgeScreen extends StatelessWidget {
  const AgeScreen({super.key});
  static String id = "ageScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColorScaffoldBoarding,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(color: AppColor.overlayBackgroundGrey),
          ),
       const   CustomAgeColumn(),
          CustomPositionedArrow(onPressed: () {
            Navigator.pushNamed(context, id);
          })
        ],
      ),
    );
  }
}
