import 'package:flutter/material.dart';
import 'package:get/get.dart';



class CustomText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final Color color;
  final double fontSize;  
final TextAlign textalign;
final TextStyle? textStyle;
  const CustomText({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.color = const Color(0xFF000000),  
    this.fontSize = 14,
    this.textalign=TextAlign.start,
   this.textStyle
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,textAlign:textalign,
      style:  textStyle ?? TextStyle(fontSize: fontSize,fontWeight: fontWeight,color: color),
    );
  }
}

// 

 customeSnakBar(String title,message,IconData icon) {
  Get.snackbar(
    title,            
    message, 
    snackPosition: SnackPosition.BOTTOM,  
    backgroundColor: Colors.blueAccent,   
    colorText: Colors.white,             
    borderRadius: 10,                    
    margin:const EdgeInsets.all(10),          
    duration:const Duration(seconds: 4),       
    icon: Icon(icon, color: Colors.white), 
  );
}