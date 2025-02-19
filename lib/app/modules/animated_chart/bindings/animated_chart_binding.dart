import 'package:get/get.dart';

import '../controllers/animated_chart_controller.dart';

class AnimatedChartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnimatedChartController>(
      () => AnimatedChartController(),
    );
  }
}
