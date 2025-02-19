import 'package:get/get.dart';

import '../controllers/onboarding_pages_controller.dart';

class OnboardingPagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingPagesController>(
      () => OnboardingPagesController(),
    );
  }
}
