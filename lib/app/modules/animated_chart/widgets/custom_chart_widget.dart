// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:redstone_task/app/models/bar_models/bar_chart_model.dart';
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
      final chartData = controller.chartData;
      if (chartData.isEmpty) return const SizedBox.shrink();
      final maxValue = chartData
          .map((e) => e.value)
          .reduce((a, b) => a > b ? a : b);
      return Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: chartData.map((item) => _buildBar(item, maxValue)).toList(),
        ),
      );
    });
  }

  Widget _buildBar(ChartData item, double maxValue) {
    final barHeight = item.value / maxValue * maxHeight;
    final textStyle = const TextStyle(
      fontSize: 12,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TweenAnimationBuilder<double>(
          duration: animationDuration,
          curve: Curves.easeInOut,
          tween: Tween(begin: 0, end: barHeight),
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(item.value.toStringAsFixed(1), style: textStyle),
                const SizedBox(height: 4),
                Container(
                  width: barWidth,
                  height: value,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue.shade300, Colors.blue.shade600],
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
        Text(item.label, style: textStyle),
      ],
    );
  }
}
