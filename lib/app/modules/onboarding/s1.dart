

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sc1 extends StatefulWidget {
  const Sc1({super.key});

  @override
  State<Sc1> createState() => _Sc1State();
}

class _Sc1State extends State<Sc1> {
  @override
  void initState() {
    super.initState();
    logEvent();
  }

  void logEvent() async {

  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.017,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: MediaQuery.of(context).size.height * 0.013,
            ),
            child: Image.asset("assets/icons/alno_splash.png"),
          ),
          Image.asset(
            "assets/icons/a1.png",
            height: MediaQuery.of(context).size.height * 0.11,
          ),
          Text(
            "Powered by",
            style: GoogleFonts.montserrat(fontSize: 20),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.011,
              left: 30,
              right: 30,
            ),
            child: Image.asset(
              "assets/icons/a2.png",
              height: MediaQuery.of(context).size.height * 0.27,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Image.asset(
            "assets/icons/a3.png",
            height: MediaQuery.of(context).size.height * 0.085,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
