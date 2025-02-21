import 'package:flutter/material.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/customchoicecchip.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/customcontainer.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/customheight.dart';

class TallScreen extends StatelessWidget {
  const TallScreen({super.key});
  static String id = "tallpage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: const EdgeInsets.symmetric(vertical: 90.0, horizontal: 20),
            child: Column(
              children: [
                Text(
                  "How tall are you? ",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "This is used to set up  recomendations just for you .",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xffa1a5ae),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                CustomChoiceShip(
                  textLabelOne: "CM",
                  textLabelTwo: "FT",
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          const Spacer(),
          CustomContainer(
              onTapPrevious: () {
                Navigator.of(context).pop();
              },
              title: "previous",
              subtTitle: "Continue",
              onTapContinue: () {})
        ],
      ),
    );
  }
}
