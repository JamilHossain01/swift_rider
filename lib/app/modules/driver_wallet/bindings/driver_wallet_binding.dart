import 'package:get/get.dart';

import '../controllers/driver_wallet_controller.dart';

class DriverWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverWalletController>(
      () => DriverWalletController(),
    );
  }
}
