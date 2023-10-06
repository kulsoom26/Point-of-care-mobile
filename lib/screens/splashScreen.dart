// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../screens/authentication.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            bottom: animate ? deviceSize.height * 0.28 : -300,
            right: animate ? deviceSize.width * 0.09 : -300,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150),
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF200E32),
                    Color(0xFF8587DC),
                    Color(0xFFB9A0E6),
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              top: animate ? 370 : -100,
              left: animate ? 40 : -100,
              child: SizedBox(
                width: 300.0,
                height: 150.0,
                child: Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: const Color.fromARGB(255, 252, 171, 198),
                  child: const Text(
                    'Point-Of-Care',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                ),
              )),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            top: animate ? 420 : -200,
            left: animate ? 120 : -300,
            child: const Text(
              'Diagnostic system',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      animate = true;
    });
    await Future.delayed(const Duration(milliseconds: 5000));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const Authentication()));
  }
}
