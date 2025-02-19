import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tinder_controller.dart';
import '../widgets/tinder_card.dart';

class TinderView extends GetView<TinderController> {
  const TinderView({super.key});
  @override
  Widget build(BuildContext context) {
    return CardStackScreen();
  }
}
