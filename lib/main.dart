import 'package:flutter/material.dart';
import 'package:flutter_application_depi/view/screen/auth/login.dart';
import 'package:flutter_application_depi/view/screen/splash_screen/splashScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override 
  Widget build(BuildContext context) {
    
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}
