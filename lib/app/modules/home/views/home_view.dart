import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../onboarding/on1.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return OnBord1();
  }
}
