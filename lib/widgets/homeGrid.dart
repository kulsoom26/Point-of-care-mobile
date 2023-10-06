// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/user_provider.dart';
import 'package:test/services/auth_services.dart';
import '../helper/gridItem.dart';
import '../screens/diagnosis.dart';
import '../screens/aboutUs.dart';
import '../screens/nearbyDoctors.dart';
import '../screens/appointment.dart';
import '../screens/reportScreen.dart';

// ignore: use_key_in_widget_constructors
class HomeGrid extends StatefulWidget {
  @override
  State<HomeGrid> createState() => _HomeGridState();
}

class _HomeGridState extends State<HomeGrid> {
  List<GridItem> _items = [];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context).user;
    int index = 0;
    if (user.role == 'Doctor') {
      index = 3;
      _items = [
        GridItem(
          id: 'g1',
          title: 'Diagnosis',
          icon: 'assets/images/diagnostic.png',
        ),
        GridItem(
          id: 'g4',
          title: 'My Reports',
          icon: 'assets/images/report.png',
        ),
        GridItem(
          id: 'g5',
          title: 'About Us',
          icon: 'assets/images/about.png',
        ),
      ];
    } else {
      index = 5;
      _items = [
        GridItem(
          id: 'g1',
          title: 'Diagnosis',
          icon: 'assets/images/diagnostic.png',
        ),
        GridItem(
          id: 'g2',
          title: 'Appointment',
          icon: 'assets/images/appointment.png',
        ),
        GridItem(
          id: 'g3',
          title: 'Nearby Doctors',
          icon: 'assets/images/location.png',
        ),
        GridItem(
          id: 'g4',
          title: 'My Reports',
          icon: 'assets/images/report.png',
        ),
        GridItem(
          id: 'g5',
          title: 'About Us',
          icon: 'assets/images/about.png',
        ),
      ];
    }
    return Center(
      child: Container(
        width: deviceSize.width * 0.85,
        margin: EdgeInsets.only(top: deviceSize.height * 0.53),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: GridView.count(
          mainAxisSpacing: deviceSize.width * 0.03,
          crossAxisCount: 3,
          children: List.generate(index, (index) {
            return GestureDetector(
              onTap: () {
                if (_items[index].title == 'Diagnosis') {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Diagnosis()),
                  );
                }
                if (_items[index].title == 'Appointment') {
                  final AuthService authService = AuthService();

                  authService.getDoctor(context: context);

                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const AppointmentScreen()),
                  );
                }
                if (_items[index].title == 'Nearby Doctors') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const NearbyDoctors()),
                  );
                }
                if (_items[index].title == 'My Reports') {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ReportScreen()),
                  );
                }
                if (_items[index].title == 'About Us') {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AboutUs()),
                  );
                }
              },
              child: Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: deviceSize.height * 0.018),
                      child: Image(
                        image: AssetImage(_items[index].icon),
                        width: deviceSize.width * 0.2067,
                        height: deviceSize.width * 0.1097,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: deviceSize.height * 0.008),
                      child: Text(
                        _items[index].title,
                        style: TextStyle(
                          fontSize: deviceSize.width * 0.03,
                          color: const Color(0xFF8081D4),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
