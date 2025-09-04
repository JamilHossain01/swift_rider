import 'package:get/get.dart';

class RoleSelectionController extends GetxController {
  Rx<String> selectedRole = ''.obs;  // Holds selected role (user or driver)
  RxBool isUserLoggedIn = false.obs;  // Check if user is logged in or not

  // Set the selected role
  void setSelectedRole(String role) {
    selectedRole.value = role;
  }

  // Set the login status
  void setLoginStatus(bool status) {
    isUserLoggedIn.value = status;
  }
}
