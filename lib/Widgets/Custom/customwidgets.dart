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
      textAlign: textalign,
      maxLines: maxline,
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

// Widget cusstomBuildShimmerEffect(double height) {
//   return Shimmer.fromColors(
//     baseColor: Colors.grey[300]!, // Base color of the shimmer
//     highlightColor: Colors.grey[100]!, // Highlight color of the shimmer
//     child: Container(
//       height: height, // Height of the shimmer effect
//       width: double.infinity, // Width of the shimmer effect
//       decoration: BoxDecoration(
//         color: Colors.white, // Background color
//         borderRadius: BorderRadius.circular(4), // Rounded corners
//       ),
//     ),
//   );
// }

Widget customShimmerBuilder(
    {required double width,
    required double height,
    required int builderLength}) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return customShimmer(width: width, height: height);
    },
    itemCount: builderLength,
  );
}

Widget customShimmer({
  required double width,
  required double height,
  double left = 0.0,
  double right = 0.0,
  double top = 0.0,
  double bottom = 0.0,
}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    period: const Duration(seconds: 2),
    direction: ShimmerDirection.ltr,
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.grey,
        ),
        width: width,
        height: height, // Adjust height as needed
        margin:
            EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      ),
    ),
  );
}
