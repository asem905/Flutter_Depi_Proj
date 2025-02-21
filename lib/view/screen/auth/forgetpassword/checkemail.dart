import 'package:flutter/material.dart';
import 'package:flutter_application_depi/view/screen/auth/forgetpassword/verifycode.dart';
import 'package:flutter_application_depi/view/widget/auth/custombuttonauth.dart';
import 'package:flutter_application_depi/view/widget/auth/customtextformauth.dart';

class CheckEmail extends StatelessWidget {
  const CheckEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://i.pinimg.com/736x/eb/4c/ef/eb4cefe0c24c3e3010394ae4bfd3c9b8.jpg"), // Use NetworkImage for online images
              fit: BoxFit.fill, // Adjust the fit
            ),
          ),
        child: ListView(
        
        children: [
          const SizedBox(height: 200,),
          Column(
            children: [
              Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Center(
            child: Text("Enter Your Email To",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.grey[200])),),
          ),
            Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Center(
            child: Text("Send Verification Code On It",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.grey[200])),),
          ),
            ],
          ),
          const SizedBox(height: 40,),
          const Customtextformauth(LabelText: "Email",hinttext: "Enter Your Email To check",icondata: Icons.email,isNumber: false,),
          const SizedBox(height: 10,),
          
          Custombuttonauth(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const VerifyCode()));
          }, text: "Submit",
          ),
          
        ],
      ),
      )
    );
  }
}