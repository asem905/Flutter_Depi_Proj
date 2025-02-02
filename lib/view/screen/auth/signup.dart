import 'package:flutter/material.dart';
import 'package:flutter_application_depi/view/screen/auth/login.dart';
import 'package:flutter_application_depi/view/widget/auth/custombuttonauth.dart';
import 'package:flutter_application_depi/view/widget/auth/customtextformauth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
          
          const SizedBox(height: 100,),
          Container(margin:const EdgeInsets.symmetric(horizontal: 60),child: const Text("Signup for stay fit",style: TextStyle(fontSize: 30,color: Colors.white))),
          const SizedBox(height: 80,),
          const Customtextformauth(hinttext: "Enter Your Username", LabelText: "Username", icondata: Icons.person,  isNumber: false,),
          const Customtextformauth(hinttext: "abc1123@gmail.com", LabelText: "Email", icondata: Icons.email,  isNumber: false,),
          const Customtextformauth(hinttext: "Enter Your Phone Number", LabelText: "Phone", icondata: Icons.phone,  isNumber: false,),
          const Customtextformauth(hinttext: "Enter Your Password", LabelText: "Password", icondata: Icons.lock,  isNumber: false,obscureText: true,),
          const SizedBox(height: 30,),
          const Custombuttonauth(text: "SignUp"),
          Container(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            
            children: [
              
              const Text("Already have an account?",style: TextStyle(fontSize: 20,color: Colors.grey),),
              MaterialButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Login()));
              },
              child: const Text("Login",style: TextStyle(fontSize: 20,color: Colors.grey),),
              ),
            ],
          )
        ],
      ),
    ));
  }
}