import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../widgets/chart.dart';
import '../controllers/animated_chart_controller.dart';

class AnimatedChartView extends GetView<AnimatedChartController> {
  const AnimatedChartView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChartScreen();
  }
}
