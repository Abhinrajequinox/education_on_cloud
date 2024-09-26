import 'dart:developer';
import 'package:education_on_cloud/Controller/AuthController/country_controller.dart';
import 'package:education_on_cloud/Controller/Services/Authservices/auth_serivices.dart';
import 'package:education_on_cloud/Utilities/constvalues.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/otp_screen.dart';
import 'package:education_on_cloud/Views/Screens/Authentication/vlidation_auth.dart';
import 'package:education_on_cloud/Widgets/Auth/authwidget.dart';
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
AuthServices authServices = AuthServices();

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
  final double screenHeight = MediaQuery.of(context).size.height;
  final double screenWidth = MediaQuery.of(context).size.width;

  return Padding(
    padding: EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
    child: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.1,
                  bottom: screenHeight * 0.05), // 10% and 5% of screen height
              child: SizedBox(
                height: screenHeight * 0.1, // 10% of screen height
                width: screenWidth * 0.5, // 50% of screen width
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
              controller: phoneController,
            ),
            Obx(() {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02), // 2% of screen height
                child: DropdownButtonFormField<String>(
                  validator: validationAuth.validateforCountry,
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
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: screenHeight *
                            0.015), // Responsive vertical padding
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
                    newValue == 'India'
                        ? countryController.visibleFeild(true)
                        : countryController.visibleFeild(false);
                  },
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  isExpanded: true,
                ),
              );
            }),
            Obx(
              () => Visibility(
                visible: countryController.satateFeils.value,
                child: Obx(() {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02), // 2% of screen height
                    child: DropdownButtonFormField<String>(
                      validator: validationAuth.validateforState,
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
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: screenHeight * 0.015),
                      ),
                      value: countryController.selectedState.value.isEmpty
                          ? null
                          : countryController.selectedState.value,
                      items: countryController.indianStates.map((String state) {
                        return DropdownMenuItem<String>(
                          value: state,
                          child: Text(state),
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
            SizedBox(height: screenHeight * 0.02), // 2% of screen height
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomAuthButton(
                  width: screenWidth * 0.3, // 50% of screen width
                  text: 'Log In',
                  onTap: () {
                    if (formKey.currentState!.validate() &&
                        countryController.selectedCountry.value.isNotEmpty) {
                      if (countryController.selectedCountry.value != 'India') {
                        log('its okeyyy');
                        authServices.sendEmailOtp(mailController.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtpScreen(
                                    phoneNumber: phoneController.text,
                                    userMail: mailController.text,
                                    userCountry:
                                        countryController.selectedCountry.value,
                                  )),
                        );
                      } else if (countryController
                          .selectedState.value.isNotEmpty) {
                        authServices.sendEmailOtp(mailController.text);

                        Navigator.push(
                          
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtpScreen(
                                  phoneNumber: phoneController.text,
                                  userMail: mailController.text,
                                  userCountry:
                                      countryController.selectedCountry.value)),
                        );
                      } else {
                        // customeSnakBar('Choose State', "", Icons.info);
                      }
                    } else if (countryController
                        .selectedCountry.value.isEmpty) {
                      // customeSnakBar('Choose Country', "", Icons.info);
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
