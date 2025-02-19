import 'package:get/get.dart';
import 'package:redstone_task/app/routes/app_pages.dart';

class OnboardingPagesController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final RxList<int> selectedOptions = <int>[].obs;

  void nextScreen() {
    if (selectedIndex.value < 3) {
      selectedIndex.value++;
    }
  }

  void updateSelectedOptions(List<int> options) {
    selectedOptions.value = options;
  }

  bool canProceed() {
    if (selectedIndex.value == 3 && selectedOptions.isEmpty) {
      return false;
    }
    return true;
  }

  void handleContinue() {
    if (selectedIndex.value == 3) {
      Get.toNamed(Routes.TINDER);
    } else {
      nextScreen();
    }
  }
}
