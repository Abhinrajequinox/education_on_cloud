import 'dart:developer';

import 'package:education_on_cloud/Controller/Auth/country_controller.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/otp_screen.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/vlidation_auth.dart';
import 'package:education_on_cloud/Widgets/Auth/authwidget.dart';
import 'package:education_on_cloud/Widgets/Custom/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final CountryController countryController = Get.put(CountryController());
final ValidationAuth validationAuth = ValidationAuth();
final TextEditingController namecontroller = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController mailController = TextEditingController();
final formKey = GlobalKey<FormState>();

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _signUpBody(context),
    );
  }
}

Widget _signUpBody(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 117, bottom: 50),
              child: SizedBox(
                height: 90,
                width: 184.29,
                child: Image.asset('lib/Assets/titlelogo.png'),
              ),
            ),
            CustomTextFeild(
              textCapitalization: TextCapitalization.characters,
              text: 'Enter Your Name',
              iconData: Icons.person_2_outlined,
              controller: namecontroller,
              validator: validationAuth.validateforname,
            ),
            CustomTextFeild(
                textCapitalization: TextCapitalization.none,
                text: 'Enter Your Phone number',
                keybordtype: TextInputType.phone,
                iconData: Icons.phone_outlined,
                validator: validationAuth.validatePhoneNumber,
                controller: phoneController),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
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
                    prefixIcon: const Icon(Icons.public),
                    hintText: "Select Country",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                  ),
                  value: countryController.selectedCountry.value.isEmpty
                      ? null
                      : countryController.selectedCountry.value,
                  items: countryController.countries.map((String country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    countryController.changeCountry(newValue!);
                    newValue=='India'?countryController.visibleFeild(true):countryController.visibleFeild(false);

                  },
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  isExpanded: true,
                ),
              );
            }),
            Obx(() => 
                Visibility(
                visible: countryController.satateFeils.value,
                child: Obx(() {
                return Padding(
                  padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
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
                      prefixIcon: const Icon(Icons.location_on_outlined),
                      hintText: "Select State",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                    ),
                    value: countryController.selectedState.value.isEmpty
                        ? null
                        : countryController.selectedState.value,
                    items: countryController.indianStates.map((String country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      countryController.changeState(newValue!);
                    },
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    isExpanded: true,
                  ),
                );
              }),
              ),
            ),

            CustomTextFeild(
              textCapitalization: TextCapitalization.none,
              text: 'Enter Your Gmail',
              iconData: Icons.mail_outline_rounded,
              controller: mailController,
              keybordtype: TextInputType.emailAddress,
              validator: validationAuth.validateformail,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomAuthButton(width: 138,
                  text: 'Log In',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      log('its okeyyy');
                      Navigator.push(context, MaterialPageRoute(builder:  (context) => OtpScreen(phoneNumber: phoneController.text,),));
                    } else {
                      customeSnakBar(
                          'Oops..', "Fill All The Details", Icons.info);
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
