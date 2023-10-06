import 'package:flutter/material.dart';
import '../widgets/diagnosisForm.dart';

class Diagnosis extends StatelessWidget {
  static const routeName = '/diagnosis-screen';

  const Diagnosis({super.key});

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
              top: deviceSize.height * 0.0933,
              right: deviceSize.width * 0.0467,
            ),
            child: Container(
              width: deviceSize.width * 0.3,
              height: deviceSize.height * 0.07,
              margin: EdgeInsets.only(left: deviceSize.width * 0.7),
              child: const Align(
                alignment: Alignment.topRight,
                child: Image(
                  image: AssetImage('assets/images/Point of Care.png'),
                  fit: BoxFit.contain,
                ),
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
                      child: const DiagnosisForm(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: deviceSize.height * 0.0973,
              left: deviceSize.width * 0.0533,
            ),
            child: SizedBox(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: deviceSize.width * 0.08,
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
