import 'package:get/get.dart';

import '../modules/animated_chart/bindings/animated_chart_binding.dart';
import '../modules/animated_chart/views/animated_chart_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/onboarding_pages/bindings/onboarding_pages_binding.dart';
import '../modules/onboarding_pages/views/onboarding_pages_view.dart';
import '../modules/tinder/bindings/tinder_binding.dart';
import '../modules/tinder/views/tinder_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING_PAGES;

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
    GetPage(
      name: _Paths.ONBOARDING_PAGES,
      page: () => const OnboardingPagesView(),
      binding: OnboardingPagesBinding(),
    ),
  ];
}
