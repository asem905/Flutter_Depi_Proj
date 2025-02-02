import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(5),
      color: Colors.black,
      textColor: Color.fromARGB(120,60,20,150),
      child:Text(text,style: const TextStyle(fontSize: 25),),
    ),
    );
    
  }
}