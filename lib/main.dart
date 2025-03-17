import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/age_screen.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/gender_screen.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/hieght_screen.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/onboarding_screen.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/page_view_boarding.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/weight_screen.dart';
import 'package:flutter_application_depi/view/screen/splash_screen/splashScreen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("=====Back Ground Message============");

  print("${message.notification!.title}");
  print("${message.notification!.body}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: "AIzaSyBMy968UAI1YI71Mg2vHQikFqNEDra4_o8",
          appId: "1:819905247319:android:e3ca26157456e518010b12",
          messagingSenderId: "819905247319",
          projectId: "fluttercourse-5af65",
        ))
      : await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        OnboardingScreen.id:(context)=>const OnboardingScreen(),
        GenderScreen.id:(context)=>GenderScreen(),
        PageViewBoarding.id:(context)=>PageViewBoarding(),
        WeightScreen.id:(context)=>const WeightScreen(),
        HeightWheelPicker.id:(context)=>HeightWheelPicker(),
        AgeScreen.id:(context)=>const AgeScreen(),
        "splash":(context)=>const Splashscreen()
        },
      initialRoute: "splash",
      
      
    );
  }
}
