import 'dart:developer';

import 'package:education_on_cloud/Controller/Services/Home/Academic_Course/academic_course_services.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final AcademicCourseServices academicCourseServices = AcademicCourseServices();

  RxBool categoryListOrGrid = true.obs;

  void changecategoryListOrGrid(bool val) {
    categoryListOrGrid.value = val;
  }

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


RxList<CourseSectionModel> course_section = <CourseSectionModel>[].obs;

 void addCourseSection(CourseSectionModel courseSection) {
    course_section.add(courseSection);
  }
  RxBool coursesBoardsListOrGrid = false.obs;

  void changeCoursesBoardsListOrGrid(bool val) {
    coursesBoardsListOrGrid.value = val;
  }

  var categoryIndexForColor = 100.obs; // Reactive observable

  void changecategoryIndexForColor(int index) {
    categoryIndexForColor.value = index; // Update the reactive value
  }

  var courseAndBoardIndexForColor = 0.obs;

  void changecourseAndBoardIndexForColor(int val) {
    courseAndBoardIndexForColor.value = val;
  }

  RxList<CourseSectionModel> courseSessionList = <CourseSectionModel>[].obs;

  Future<void> fetchCourses() async {
    log('brfore fetching the coursesession');
    List<CourseSectionModel> fetchedCourses =
        await academicCourseServices.fetchCoursesSection('0');
    log('Fetched Courses: ${fetchedCourses.length}');
    courseSessionList.value = fetchedCourses;
  }

  RxBool isLoadingOfcourseSessionList = true.obs;

void changeisLoadingOfcourseSessionList(bool val){
  isLoadingOfcourseSessionList.value=val;
}

  void changeCourseSessionList(List<CourseSectionModel> coursesection) {
    // isLoadingOfcourseSessionList.value = false;
    courseSessionList.value = coursesection;
    // isLoadingOfcourseSessionList.value = true;
  }

  RxBool andTheFollowingFeaturesListOrGrid = false.obs;

  void changeandTheFollowingFeaturesListOrGrid(bool val) {
    andTheFollowingFeaturesListOrGrid.value = val;
  }

  RxBool languageListVisibility = false.obs;

  void changelanguageListVisibility(bool val) {
    languageListVisibility.value = val;
  }
RxBool isLoadingcoursecategoryModel=true.obs;
changeIsLoadingcourseCategoryModel(bool val){
  isLoadingcoursecategoryModel.value=val;
}
}