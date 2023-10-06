import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/screens/tabScreen.dart';
import '../widgets/profileData.dart';
import '../screens/editProfile.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile-screen';
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Profile({super.key});
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            //header
            const Image(
              image: AssetImage('assets/images/eclipse.png'),
            ),

            // Title
            Container(
              margin: EdgeInsets.only(
                top: deviceSize.height * 0.1,
                left: deviceSize.width * 0.2,
              ),
              child: Text(
                'User Profile',
                style: TextStyle(
                  color: const Color(0xff200E32).withOpacity(0.8),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: deviceSize.height * 0.09,
                left: deviceSize.width * 0.05,
              ),
              child: CupertinoNavigationBarBackButton(
                color: const Color(0xFF8587DC),
                onPressed: () {
                  Navigator.of(context).pushNamed(TabsScreen.routeName);
                },
              ),
            ),

            Container(
              margin: EdgeInsets.only(
                  left: deviceSize.width * 0.8, top: deviceSize.width * 0.18),
              child: IconButton(
                icon: const Icon(Icons.edit_note_sharp),
                color: const Color(0xFF8587DC),
                iconSize: 30,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EditProfile())),
              ),
            ),

            SizedBox(
              height: deviceSize.height * 1.15,
              width: deviceSize.width,
              child: SafeArea(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: deviceSize.width > 600 ? 1 : 1,
                      child: const ProfileData(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
