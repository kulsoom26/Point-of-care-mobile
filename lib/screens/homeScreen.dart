// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:test/providers/doctor_profile.dart';
import 'package:test/providers/patient_profile.dart';
import 'package:test/providers/user_provider.dart';
import 'package:test/widgets/searchBar.dart';
import '../widgets/Drawer.dart';
import 'package:provider/provider.dart';
import '../widgets/homeBanner.dart';
import '../widgets/homeGrid.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context).user;
    String img = '';
    if (user.role == 'Doctor') {
      setState(() {
        img = Provider.of<DoctorProvider>(context).doctor.image;
      });
    }
    if (user.role == 'Patient') {
      setState(() {
        img = Provider.of<PatientProvider>(context).patient.image;
      });
    }
    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),
      body: Stack(
        children: <Widget>[
          //header
          const Image(
            image: AssetImage('assets/images/topWaves1.png'),
          ),

          SafeArea(
            child: Container(
              margin: EdgeInsets.only(
                top: deviceSize.height * 0.03,
                left: deviceSize.width * 0.05,
              ),
              child: IconButton(
                icon: const Icon(Icons.menu),
                color: Colors.black,
                onPressed: () => scaffoldKey.currentState!.openDrawer(),
              ),
            ),
          ),
          SafeArea(
            child: Container(
                margin: EdgeInsets.only(
                  left: deviceSize.width * 0.18,
                  top: deviceSize.height * 0.035,
                ),
                child: SizedBox(
                  width: deviceSize.width * 0.3,
                  height: deviceSize.height * 0.07,
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Image(
                      image: AssetImage('assets/images/Point of Care.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                )),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(
                  top: deviceSize.height * 0.035,
                  right: deviceSize.width * 0.055,
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(img),
                ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(
              top: deviceSize.height * 0.15,
              left: deviceSize.width * 0.08,
            ),
            child: Text(
              'Hello,',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: deviceSize.width * 0.04,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: deviceSize.width * 0.08,
              top: deviceSize.height * 0.18,
            ),
            child: Text(
              '${user.name}!👋',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: deviceSize.width * 0.045,
                  fontWeight: FontWeight.bold),
            ),
          ),

          Search(
            leftMargin: deviceSize.width * 0.07,
            topMargin: deviceSize.height * 0.25,
            width: deviceSize.width * 0.85,
            color: Colors.white,
          ),

          const HomeBanner(),
          Container(
            margin: EdgeInsets.only(
                top: deviceSize.height * 0.5, left: deviceSize.width * 0.09),
            child: Text(
              'Services we provide',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: deviceSize.width * 0.056,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          HomeGrid(),
        ],
      ),
    );
  }
}
