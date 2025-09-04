import 'package:get/get.dart';

import '../controllers/add_new_contact_controller.dart';

class AddNewContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewContactController>(
      () => AddNewContactController(),
    );
  }
}
