
import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sc5 extends StatefulWidget {
  const Sc5({super.key});

  @override
  Sc5State createState() => Sc5State();
}

class Sc5State extends State<Sc5> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  List<int> selectedIndices = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();

    logEvent();
  }

  void logEvent() async {

    // await FacebookAppEvents()
    //     .logViewContent(id: "onboarding_screen_4", type: "page");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.07,
          ),
          Text(
            "What is your goal?",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          _buildAnimatedRow(0, "Get help with work tasks", 0.8),
          const SizedBox(height: 16),
          _buildAnimatedRow(1, "Increase my income", 0.6),
          const SizedBox(height: 16),
          _buildAnimatedRow(2, "Get Assistance with daily tasks", 1.9),
          const SizedBox(height: 16),
          _buildAnimatedRow(3, "Get help with homework", 0.6),
          const SizedBox(height: 16),
          _buildAnimatedRow(4, "Learn or translate language", 1.6),
          const SizedBox(height: 16),
          _buildAnimatedRow(5, "Improve my skills", 1.0),
          const SizedBox(height: 16),
          _buildAnimatedRow(6, "Chat with bots", 0.4),
          const SizedBox(height: 16),
          _buildAnimatedRow(7, "Other", 0.1),
        ],
      ),
    );
  }

  Widget _buildAnimatedRow(int index, String label, double widthFactor) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: _buildRow(
          index: index,
          label: label,
          isSelected: selectedIndices.contains(index),
          widthFactor: widthFactor,
        ),
      ),
    );
  }

  Widget _buildRow({
    required int index,
    required String label,
    required bool isSelected,
    required double widthFactor,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedIndices.contains(index)) {
            selectedIndices.remove(index);
          } else {
            selectedIndices.add(index);
          }
        });
      },
      child: Transform.scale(
        scale: isSelected ? 1.05 : 1.0,
        child: Row(
          children: [
            const Expanded(
              child: DottedLine(
                dashColor: Color(0xff29BF8D),
              ),
            ),
            Expanded(
              flex: (widthFactor * 10).toInt(),
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width * widthFactor,
                decoration: BoxDecoration(
                  color:
                      isSelected ? const Color(0xff29BF8D) : Colors.transparent,
                  border: Border.all(
                    color: const Color(0xff29BF8D),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      height: 29,
                      width: 29,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.black : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xff29BF8D)),
                      ),
                      child: isSelected
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Image.asset(
                                  "assets/icons/check.png",
                                ),
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: DottedLine(
                dashColor: Color(0xff29BF8D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
