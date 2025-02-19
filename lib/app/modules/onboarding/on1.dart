import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redstone_task/app/modules/onboarding/s3.dart';
import 'package:redstone_task/app/modules/onboarding/s4.dart';
import 'package:redstone_task/app/modules/onboarding/s5.dart';


class OnBord1 extends StatefulWidget {
  const OnBord1({super.key});

  @override
  State<OnBord1> createState() => _OnBord1State();
}

class _OnBord1State extends State<OnBord1> {
  int selectedIndex = 0;

  final GlobalKey<Sc5State> _sc5Key = GlobalKey<Sc5State>();
  late List<Widget> display;

  @override
  void initState() {
    super.initState();
    display = [const Sc3(), const Sc4(), Sc5(key: _sc5Key)];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    selectedIndex >= 1
                        ? "assets/icons/bg2.png"
                        : "assets/images/splash.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            display[selectedIndex],
            Align(
              alignment: Alignment.bottomCenter,
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          selectedIndex >= 1
                              ? EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.046,
                              )
                              : const EdgeInsets.all(0),
                      child: GestureDetector(
                        onTap: () async {
                          if (selectedIndex == 2) {
                            if (_sc5Key.currentState?.selectedIndices.isEmpty ??
                                true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Please select at least one option before continuing.",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              return;
                            }
                          }

                          setState(() {
                            selectedIndex++;
                          });
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
                                  "Continue",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Image.asset(
                                  "assets/icons/arrow.png",
                                  height: 26,
                                  width: 26,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    selectedIndex == 0
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
                                    Text(
                                      "Terms of use",
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: const Color(0xff58BE8E),
                                        fontWeight: FontWeight.w300,
                                        decoration: TextDecoration.underline,
                                        decorationColor: const Color(
                                          0xff58BE8E,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      " and ",
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Text(
                                      "Privacy policy",
                                      style: GoogleFonts.inter(
                                        color: const Color(0xff58BE8E),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        decoration: TextDecoration.underline,
                                        decorationColor: const Color(
                                          0xff58BE8E,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                        : Container(),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.08),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
