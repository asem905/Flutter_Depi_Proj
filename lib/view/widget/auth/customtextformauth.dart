// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:flutter_application_depi/constants/color.dart';

class Customtextformauth extends StatelessWidget {
  final String hinttext;
  final String LabelText;
  final IconData icondata;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  const Customtextformauth({
    super.key,
    required this.hinttext,
    required this.LabelText,
    required this.icondata,
    required this.mycontroller,
    required this.validator,
    required this.isNumber,
    this.obscureText,
    this.onTapIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            style: const TextStyle(color: Colors.black),
            validator: validator,
            keyboardType: isNumber
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,
            controller: mycontroller,
            obscureText:
                obscureText == null || obscureText == false ? false : true,
            decoration: InputDecoration(
              hintText: hinttext,
              hintStyle: const TextStyle(fontSize: 14, color: AppColor.grey),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 7),
                child: Text(
                  LabelText,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              suffixIcon: InkWell(
                onTap: onTapIcon,
                child: Icon(icondata),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.grey, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ));
  }
}
