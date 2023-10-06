// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'homeScreen.dart';
import 'profile.dart';
import 'MessageListScreen.dart';
import 'scheduledAppointment.dart';
import 'setting.dart';

import '../widgets/Drawer.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tab-screen';

  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 2; // Set the default tab index

  // Define your widget options and titles
  static final List<Widget> _widgetOptions = <Widget>[
    Profile(),
    const ScheduleScreen(),
    const HomeScreen(),
    const MessagesScreen(),
    const SettingScreen(),
  ];
  List<String> titles = [
    'Profile',
    'Schedule',
    'Home',
    'Messages',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Material(
        elevation: 30,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
              child: GNav(
                rippleColor: const Color.fromARGB(255, 224, 224, 224),
                hoverColor: const Color.fromARGB(255, 245, 245, 245),
                activeColor: const Color.fromRGBO(53, 60, 85, 1),
                iconSize: 30,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: const Color.fromARGB(255, 245, 245, 245),
                color: const Color(0xFF696969),
                tabs: const [
                  GButton(
                    icon: Icons.person,
                    iconActiveColor: Colors.white,
                    backgroundColor: Color(0xFF7F80D2),
                  ),
                  GButton(
                    icon: Icons.calendar_month,
                    iconActiveColor: Colors.white,
                    backgroundColor: Color(0xFF7F80D2),
                  ),
                  GButton(
                    icon: Icons.home,
                    iconActiveColor: Colors.white,
                    backgroundColor: Color(0xFF7F80D2),
                  ),
                  GButton(
                    icon: Icons.message,
                    iconActiveColor: Colors.white,
                    backgroundColor: Color(0xFF7F80D2),
                  ),
                  GButton(
                    icon: Icons.settings,
                    iconActiveColor: Colors.white,
                    backgroundColor: Color(0xFF7F80D2),
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
