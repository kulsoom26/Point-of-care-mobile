// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:test/screens/appointment.dart';
import '../widgets/resultLabels.dart';
import '../screens/tabScreen.dart';

class ResultScreen extends StatelessWidget {
  static const routeName = '/result-screen';

  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: deviceSize.height * 0.1,
              left: deviceSize.width * 0.37,
            ),
            child: const Text(
              'Result',
              style: TextStyle(
                  color: Color(0xFF200e32),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 30),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: deviceSize.height * 0.12, left: deviceSize.width * 0.85),
            child: const Icon(
              Icons.download,
              size: 30,
              color: Color(0xFF200e32),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height * 0.9,
              width: deviceSize.width,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: deviceSize.height * 0.15, bottom: 10),
                      child: Image(
                        image: const AssetImage('assets/images/result.png'),
                        width: deviceSize.width,
                        height: deviceSize.height * 0.35,
                      ),
                    ),
                    Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: const ResultLabels(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: deviceSize.width * 0.5,
                  height: deviceSize.height * 0.1,
                  child: ElevatedButton.icon(
                    label: const Text('Home'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8587DC),
                        textStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const TabsScreen(),
                      ));
                    },
                    icon: const Icon(
                      Icons.home,
                      size: 26,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: deviceSize.width * 0.5,
                  height: deviceSize.height * 0.1,
                  child: ElevatedButton.icon(
                    label: const Text('Book appointment'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFACADFF),
                        textStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AppointmentScreen(),
                      ));
                    },
                    icon: const Icon(
                      Icons.location_on,
                      size: 26,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                top: deviceSize.height * 0.1, left: deviceSize.width * 0.07),
            child: SizedBox(
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 30,
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
