import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/constants/color.dart';

class Customtextformauth extends StatelessWidget {
  final String hinttext;
  // ignore: non_constant_identifier_names
  final String LabelText;
  final IconData icondata;
  //final TextEditingController mycontroller;
  //final String? Function(String?)? validator;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  // ignore: non_constant_identifier_names
  const Customtextformauth({super.key,this.onTapIcon,this.obscureText, required this.hinttext, required this.LabelText, required this.icondata,  required this.isNumber});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        //validator: validator,
        keyboardType: isNumber?const TextInputType.numberWithOptions(decimal: true):TextInputType.text,
            
            //controller: mycontroller,
            obscureText: obscureText==null || obscureText==false? false : true ,
            decoration: InputDecoration(
              hintText: hinttext,
              hintStyle: const TextStyle(fontSize: 14,color: AppColor.grey),
              contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 30),
              label: Container(margin: const EdgeInsets.symmetric(horizontal: 7),child: Text(LabelText,style:const TextStyle(color: Colors.white),),),
              suffixIcon: InkWell(
                onTap: onTapIcon,
                child: Icon(icondata),
              ),
              
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              )
            ),

          ),
    );
  }
}