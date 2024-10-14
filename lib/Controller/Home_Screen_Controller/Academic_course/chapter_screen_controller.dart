import 'package:get/get.dart';

class ChapterScreenController extends GetxController {
  var expandedIndex = (-1).obs;
  RxBool toggleanimation = false.obs;

  void toggleExpansion(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1; // Collapse the current card if it's expanded
      toggleanimation.value = true;
    } else {
      expandedIndex.value = index; // Expand the new card and collapse others
      toggleanimation.value = false;
    }
  }
}
