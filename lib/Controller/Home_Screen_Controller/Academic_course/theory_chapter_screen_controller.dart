import 'package:get/get.dart';

class TheoryChapterScreenController extends GetxController {
  var expandedIndex = (-1).obs; // -1 means no card is expanded
  var toggleAnimations = <int, bool>{}.obs; // Keeps track of animation state for each index

  void toggleExpansion(int index) {
    // If we are expanding a new card
    if (expandedIndex.value != index) {
      // Reset the previous card's animation (collapse the previous one)
      if (expandedIndex.value != -1) {
        toggleAnimations[expandedIndex.value] = true; // Close previous one
      }
      
      // Update the expanded index to the new card and start its animation
      expandedIndex.value = index;
      toggleAnimations[index] = false; // Open the new one
    } else {
      // If the same card is clicked, collapse it
      expandedIndex.value = -1;
      toggleAnimations[index] = true; // Close the same one
    }
  }

  bool isExpanded(int index) {
    return expandedIndex.value == index;
  }

  bool getRotationState(int index) {
    // Default rotation is upward (true), and it's downward (false) when the card is expanded
    return toggleAnimations[index] ?? true;
  }
}


