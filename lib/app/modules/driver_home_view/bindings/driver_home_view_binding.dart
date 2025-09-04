import 'package:get/get.dart';

import '../controllers/driver_home_view_controller.dart';

class DriverHomeViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverHomeViewController>(
      () => DriverHomeViewController(),
    );
  }
}
