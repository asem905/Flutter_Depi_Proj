import 'package:flutter/material.dart';
import 'package:flutter_application_depi/view/screen/auth/forgetpassword/checkemail.dart';
import 'package:flutter_application_depi/view/screen/auth/signup.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/onBoarding_screen.dart';
import 'package:flutter_application_depi/view/widget/auth/custombuttonauth.dart';
import 'package:flutter_application_depi/view/widget/auth/customtextformauth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body:Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://i.pinimg.com/736x/eb/4c/ef/eb4cefe0c24c3e3010394ae4bfd3c9b8.jpg"), // Use NetworkImage for online images
              fit: BoxFit.fill, // Adjust the fit
            ),
          ),
          child:  ListView(
        
        children: [
          
          const SizedBox(height: 200,),
          Container(margin:const EdgeInsets.symmetric(horizontal: 60),child: const Text("Signin for stay fit",style: TextStyle(fontSize: 30,color: Colors.white))),
          const SizedBox(height: 80,),
          const Customtextformauth(hinttext: "abc1123@gmail.com", LabelText: "Email", icondata: Icons.email,  isNumber: false,),
          const Customtextformauth(hinttext: "Enter Your Password", LabelText: "Password", icondata: Icons.lock,  isNumber: false,obscureText: true,),
          const SizedBox(height: 30,),
          Custombuttonauth(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const OnboardingScreen()));
          },text: "Signin"),
          MaterialButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const CheckEmail()));
          },
          child: const Text("Forget Password?",style: TextStyle(fontSize: 20,color: Colors.grey),),
          ),
          Container(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            
            children: [
              
              const Text("Don't have account?",style: TextStyle(fontSize: 20,color: Colors.grey),),
              MaterialButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Signup()));
              },
              child: const Text("Sign up",style: TextStyle(fontSize: 20,color: Colors.grey),),
              ),
            ],
          )
        ],
      ),
    ));
  }
}