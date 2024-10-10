import 'dart:developer';

import 'package:education_on_cloud/Controller/Services/Auth/login_services.dart';

void saveUser({required String username,required String phoneNumber,required String country,required String state,required String email}) async {
  await UserPreferences.saveUserDetails(
    username: username,
    phoneNumber: phoneNumber,
    country: country,
    state: state,
    email: email,
  );
}
Future<Map<String, String?>> getUser() async {
  Map<String, String?> userDetails = await UserPreferences.getUserDetails();
  log('Username: ${userDetails['username']}');
  log('Phone Number: ${userDetails['phoneNumber']}');
  log('Country: ${userDetails['country']}');
  log('State: ${userDetails['state']}');
  log('Email: ${userDetails['email']}');
  return userDetails;
}

void deleteUser() async {
  await UserPreferences.deleteUserDetails();
  log('User details deleted');
}
