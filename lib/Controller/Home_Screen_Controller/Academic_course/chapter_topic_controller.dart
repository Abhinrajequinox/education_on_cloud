import 'package:education_on_cloud/Views/Screens/Authentication/choosemodescreen.dart';
import 'package:get/get.dart';

class AcademicChapterTopicController extends GetxController {

  
  // Controls whether the dropdown is expanded or not
  var isDropdownExpanded = false.obs;

  // Controls the rotation of the arrow icon
  var iconRotation = 0.0.obs;

  // Toggle function for dropdown and arrow animation
  void toggleDropdown() {
    isDropdownExpanded.value = !isDropdownExpanded.value;
    iconRotation.value = isDropdownExpanded.value ? 0.5 : 0.0; // 180-degree rotation
  }

  // Update language selection and collapse the dropdown
  void selectLanguage(String languageCode, String country) {
    // Call the language change logic here
    languageController.changeLanguage(languageCode, country);
    
    // Collapse the dropdown and rotate the arrow back
    toggleDropdown();
  }
}

