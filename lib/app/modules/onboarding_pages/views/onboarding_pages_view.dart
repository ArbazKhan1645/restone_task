import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redstone_task/app/modules/onboarding_pages/widgets/s2.dart';
import 'package:redstone_task/app/modules/onboarding_pages/widgets/s3.dart';
import 'package:redstone_task/app/modules/onboarding_pages/widgets/s4.dart';
import 'package:redstone_task/app/modules/onboarding_pages/widgets/s5.dart';
import '../controllers/onboarding_pages_controller.dart';

class OnboardingPagesView extends GetView<OnboardingPagesController> {
  const OnboardingPagesView({super.key});
  @override
  Widget build(BuildContext context) {
    return OnboardingScreenBody();
  }
}

class OnboardingScreenBody extends GetView<OnboardingPagesController> {
  OnboardingScreenBody({super.key});

  final List<Widget> screens = [
    const OnboardingScreen2(),
    const OnboardingScreen3(),
    const OnboardingScreen4(),
    const OnboardingScreen5(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _buildBackground(),
            Obx(() => screens[controller.selectedIndex.value]),
            _buildBottomNavigation(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/splash.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: IntrinsicHeight(
        child: Column(
          children: [
            _buildContinueButton(context),
            _buildTermsAndPolicy(),
            SizedBox(height: MediaQuery.of(context).size.width * 0.08),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Obx(
      () => Padding(
        padding:
            controller.selectedIndex.value >= 1
                ? EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.046,
                )
                : EdgeInsets.zero,
        child: GestureDetector(
          onTap: controller.handleContinue,
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
                    "Continue",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Image.asset("assets/icons/arrow.png", height: 26, width: 26),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTermsAndPolicy() {
    return Obx(
      () =>
          controller.selectedIndex.value == 0
              ? Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Column(
                    children: [
                      Text(
                        "By proceeding, you accept our ",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildPolicyLink("Terms of use"),
                          Text(
                            " and ",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          _buildPolicyLink("Privacy policy"),
                        ],
                      ),
                    ],
                  ),
                ),
              )
              : const SizedBox.shrink(),
    );
  }

  Widget _buildPolicyLink(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 12,
        color: const Color(0xff58BE8E),
        fontWeight: FontWeight.w300,
        decoration: TextDecoration.underline,
        decorationColor: const Color(0xff58BE8E),
      ),
    );
  }
}
