import 'dart:developer';

import 'package:education_on_cloud/Controller/AuthController/country_controller.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/vlidation_auth.dart';
import 'package:education_on_cloud/Widgets/Auth/authwidget.dart';
import 'package:education_on_cloud/Widgets/Auth/signin_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final ValidationAuth validationAuth = ValidationAuth();
final TextEditingController namecontroller = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController mailController = TextEditingController();
final SigninScreenWidget signinScreenWidget = SigninScreenWidget();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final CountryController countryController = CountryController();

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _signUpBody(context));
  }
}

Widget _signUpBody(BuildContext context) {
  final double screenHeight = MediaQuery.of(context).size.height;
  final double screenWidth = MediaQuery.of(context).size.width;

  return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo Image
                    signinScreenWidget.logoImage(screenHeight, screenWidth),
                    // Name TextForm Feild
                    CustomTextFeild(
                        textCapitalization: TextCapitalization.sentences,
                        text: 'Enter Your Name',
                        iconData: Icons.person_2_outlined,
                        controller: namecontroller,
                        validator: validationAuth.validateforname),
                    // Phone Number TextForm Feild
                    CustomTextFeild(
                        textCapitalization: TextCapitalization.none,
                        text: 'Enter Your Phone number',
                        keybordtype: TextInputType.phone,
                        iconData: Icons.phone_outlined,
                        validator: validationAuth.validatePhoneNumber,
                        controller: phoneController),
                    // Country Choosing DropDown
                    signinScreenWidget.chooseCountryList(
                        screenHeight, _formKey),
                    // State Choosing DropDown
                    signinScreenWidget.chooseStateList(screenHeight, _formKey),
                    // Email TextForm Feild
                   CustomTextFeild(
                          textCapitalization: TextCapitalization.none,
                          text: 'Enter Your Gmail',
                          iconData: Icons.mail_outline_rounded,
                          controller: mailController,
                          keybordtype: TextInputType.emailAddress,
                          validator: validationAuth.validateformail,
                        ),

                    SizedBox(height: screenHeight * 0.02),
                    // Sigin Button
                    signinScreenWidget.siginButton(screenWidth, _formKey,
                        context, mailController.text, phoneController.text),
                    const SizedBox(height: 20),
                    // signinScreenWidget.alreadyHaveAccount(context)
                  ]))));
}
