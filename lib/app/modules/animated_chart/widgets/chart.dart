// chart_controller.dart
import 'package:get/get.dart';
// custom_bar_chart.dart
import 'package:flutter/material.dart';

import '../controllers/animated_chart_controller.dart';

class CustomBarChart extends StatelessWidget {
  final AnimatedChartController controller;
  final double maxHeight;
  final double barWidth;
  final Duration animationDuration;

  const CustomBarChart({
    super.key,
    required this.controller,
    this.maxHeight = 200,
    this.barWidth = 40,
    this.animationDuration = const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final data = controller.chartData;
      if (data.isEmpty) return const SizedBox.shrink();

      final maxValue = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);

      return Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: data.map((item) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TweenAnimationBuilder<double>(
                  duration: animationDuration,
                  curve: Curves.easeInOut,
                  tween: Tween(
                    begin: 0,
                    end: item.value / maxValue * maxHeight,
                  ),
                  builder: (context, value, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          item.value.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: barWidth,
                          height: value,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.blue.shade300,
                                Colors.blue.shade600,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  item.label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      );
    });
  }
}

class ChartScreen extends StatelessWidget {
  ChartScreen({super.key});

  final AnimatedChartController controller = Get.put(AnimatedChartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Animated Chart'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomBarChart(
              controller: controller,
              barWidth: 60,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.addSampleData();
              },
              child: const Text('Load Sample Data'),
            ),
          ],
        ),
      ),
    );
  }
}
