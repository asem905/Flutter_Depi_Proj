import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_application_depi/core/class/auth_service.dart';
import 'package:flutter_application_depi/view/screen/auth/login.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/onboarding_screen.dart';
import 'package:flutter_application_depi/view/widget/auth/custombuttonauth.dart';
import 'package:flutter_application_depi/view/widget/auth/customloginlinks.dart';
import 'package:flutter_application_depi/view/widget/auth/customtextformauth.dart';
import 'package:flutter_application_depi/core/functions/validinput.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _textFormKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_textFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final user = await _authService.signUpWithEmailAndPassword(
          email.text,
          password.text,
        );
        print("User: $user ======================");
        if (user != null && !user.emailVerified) {
          await _authService.sendEmailVerification();
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.info,
            title: 'Attention!!',
            desc: "You need to verify your email then go to login page.Check your inbox.",
          ).show();
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const OnboardingScreen()),
            (route) => false,
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = "An error occurred. Please try again.";
        if (e.code == 'weak-password') {
          errorMessage = "The password provided is too weak.";
        } else if (e.code == 'email-already-in-use') {
          errorMessage = "The account already exists for that email.";
        }

        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          title: 'Error!!',
          desc: errorMessage,
        ).show();
      } catch (e) {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          title: 'Error!!',
          desc: e.toString(),
        ).show();
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[180],
      body: ListView(
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text(
                "Hey There,",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Create An Account",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Form(
            key: _textFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Customtextformauth(
                  hinttext: "Enter Your Username",
                  icondata: Icons.person,
                  isNumber: false,
                  mycontroller: username,
                  validator: (val) => Validinput("username", username.text),
                  LabelText: 'Username',
                ),
                Customtextformauth(
                  hinttext: "abc1123@gmail.com",
                  icondata: Icons.email,
                  isNumber: false,
                  mycontroller: email,
                  validator: (val) => Validinput("email", email.text),
                  LabelText: 'Email',
                ),
                Customtextformauth(
                  hinttext: "Enter Your Phone Number",
                  icondata: Icons.phone,
                  isNumber: false,
                  mycontroller: phone,
                  validator: (val) => Validinput("phone", phone.text),
                  LabelText: 'Phone',
                ),
                Customtextformauth(
                  hinttext: "Enter Your Password",
                  icondata: Icons.lock,
                  isNumber: false,
                  obscureText: true,
                  mycontroller: password,
                  validator: (val) => Validinput("password", password.text),
                  LabelText: 'Password',
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: Custombuttonauth(
                    onPressed: _isLoading ? null : _signUp,
                    text: 'SignUp',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Center(
            child: Text(
              "Or Signup with",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          const SizedBox(height: 30),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Customloginlinks(img: "assets/facebook.png"),
              SizedBox(width: 40),
              Customloginlinks(img: "assets/google.png"),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account?",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
