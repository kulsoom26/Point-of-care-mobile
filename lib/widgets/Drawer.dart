// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:test/providers/doctor_profile.dart';
import 'package:test/providers/patient_profile.dart';
import 'package:test/providers/user_provider.dart';
import 'package:test/screens/appointment.dart';
import 'package:test/screens/setting.dart';
import 'package:test/screens/tabScreen.dart';
import 'package:test/services/auth_services.dart';

import 'package:provider/provider.dart';

import '../screens/reportScreen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void logout(BuildContext context) {
    AuthService().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    // ignore: no_leading_underscores_for_local_identifiers
    final TextEditingController _imageController = TextEditingController();
    if (user.role == 'Doctor') {
      _imageController.text = Provider.of<DoctorProvider>(context).doctor.image;
    }
    if (user.role == 'Patient') {
      _imageController.text =
          Provider.of<PatientProvider>(context).patient.image;
    }
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFFB9A0E6),
                    Color(0xFF8587DC),
                    Color(0xFF200E32),
                  ]),
            ),
            accountName: Text(
              user.name,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            accountEmail: Text(
              user.email,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(_imageController.text),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
              size: 32,
              color: Color(0xFF7F80D2),
            ),
            title: const Text(
              "Home",
              style: TextStyle(fontSize: 16, fontFamily: 'League Spartan'),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(TabsScreen.routeName);
            },
          ),
          if (user.role == 'Patient')
            ListTile(
              leading: const Icon(
                Icons.man_sharp,
                color: Color(0xFF7F80D2),
                size: 32,
              ),
              title: const Text(
                "Doctor",
                style: TextStyle(fontSize: 16, fontFamily: 'League Spartan'),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(AppointmentScreen.routeName);
              },
            ),
          ListTile(
            leading: const Icon(
              Icons.inventory_sharp,
              color: Color(0xFF7F80D2),
              size: 30,
            ),
            title: const Text(
              "Reports",
              style: TextStyle(fontSize: 16, fontFamily: 'League Spartan'),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ReportScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.privacy_tip_outlined,
              color: Color(0xFF7F80D2),
              size: 30,
            ),
            title: const Text(
              "FAQ",
              style: TextStyle(fontSize: 16, fontFamily: 'League Spartan'),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Color(0xFF7F80D2),
              size: 30,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(fontSize: 16, fontFamily: 'League Spartan'),
            ),
            onTap: () => logout(context),
          ),
        ],
      ),
    );
  }
}
