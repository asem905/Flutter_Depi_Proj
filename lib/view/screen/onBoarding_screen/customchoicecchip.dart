
import 'package:flutter/material.dart';

class CustomChoiceShip extends StatefulWidget {
  const CustomChoiceShip({super.key, required this.textLabelOne, required this.textLabelTwo});
  
  final String textLabelOne;
  final String textLabelTwo;

  @override
  State<CustomChoiceShip> createState() => _CustomChoiceShipState();
}

class _CustomChoiceShipState extends State<CustomChoiceShip> {
  String selectedUnit = ""; 

  @override
  void initState() {
    super.initState();
    selectedUnit = widget.textLabelOne; 
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChoiceChip(
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 50),
          showCheckmark: false,
          label: Text(widget.textLabelOne),
          labelStyle: TextStyle(
              fontSize: 25,
              color: selectedUnit == widget.textLabelOne ? const Color(0xff7165e4) : Colors.black),
          selected: selectedUnit == widget.textLabelOne,
          onSelected: (selected) {
            setState(() {
              selectedUnit = widget.textLabelOne;
            });
          },
        ),
        ChoiceChip(
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 50),
          showCheckmark: false,
          label: Text(widget.textLabelTwo),
          labelStyle: TextStyle(
              fontSize: 25,
              color: selectedUnit == widget.textLabelTwo ? const Color(0xff7165e4) : Colors.black),
          selected: selectedUnit == widget.textLabelTwo,
          onSelected: (selected) {
            setState(() {
              selectedUnit = widget.textLabelTwo;
            });
          },
        ),
      ],
    );
  }
}
