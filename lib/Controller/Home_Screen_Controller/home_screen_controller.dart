import 'package:education_on_cloud/Models/Home/home_screen_model.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController{

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

void changeCourseSessionList(List<CourseSectionModel> _course_section) {
  courseSessionList.assignAll(_course_section);
}

}