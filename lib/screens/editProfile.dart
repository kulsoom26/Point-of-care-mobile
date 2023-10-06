import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/widgets/editProfileForm.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/edit-profile-screen';

  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            //header
            const Image(
              image: AssetImage('assets/images/topWaves1.png'),
            ),

            // Title
            Container(
              margin: EdgeInsets.only(
                top: deviceSize.height * 0.1,
                left: deviceSize.width * 0.2,
              ),
              child: Text(
                'Edit Profile',
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
                  Navigator.pop(context);
                },
              ),
            ),

            SizedBox(
              height: deviceSize.height * 1.45,
              width: deviceSize.width,
              child: SafeArea(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: deviceSize.width > 600 ? 1 : 1,
                      child: const EditProfileForm(),
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
