// import 'package:alno_ai/utils/utils.dart';
// import 'package:alno_ai/view/components/CircularProgressIndicatorwithValue.dart';
//  
// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// import '../../../AppFlyerManager.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   int selectedIndex = 0;
//   List images = [
//     "assets/images/onboarding1.png",
//     "assets/images/onboarding2.png",
//     "assets/images/onboarding3.png",
//   ];

//   List titles = [
//     "Introduction to\nALNO_AI",
//     "Explore categories of all topics",
//     "Getting started with\nALNO-AI",
//   ];

//   List descriptions = [
//     "Meet ALNO, your personal AI language model & discover the benefits of using Chatbot_AI for language tasks.",
//     "Ask question to ALNO_AI with help of different categories and get answer that you want.",
//     "Try out different language tasks and modes.",
//   ];


//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     logEvent();
//   }

//   void logEvent() async {
//     await AppsFlyerManger.logPageView("onboarding_start", "onboarding_start");
//     await FacebookAppEvents().logViewContent(id: "onboarding_start",  type: "page");
//   }

//   @override
//   Widget build(BuildContext context) {
//     var textTheme = Theme.of(context).textTheme;
//     return Scaffold(
//       backgroundColor: resolveCustomColor(
//         context: context,
//         lightColor: const Color(0xff17C3CE),
//         darkColor: const Color(0xff272727),
//       ),
//       body: Stack(
//         children: [
//           Align(
//             alignment: Alignment.topCenter,
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 600),
//               child: SafeArea(
//                 child: LayoutBuilder(builder: (context, constraints) {
//                   return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: constraints.maxHeight * 0.15,
//                         ),
//                         Image.asset(
//                           images[selectedIndex],
//                           height: constraints.maxHeight * 0.4,
//                         ),
//                         SizedBox(
//                           height: constraints.maxHeight * 0.05,
//                         ),
//                         Text(titles[selectedIndex],
//                             style: textTheme.headlineLarge?.copyWith(
//                               fontSize: 26,
//                             )),
//                         const SizedBox(height: 20),
//                         SizedBox(
//                           width: constraints.maxWidth * 0.9,
//                           child: Text(descriptions[selectedIndex],
//                               style: textTheme.bodySmall?.copyWith(
//                                 fontSize: 13,
//                               )),
//                         ),
//                         SizedBox(height: constraints.maxHeight * 0.1),
//                         SizedBox(
//                           width: constraints.maxWidth * 0.9,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               AnimatedSmoothIndicator(
//                                 activeIndex: selectedIndex,
//                                 count: 3,
//                                 effect: ExpandingDotsEffect(
//                                   activeDotColor: Colors.white,
//                                   dotColor: Colors.white.withOpacity(0.5),
//                                   dotHeight: 8,
//                                   dotWidth: 8,
//                                   spacing: 8,
//                                 ),
//                               ),
//                               Circularprogressindicatorwithvalue(
//                                 progressValue: (selectedIndex + 1) / 3,
//                                 onPressed: () {
//                                   if (selectedIndex < 2) {
//                                     setState(() {
//                                       selectedIndex++;
//                                     });
//                                   } else {
//                                     // Navigator.pushNamed(context, '/home');
//                                   }
//                                 },
//                               ),
//                             ],
//                           ),
//                         )
//                       ]);
//                 }),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 30,
//             right: 30,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                     onPressed: () {},
//                     child: Row(
//                       children: [
//                         Text(
//                           "Skip",
//                           style: textTheme.headlineSmall,
//                         ),
//                         const SizedBox(width: 10),
//                         Image.asset(
//                           "assets/images/Arrow-1.png",
//                           height: 10,
//                         ),
//                         Image.asset(
//                           "assets/images/Arrow.png",
//                           height: 20,
//                         ),
//                       ],
//                     )),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }