
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/constants/color.dart'; 
class GenderSelected extends StatelessWidget {
  final String gender;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderSelected({
    Key? key,
    required this.gender,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: width * 0.04),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.accentPurple : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? AppColor.accentPurple : AppColor.textGrey,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            gender,
            style: TextStyle(
              color: isSelected ? AppColor.textWhite : AppColor.textGrey,
              fontSize: width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
