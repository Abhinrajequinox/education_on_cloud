import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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