// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../modules/animated_chart/bindings/animated_chart_binding.dart';
import '../modules/animated_chart/views/animated_chart_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/tinder/bindings/tinder_binding.dart';
import '../modules/tinder/views/tinder_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ANIMATED_CHART,
      page: () => const AnimatedChartView(),
      binding: AnimatedChartBinding(),
    ),
    GetPage(
      name: _Paths.TINDER,
      page: () => const TinderView(),
      binding: TinderBinding(),
    ),
  ];
}
