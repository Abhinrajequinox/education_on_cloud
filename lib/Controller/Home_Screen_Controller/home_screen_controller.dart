import 'package:get/get.dart';

class HomeScreenController extends GetxController{

  RxBool categoryListOrGrid=false.obs;

  void changecategoryListOrGrid(bool val){
    categoryListOrGrid.value=val;
  }

  RxBool coursesBoardsListOrGrid=false.obs;

  void changeCoursesBoardsListOrGrid(bool val){
    coursesBoardsListOrGrid.value=val;
  }
  
}