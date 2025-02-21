import 'package:flutter/material.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://i.pinimg.com/736x/eb/4c/ef/eb4cefe0c24c3e3010394ae4bfd3c9b8.jpg"), // Use NetworkImage for online images
              fit: BoxFit.fill, // Adjust the fit
            ),
          ),),
    );
  }
}