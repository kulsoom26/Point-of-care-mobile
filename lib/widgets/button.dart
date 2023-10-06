import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final double buttonTextSize = deviceSize.width * 0.025;
    final double submitButtonWidth = deviceSize.width * 0.85;
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFB9A0E6),
                Color(0xFF8587DC),
              ],
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Container(
            width: submitButtonWidth,
            height: deviceSize.height * 0.065,
            alignment: Alignment.center,
            child: Center(
              child: Text(
                'Submit',
                style: TextStyle(
                  fontSize: buttonTextSize * 1.5,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
