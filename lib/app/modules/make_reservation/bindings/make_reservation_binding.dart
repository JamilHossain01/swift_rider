import 'package:get/get.dart';

import '../controllers/make_reservation_controller.dart';

class MakeReservationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MakeReservationController>(
      () => MakeReservationController(),
    );
  }
}
