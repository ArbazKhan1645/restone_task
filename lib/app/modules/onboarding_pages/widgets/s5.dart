import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen5 extends StatefulWidget {
  const OnboardingScreen5({super.key});

  @override
  OnboardingScreen5State createState() => OnboardingScreen5State();
}

class OnboardingScreen5State extends State<OnboardingScreen5>
    with SingleTickerProviderStateMixin {
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
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
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
          SizedBox(height: MediaQuery.of(context).size.width * 0.07),
          Text(
            "What is your goal?",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 25),
          _buildAnimatedRow(0, "Find new friends nearby", 0.8),
          const SizedBox(height: 16),
          _buildAnimatedRow(1, "Meet like-minded people", 0.6),
          const SizedBox(height: 16),
          _buildAnimatedRow(2, "Find a gym or sports buddy", 1.9),
          const SizedBox(height: 16),
          _buildAnimatedRow(3, "Connect with travel partners", 0.6),
          const SizedBox(height: 16),
          _buildAnimatedRow(4, "Join social events & hangouts", 1.6),
          const SizedBox(height: 16),
          _buildAnimatedRow(5, "Meet new people in a new city", 1.0),
          const SizedBox(height: 16),
          _buildAnimatedRow(6, "Find study or work buddies", 0.4),
          const SizedBox(height: 16),
          _buildAnimatedRow(7, "Just here to vibe & chat", 0.4),
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
            const Expanded(child: DottedLine(dashColor: Color(0xff29BF8D))),
            Expanded(
              flex: (widthFactor * 10).toInt(),
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width * widthFactor,
                decoration: BoxDecoration(
                  color:
                      isSelected ? const Color(0xff29BF8D) : Colors.transparent,
                  border: Border.all(color: const Color(0xff29BF8D)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.white,
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
                      child:
                          isSelected
                              ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Image.asset("assets/icons/check.png"),
                                ),
                              )
                              : null,
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: DottedLine(dashColor: Color(0xff29BF8D))),
          ],
        ),
      ),
    );
  }
}
