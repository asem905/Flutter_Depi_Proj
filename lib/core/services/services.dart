import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("=====Back Ground Message============");
  print("onBackgroundMessage: ${message.messageId}");
  print("onBackgroundMessage: ${message.data}");
  print("${message.notification?.title}");
  print("${message.notification?.body}");
}

class InitServices {
  static late SharedPreferences sharedPref;
  static late FirebaseMessaging messaging;

  static Future<void> initialize() async {
    try {
      // 1. Initialize SharedPreferences
      sharedPref = await SharedPreferences.getInstance();
      
      // 2. Initialize Firebase
      if (Platform.isAndroid) {
        await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyBMy968UAI1YI71Mg2vHQikFqNEDra4_o8",
            appId: "1:819905247319:android:e3ca26157456e518010b12",
            messagingSenderId: "819905247319",
            projectId: "fluttercourse-5af65",
          ),
        );
      } else {
        await Firebase.initializeApp();
      }

      // 3. Setup Firebase Messaging
      messaging = FirebaseMessaging.instance;
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      
      // 4. Request notification permissions
      await _setupNotificationPermissions();
      
      print('All services initialized successfully');
    } catch (e) {
      print('Error initializing services: $e');
      rethrow;
    }
  }

  static Future<void> _setupNotificationPermissions() async {
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    
    // Get token
    final token = await messaging.getToken();
    print('FCM Token: $token');
  }
}