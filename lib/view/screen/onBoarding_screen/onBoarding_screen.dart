import 'package:flutter/material.dart';
import 'package:flutter_application_depi/constants/color.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/page_view_boarding.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/cutom_positioned_arrow.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  static String id = "/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
/*************  ✨ Codeium Command 🌟  *************/
        Positioned.fill(
            child: Image.asset(
          "assets/images/onboarding.webp",
          fit: BoxFit.fill,
          
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
        )),
/******  065627fe-0d4e-41f5-a1d3-2fd6f927ae94  *******/
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.overlayBackgroundBlack,
            ),
          ),
        ),
        Positioned.fill(
          top: 100,
          bottom: 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Welcome to \nFitlytic 👋! ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 45),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(
                      flex: 5,
                      child: Text(
                        "Fitlytic helps track workouts, monitor progress, and optimize fitness. Stay motivated and reach your goals!",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                  Expanded(child: CustomPositionedArrow(
                    onPressed: () {
                      Navigator.pushNamed(context, PageViewBoarding.id);
                    },
                  ))
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
