import 'package:get/get.dart';

class TheoryVideoController extends GetxController {
  var currentVideoUrl = ''.obs; // Reactive variable for video URL
  var currentVideoName = ''.obs; // Reactive variable for video name

  void updateVideo(String url, String name) {
    currentVideoUrl.value = url; // Update video URL
    currentVideoName.value = name; // Update video name
  }

  void resetVideo() {
    currentVideoUrl.value = '';
    currentVideoName.value = '';
  }

  RxBool favIcon = false.obs;

  void changeFavIcon(bool val) {
    favIcon.value = val;
  }
}
