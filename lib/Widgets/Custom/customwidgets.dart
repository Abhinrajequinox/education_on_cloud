import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final Color color;
  final double fontSize;
  // final double minline;
  final int? maxline;
  final TextAlign textalign;
  final TextStyle? textStyle;
  const CustomText(
      {super.key,
      required this.text,
      this.fontWeight = FontWeight.normal,
      this.color = const Color(0xFF000000),
      this.fontSize = 14,
      this.maxline,
      this.textalign = TextAlign.start,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textalign,maxLines: maxline,
      overflow: maxline == null ? TextOverflow.visible : TextOverflow.ellipsis,
      style: textStyle ??
          TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
    );
  }
}

//

customeSnakBar(String title, message, IconData icon) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.blueAccent,
    colorText: Colors.white,
    borderRadius: 10,
    margin: const EdgeInsets.all(10),
    duration: const Duration(seconds: 4),
    icon: Icon(icon, color: Colors.white),
  );
}
Widget cusstomBuildShimmerEffect(double height) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!, // Base color of the shimmer
    highlightColor: Colors.grey[100]!, // Highlight color of the shimmer
    child: Container(
      height: height, // Height of the shimmer effect
      width: double.infinity, // Width of the shimmer effect
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(4), // Rounded corners
      ),
    ),
  );
}