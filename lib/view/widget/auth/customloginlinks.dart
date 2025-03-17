import 'package:flutter/material.dart';

class Customloginlinks extends StatelessWidget {
  final String img;
  final void Function()? onTap;
  const Customloginlinks({super.key, required this.img, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[180],
        ),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(img),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),);
  }
}
