import 'package:flutter/material.dart';

class CustomChooseCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  final VoidCallback onSelect;

  const CustomChooseCard({
    super.key,
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff7165e4) : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 40, color: isSelected ? Colors.white : Colors.grey),
            SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
