// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../widgets/upload.dart';

class UploadScreen extends StatelessWidget {
  static const routeName = '/upload-screen';

  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          const Image(
            image: AssetImage('assets/images/eclipse.png'),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 0.0,
              top: deviceSize.height * 0.08,
              right: deviceSize.width * 0.04,
            ),
            child: const Align(
              alignment: Alignment.topRight,
              child: Image(
                image: AssetImage('assets/images/authLogo.png'),
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: const Upload(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: deviceSize.height * 0.09,
              left: deviceSize.width * 0.06,
            ),
            child: SizedBox(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: deviceSize.width * 0.07,
                ),
                color: const Color(0xFF8587DC),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
