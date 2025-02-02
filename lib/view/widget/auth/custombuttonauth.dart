import 'package:flutter/material.dart';
import 'package:flutter_application_depi/constants/color.dart';

class Custombuttonauth extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const Custombuttonauth({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: MaterialButton(onPressed: onPressed,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
    padding: const EdgeInsets.all(13),
    color: AppColor.primaryColor,
    textColor: Colors.white,
    child:Text(text),
    ),
    );
  }
}