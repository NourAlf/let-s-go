import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DropdownController extends GetxController {
  var selectedItemId = Rxn<String?>();

  void setSelectedItemId(String id) {
    selectedItemId.value = id;
  }
}
