
import 'package:get/get.dart';

class SignInController extends GetxController {
  // Checkbox state
  var rememberMe = false.obs;

  // Toggle function
  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }
}
