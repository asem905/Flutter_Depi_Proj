import 'package:flutter/material.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/customchoicecchip.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/customcontainer.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/tall_screen.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});
  static String id = "weightscreen";

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 90.0, horizontal: 20),
            child: const Column(
              children: [
                Text(
                  "How much your weight? ",
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
                  textLabelOne: "KG",
                  textLabelTwo: "LB",
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          const Spacer(),
          CustomContainer(
              title: "previous",
              subtTitle: "Continue",
              onTapPrevious: () {
                Navigator.of(context).pop();
              },
              onTapContinue: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => TallScreen()));
              })
        ],
      ),
    );
  }
}
