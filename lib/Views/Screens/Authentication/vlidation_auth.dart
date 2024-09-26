import 'package:education_on_cloud/Controller/AuthController/country_controller.dart';
import 'package:get/get.dart';

class ValidationAuth {
final CountryController countryController = Get.put(CountryController());

  String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your Phone number';
  } else if (value.length < 10) {
    return 'Phone number must be 10 digits';
  }
  return null;
}

String? validateforname(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your Name';
  }
  return null;
  }
  

  String? validateformail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your Email';
  } else if (!_emailregexp.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validateforCountry(String? value) {
  if (countryController.selectedCountry.value.isEmpty||value==null||value.isEmpty) {
    return 'Choose your Country';
  }
  return null;
}

String? validateforState(String? value) {
  if (countryController.selectedState.value.isEmpty||value==null||value.isEmpty) {
    return 'Choose your State';
  }
  return null;
}

final RegExp _emailregexp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false, multiLine: false);
}