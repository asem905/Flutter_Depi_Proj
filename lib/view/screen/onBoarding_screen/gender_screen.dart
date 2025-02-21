import 'package:flutter/material.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/custom_gender_container.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/customcontainer.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/weightscreen.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});
  static String id = "GenderPage";

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 120.0, horizontal: 20),
            child: Column(
              children: [
                const Text(
                  "How do you identify?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "To give you a better experience we need to know your gender.s",
                  style: TextStyle(color: Colors.grey, fontSize: 25),
                ),
                CustomGender(
                  text: "Male",
                  icon: Icons.male,
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  isSelected: selectedIndex == 0,
                ),
                CustomGender(
                  text: "Female",
                  icon: Icons.female,
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  isSelected: selectedIndex == 1,
                ),
                CustomGender(
                  text: "Non-Binary",
                  icon: Icons.transgender,
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                  isSelected: selectedIndex == 2,
                ),
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
              onTapContinue: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => WeightScreen()));
              })
        ],
      ),
    );
  }
}
