import 'package:flutter/material.dart';
import 'package:flutter_application_depi/constants/color.dart';

class Custombuttonauth extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const Custombuttonauth({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: MaterialButton(onPressed: onPressed,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      padding: const EdgeInsets.all(10),
      color: AppColor.myBlue,
      textColor: Colors.white,
      child:Text(text,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
    ),
    );
    
  }
}