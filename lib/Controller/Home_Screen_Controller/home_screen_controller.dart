import 'dart:developer';

import 'package:education_on_cloud/Controller/Services/Home/home_screen_services.dart';
import 'package:education_on_cloud/Models/Home/home_screen_model.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController{

  final HomeScreenServices homeScreenServices=HomeScreenServices();

  RxBool categoryListOrGrid=true.obs;

  void changecategoryListOrGrid(bool val){
    categoryListOrGrid.value=val;
  }

  RxBool coursesBoardsListOrGrid=false.obs;

  void changeCoursesBoardsListOrGrid(bool val){
    coursesBoardsListOrGrid.value=val;
  }

  
  var categoryIndexForColor = 100.obs; // Reactive observable
  
  void changecategoryIndexForColor(int index) {
    categoryIndexForColor.value = index; // Update the reactive value
  }

  var courseAndBoardIndexForColor=0.obs;

  void changecourseAndBoardIndexForColor(int val){
    courseAndBoardIndexForColor.value=val;
  }
 RxList<CourseSectionModel> courseSessionList = <CourseSectionModel>[].obs;

Future<void> fetchCourses() async {
  log('brfore fetching the coursesession');
  List<CourseSectionModel> fetchedCourses = await homeScreenServices.fetchCoursesSection('0');
  log('Fetched Courses: ${fetchedCourses.length}');
  courseSessionList.value = fetchedCourses;  
}   

void changeCourseSessionList(List<CourseSectionModel> _course_section) {
  courseSessionList.assignAll(_course_section);
}

RxBool andTheFollowingFeaturesListOrGrid=false.obs;

  void changeandTheFollowingFeaturesListOrGrid(bool val){
    andTheFollowingFeaturesListOrGrid.value=val;
  }

  RxBool languageListVisibility=false.obs;

  void changelanguageListVisibility(bool val){
    languageListVisibility.value=val;
  }

}