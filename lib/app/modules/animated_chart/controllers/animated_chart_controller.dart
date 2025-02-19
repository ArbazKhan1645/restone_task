import 'package:get/get.dart';

import '../../models/bar_models/bar_chart_model.dart';

class AnimatedChartController extends GetxController {
  RxList<ChartData> chartData = <ChartData>[].obs;
  RxBool isAnimating = false.obs;

  void updateData(List<ChartData> newData) {
    isAnimating.value = true;
    chartData.value = newData;
    Future.delayed(const Duration(milliseconds: 500), () {
      isAnimating.value = false;
    });
  }

  void addSampleData() {
    chartData.value = [
      ChartData('Jan', 35),
      ChartData('Feb', 28),
      ChartData('Mar', 42),
      ChartData('Apr', 32),
      ChartData('May', 85),
    ];
  }
}
