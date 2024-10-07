import 'dart:developer';

import 'package:get/get.dart';

class CountryController extends GetxController {

  // country selecting

final List<Map<String, String>> countries = [
    {'name': 'India', 'code': '0'},
    {'name': 'Nepal', 'code': '1'},
    {'name': 'Sri lanka', 'code': '2'},
    {'name': 'Bangladesh', 'code': '3'},
    {'name': 'Bhutan', 'code': '4'},
  ];

  var selectedCountry = ''.obs;
  var selectedCountryCode = ''.obs;

  void changeCountry(String newCountry) {
    selectedCountry.value = newCountry;
    selectedCountryCode.value = countries
        .firstWhere((country) => country['name'] == newCountry)['code']!;
         if (selectedCountry.value == 'India') {
      visibleMailFeild(true);
      visibleFeild(true);
    } else {
      visibleMailFeild(false);
      visibleFeild(false);
    }
  }

// state selecting and visibling

var satateFeils=false.obs;
void visibleFeild(bool val){
  satateFeils.value=val;
  log("satateFeils updated: $satateFeils");
}
var emailFeils=false.obs;
void visibleMailFeild(bool val){
  emailFeils.value=val;
  log("email feilds updated: $emailFeils");
}
List<String> indianStates = [
  'Andhra Pradesh',
  'Arunachal Pradesh',
  'Assam',
  'Bihar',
  'Chhattisgarh',
  'Goa',
  'Gujarat',
  'Haryana',
  'Himachal Pradesh',
  'Jharkhand',
  'Karnataka',
  'Kerala',
  'Madhya Pradesh',
  'Maharashtra',
  'Manipur',
  'Meghalaya',
  'Mizoram',
  'Nagaland',
  'Odisha',
  'Punjab',
  'Rajasthan',
  'Sikkim',
  'Tamil Nadu',
  'Telangana',
  'Tripura',
  'Uttar Pradesh',
  'Uttarakhand',
  'West Bengal',
  'Andaman and Nicobar Islands',
  'Chandigarh',
  'Dadra and Nagar Haveli and Daman and Diu',
  'Lakshadweep',
  'Delhi',
  'Puducherry',
  'Ladakh',
  'Jammu and Kashmir'
];
  var selectedState = ''.obs;

  // Function to change the selected country
  void changeState(String newState) {
    selectedState.value = newState;
  }


}