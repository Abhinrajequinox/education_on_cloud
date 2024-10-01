import 'package:get/get.dart';

class CountryController extends GetxController {

  // country selecting

final List<Map<String, String>> countries = [
    {'name': 'United States', 'code': '+1'},
    {'name': 'India', 'code': '+91'},
    {'name': 'Canada', 'code': '+1'},
    {'name': 'Australia', 'code': '+61'},
    {'name': 'Germany', 'code': '+49'},
  ];

  var selectedCountry = ''.obs;
  var selectedCountryCode = ''.obs;

  void changeCountry(String newCountry) {
    selectedCountry.value = newCountry;
    selectedCountryCode.value = countries
        .firstWhere((country) => country['name'] == newCountry)['code']!;
  }

// state selecting and visibling

var satateFeils=false.obs;
void visibleFeild(bool val){
  satateFeils.value=val;
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