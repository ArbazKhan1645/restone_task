import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // usePathUrlStrategy();
  FlutterError.onError = (FlutterErrorDetails details) {
    // AppLogger.error(details.toString());
    FlutterError.presentError(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    // AppLogger.error('Async error: $error');
    return true;
  };

  // ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
  //   return GlobalErrorWidget(errorDetails: errorDetails);
  // };
  await _initializeApp();
  runApp(const MyApp());
}

Future<void> _initializeApp() async {
  // initDependencies();
  // AppLogger.info('initialized');
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trade my device',
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: widget!,
        );
      },
      // theme: lightThemeData(context),
      themeMode: ThemeMode.light,
      useInheritedMediaQuery: true,
      defaultTransition: Transition.fadeIn,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      enableLog: false,
      supportedLocales: const [Locale('en', 'US')],
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      transitionDuration: const Duration(milliseconds: 200),
      initialRoute: AppPages.INITIAL,
      navigatorObservers: [GetObserver()],
      getPages: AppPages.routes,
    );
  }
}
