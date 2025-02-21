
import 'package:flutter/material.dart';

class CustomGender extends StatelessWidget {
  const CustomGender({
    super.key, required this.text, required this.icon, required this.onTap, required this.isSelected,
  })
  ;
  final String text;
  final IconData icon ;
  final VoidCallback onTap;
final   bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        
        child: Container(
          
          
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isSelected? const Color(  0xff7165e4,):Colors.white,
        borderRadius: BorderRadius.circular(20)
        
        
          ),
          
          
          child: Row(children: [Icon(icon,color: isSelected? Colors.white:Colors.grey,size: 40,),
          const SizedBox(width: 10,),
          
          Text(text,style: TextStyle(color:  isSelected?Colors.white:Colors.grey,fontSize: 25),)],),),
      ),
    );
  }
}