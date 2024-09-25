import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CountryController extends GetxController {
  // List of countries
  final List<String> countries = ['United States', 'India', 'Canada', 'Australia', 'Germany'];

  // The currently selected country (observable)
  var selectedCountry = ''.obs;

  // Function to change the selected country
  void changeCountry(String newCountry) {
    selectedCountry.value = newCountry;
  }

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

// The currently selected country (observable)
  var selectedState = ''.obs;

  // Function to change the selected country
  void changeState(String newState) {
    selectedState.value = newState;
  }


}