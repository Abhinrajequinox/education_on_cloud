import 'dart:developer';

import 'package:education_on_cloud/Controller/AuthController/country_controller.dart';
import 'package:education_on_cloud/Controller/Services/Auth/auth_serivices.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/login_screen.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/otp_screen.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/signupscreen.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/vlidation_auth.dart';
import 'package:education_on_cloud/Widgets/Auth/authwidget.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninScreenWidget {
  final CountryController countryController = Get.put(CountryController());
  final ValidationAuth validationAuth = ValidationAuth();
  AuthServices authServices = AuthServices();

  Widget logoImage(double screenHeight, screenWidth) {
    return Padding(
        padding: EdgeInsets.only(
            top: screenHeight * 0.1, bottom: screenHeight * 0.05),
        child: SizedBox(
            height: screenHeight * 0.1,
            width: screenWidth * 0.5,
            child: Image.asset('lib/Assets/titlelogo.png')));
  }

  Widget chooseCountryList(double screenHeight, GlobalKey<FormState> formKey) {
    return Obx(() {
      return Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
          child: DropdownButtonFormField<String>(
              validator: validationAuth.validateforCountry,
              decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red)),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: primarycolour)),
                  prefixIcon: const Icon(Icons.public),
                  hintText: "Select Country",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: screenHeight * 0.015)),
              value: countryController.selectedCountry.value.isEmpty
                  ? null
                  : countryController.selectedCountry.value,
              items: countryController.countries.map((country) {
                return DropdownMenuItem<String>(
                  value: country['name'],
                  child: Text(country['name']!),
                );
              }).toList(),
              onChanged: (String? newValue) {
                countryController.changeCountry(newValue!);
                // formKey.currentState?.validate();
                // if (newValue == 'India') {
                //    countryController.visibleFeild(true);
                //    countryController.visibleMailFeild(true);
                // }else{
                //   countryController.visibleFeild(false);
                //   countryController.visibleMailFeild(false);
                // }
              },
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              isExpanded: true));
    });
  }

  Widget chooseStateList(double screenHeight, GlobalKey<FormState> formKey) {
    return Obx(() => Visibility(
        visible: countryController.satateFeils.value,
        child: Obx(() {
          return Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              child: DropdownButtonFormField<String>(
                  validator: validationAuth.validateforState,
                  decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.red)),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: primarycolour)),
                      prefixIcon: const Icon(Icons.location_on_outlined),
                      hintText: "Select State",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: screenHeight * 0.015)),
                  value: countryController.selectedState.value.isEmpty
                      ? null
                      : countryController.selectedState.value,
                  items: countryController.indianStates.map((String state) {
                    return DropdownMenuItem<String>(
                        value: state, child: Text(state));
                  }).toList(),
                  onChanged: (String? newValue) {
                    countryController.changeState(newValue!);
                    // formKey.currentState?.validate();
                  },
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  isExpanded: true));
        })));
  }

  Widget siginButton(double screenWidth, GlobalKey<FormState> formKey,
      BuildContext context, String mail, phone) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      CustomAuthButton(
          width: screenWidth * 0.3,
          text: 'Log In',
          onTap: () async {
            if (formKey.currentState!.validate() &&
                countryController.selectedCountry.value.isNotEmpty) {
              if (countryController.selectedCountry.value == 'India'&&countryController.selectedState.value.isNotEmpty) {
                log('its okeyyy');
                bool sucess = await authServices.submitRequest(
                    name: namecontroller.text,
                    number: phoneController.text,
                    country: countryController.selectedCountry.value,
                    state: countryController.selectedState.value,
                    email: mailController.text);
                if (sucess) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OtpScreen(
                              name: namecontroller.text,
                              state: countryController.selectedState.value,
                              logOrSingin: 'SignIn',
                              phoneNumber: phoneController.text,
                              userMail: mail,
                              userCountry:
                                  countryController.selectedCountry.value)));
                } else {
                  customeSnakBar(
                      'Submission failed. Please try again.', "", Icons.error);
                }
              } else if (countryController.selectedCountry.value != 'India') {
                bool sucess = await authServices.submitRequest(
                    name: namecontroller.text,
                    number: phoneController.text,
                    country: countryController.selectedCountry.value,
                    state: '',
                    email: mailController.text);
                if (sucess) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OtpScreen(
                              name: namecontroller.text,
                              state: countryController.selectedState.value,
                              logOrSingin: 'SignIn',
                              phoneNumber: phoneController.text,
                              userMail: mail,
                              userCountry:
                                  countryController.selectedCountry.value)));
                } else {
                  customeSnakBar(
                      'Submission failed. Please try again.', "", Icons.error);
                }
              } else {
                customeSnakBar('Choose State', "", Icons.info);
              }
            } else if (countryController.selectedCountry.value.isEmpty) {
              formKey.currentState?.validate();
              // customeSnakBar('Choose Country', "", Icons.info);
            }
          })
    ]);
  }

  // Widget alreadyHaveAccount(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [

  //       CustomText(
  //           text: 'Already have an Account?',
  //           textStyle:
  //               GoogleFonts.mulish(fontSize: 14, fontWeight: FontWeight.w700)),
  //       const SizedBox(width: 5),
  //       GestureDetector(
  //         onTap: () {
  //           Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => const LoginScreen(),
  //             ),
  //             (route) => false,
  //           );
  //         },
  //         child: CustomText(
  //             text: 'SIGN IN',
  //             textStyle: GoogleFonts.mulish(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w800,
  //                 color: const Color.fromRGBO(9, 97, 245, 1))),
  //       )
  //     ],
  //   );
  // }
}
