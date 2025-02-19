import 'package:get/get.dart';

import '../controllers/tinder_controller.dart';

class TinderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TinderController>(
      () => TinderController(),
    );
  }
}
