import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RoleSelectionController extends GetxController {
  final RxString selectedRole = 'user'.obs;

  void setSelectedRole(String value) {
    selectedRole.value = value;
  }
}