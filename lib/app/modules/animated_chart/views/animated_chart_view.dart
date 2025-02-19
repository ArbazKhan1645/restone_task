import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_chart_widget.dart';
import '../controllers/animated_chart_controller.dart';

class AnimatedChartView extends GetView<AnimatedChartController> {
  const AnimatedChartView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnimatedChartController>(
      init: AnimatedChartController(),
      builder: (controller) {
        return ChartScreen(controller: controller);
      },
    );
  }
}

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key, required this.controller});

  final AnimatedChartController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomBarChart(controller: controller, barWidth: 60),
        const SizedBox(height: 20),

        GestureDetector(
          onTap: () {
            controller.addSampleData();
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.87,
            height: 63,
            decoration: BoxDecoration(
              color: const Color(0xff58BE8E),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
                right: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(
                    "Load Chart Data",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Image.asset("assets/icons/arrow.png", height: 26, width: 26),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
