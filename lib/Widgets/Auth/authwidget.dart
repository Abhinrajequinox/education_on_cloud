import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAuthButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final double width;
  const CustomAuthButton({super.key, required this.text, required this.onTap, required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        width: width,
        // width: 138,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(0, 56, 255, 1),
              Color.fromRGBO(0, 224, 255, 1)
            ]),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomText(
                text: text,
                textStyle: GoogleFonts.mulish(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
              const Icon(
                Icons.arrow_circle_right,
                color: Colors.white,
                size: 29,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFeild extends StatelessWidget {
  final String text;
  final IconData iconData;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
  final TextInputType keybordtype;
  final String? Function(String?)? validator;

  const CustomTextFeild({
    super.key,
    required this.text,
    required this.iconData,
    required this.controller,
    this.validator,
    required this.textCapitalization,
    this.keybordtype = TextInputType.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 15, 2, 15),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        keyboardType: keybordtype,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          prefixIcon: Icon(iconData),
          hintText: text,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(width: 1)),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: primarycolour),
          ),
        ),
      ),
    );
  }
}

class CustomOtpBlock extends StatelessWidget {
  final TextEditingController otpController;
  const CustomOtpBlock({super.key, required this.otpController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.6)),
          border: Border.all(color: Colors.grey, width: .5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.white),
      height: 68,
      width: 64,
      child: TextFormField(
        controller: otpController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10.6)))),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        onSaved: (newValue) {},
        style: Theme.of(context).textTheme.headlineMedium,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
