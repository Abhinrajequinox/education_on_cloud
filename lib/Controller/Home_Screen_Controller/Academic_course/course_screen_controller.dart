import 'dart:developer';

import 'package:get/get.dart';

class CourseScreenController extends GetxController{

  RxInt colorOfCourseDetailButton=100.obs;

  void changeColorOfCourseDetailButton(int val){
    log('valu is chaning here og valu is ${colorOfCourseDetailButton.value}');
    colorOfCourseDetailButton.value=val;
    log('changed value  is ${colorOfCourseDetailButton.value}');
  }
  RxInt colorOfAddToClassButton=100.obs;

  void changecolorOfAddToClassButtonButton(int val){
    log('valu is chaning here og valu is ${colorOfAddToClassButton.value}');
    colorOfAddToClassButton.value=val;
    log('changed value  is ${colorOfAddToClassButton.value}');
  }
  
}