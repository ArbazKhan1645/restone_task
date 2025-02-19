import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tinder_controller.dart';
import '../widgets/tinder_card.dart';

class TinderView extends GetView<TinderController> {
  const TinderView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TinderController>(
      init: TinderController(),
      builder: (controller) {
        return TinderViewBody(controller: controller);
      },
    );
  }
}

class TinderViewBody extends StatelessWidget {
  const TinderViewBody({super.key, required this.controller});
  final TinderController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/splash.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            AnimatedCardStack(controller: controller),
          ],
        ),
      ),
    );
  }
}
