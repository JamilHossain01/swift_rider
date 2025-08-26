
import 'package:get/get.dart';

class PasswordController extends GetxController {
  var password = ''.obs;
  var strength = 0.obs;

  void checkPasswordStrength(String value) {
    password.value = value;
    if (value.length >= 12) {
      strength.value = 5; // Very strong
    } else if (value.length >= 9) {
      strength.value = 4;
    } else if (value.length >= 6) {
      strength.value = 3;
    } else if (value.length >= 3) {
      strength.value = 2;
    } else if (value.isNotEmpty) {
      strength.value = 1;
    } else {
      strength.value = 0;
    }
  }
}
