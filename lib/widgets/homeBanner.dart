// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:test/screens/diagnosis.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        top: deviceSize.height * 0.35,
        left: deviceSize.width * 0.07,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
      width: deviceSize.width * 0.85,
      height: deviceSize.height * 0.13,
      child: Row(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '    Get a second opinion \n    within a minute!!!',
              style: TextStyle(
                color: Colors.white,
                fontSize: deviceSize.width * 0.04,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              shape: const StadiumBorder(),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Diagnosis(),
                ),
              );
            },
            child: Text(
              'Continue',
              style: TextStyle(
                color: const Color(0xFF7F80D2),
                fontSize: deviceSize.width * 0.042,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
