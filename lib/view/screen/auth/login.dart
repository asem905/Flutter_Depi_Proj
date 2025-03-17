import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_application_depi/core/class/auth_service.dart';

import 'package:flutter_application_depi/view/screen/auth/signup.dart';
import 'package:flutter_application_depi/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/onboarding_screen.dart';
import 'package:flutter_application_depi/view/widget/auth/custombuttonauth.dart';
import 'package:flutter_application_depi/view/widget/auth/customloginlinks.dart';
import 'package:flutter_application_depi/view/widget/auth/customtextformauth.dart';
import 'package:flutter_application_depi/core/functions/validinput.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _textFormKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> _loginWithEmailAndPassword() async {
    if (_textFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final user = await _authService.signInWithEmailAndPassword(
          email.text,
          password.text,
        );

        if (user != null && !user.emailVerified) {
          await _authService.sendEmailVerification();
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.info,
            title: 'Attention!!',
            desc: "Verification code sent to your email",
          ).show();
        } else {
          Navigator.pushNamedAndRemoveUntil(context, OnboardingScreen.id, (route) => false);
        }
      } on FirebaseAuthException catch (e) {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          title: 'Error!!',
          desc: e.message ?? "An error occurred",
        ).show();
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        Navigator.pushReplacementNamed(context, "Homepage");
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 40),
          const Center(
            child: Text(
              "Hey There,",
              style: TextStyle(fontSize: 20, color: Colors.black54),
            ),
          ),
          const Center(
            child: Text(
              "Welcome Back",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 40),
          Form(
            key: _textFormKey,
            child: Column(
              children: [
                Customtextformauth(
                  hinttext: "abc1123@gmail.com",
                  icondata: Icons.email,
                  isNumber: false,
                  mycontroller: email,
                  validator: (val) => Validinput("email", email.text),
                  LabelText: 'Email',
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
                const SizedBox(height: 200),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResetPassword()),
                    );
                  },
                  child: const Text(
                    "Forget Your Password?",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Custombuttonauth(
                  onPressed: _isLoading ? null : _loginWithEmailAndPassword,
                  text: "Login",
                ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              "Or Login With",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              const Customloginlinks(img: "assets/facebook.png"),
              const SizedBox(width: 40),
              Customloginlinks(onTap: _isLoading ? null : _loginWithGoogle,img: "assets/google.png"),
              
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have account?",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Signup()),
                  );
                },
                child: const Text(
                  "Sign up",
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
