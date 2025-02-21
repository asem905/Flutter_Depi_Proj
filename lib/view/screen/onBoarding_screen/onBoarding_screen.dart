import 'package:flutter/material.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/customcontainer.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/goal_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  static String id = "OnBoardingScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
    
        children: [
          const Image(
            image: AssetImage("assets/onboarding.PNG"),
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 50,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Column(
              children: [
                Text(
                  "YOU ARE READY TO GO!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Stay motivated with 3,000+ classes across categories like running,yoga and strength training allover the world. ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xffa1a5ae)),
                ),
              ],
            ),
          ),
          const Spacer(),
          CustomContainer(
            title: 'Do it later',
            onTapContinue: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChooseYourGoalScreen()));
            },
            subtTitle: "Let's do it ",
          )
        ],
      ),
    );
  }
}
