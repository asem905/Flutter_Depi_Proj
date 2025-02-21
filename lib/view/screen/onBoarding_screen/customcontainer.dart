import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.title,
    required this.subtTitle,
    this.onTapPrevious,
    this.onTapContinue,
    this.icon,
  });

  final String title;
  final String subtTitle;
  final void Function()? onTapPrevious;
  final void Function()? onTapContinue;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Color(0xff7165e4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onTapPrevious,
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          InkWell(
            onTap: onTapContinue,
            child: Card(
              elevation: 10,
              shadowColor: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Icon(icon, color: Colors.white),
                    Text(
                      subtTitle,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
