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
  void changeCourseSessionList(List<CourseSectionModel> _course_section) {
    isLoadingOfcourseSessionList.value = true;
    courseSessionList.assignAll(_course_section);
    isLoadingOfcourseSessionList.value = false;
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