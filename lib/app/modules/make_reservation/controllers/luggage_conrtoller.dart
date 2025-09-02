import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../wigets/luggae_card.dart';

class LuggageController extends GetxController {
  var luggageTypes = <FirstXType>[
    FirstXType(label: 'Carry-On'),
    FirstXType(label: 'Checked'),
    FirstXType(label: 'Oversize'),
  ].obs; // Using `.obs` for reactive list

  // Expandable state
  var isExpanded = false.obs;

  void increment(FirstXType luggageType) {
    luggageType.count++;
    update(); // Update the UI
  }

  void decrement(FirstXType luggageType) {
    if (luggageType.count > 0) luggageType.count--;
    update(); // Update the UI
  }

  int get totalLuggage => luggageTypes.fold<int>(0, (sum, item) => sum + item.count);
}
