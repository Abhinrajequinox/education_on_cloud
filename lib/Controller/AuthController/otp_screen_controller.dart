import 'package:get/get_rx/src/rx_types/rx_types.dart';

class OtpScreenController {

  // worng oto text shown
  Rx<bool> otpCheck = false.obs;

  void changeOtpCheck(bool val){
    otpCheck.value=val;
  }

  var enterdVal=''.obs;
  
  void changingEnterdVal(String val){
    enterdVal.value=val;

  }

}