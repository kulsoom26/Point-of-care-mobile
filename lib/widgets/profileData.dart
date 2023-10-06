import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/doctor_profile.dart';
import 'package:test/providers/patient_profile.dart';
import 'package:test/providers/user_provider.dart';

class ProfileData extends StatefulWidget {
  const ProfileData({Key? key});

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final deviceSize = MediaQuery.of(context).size;
    var type;
    if (user.role == 'Doctor') {
      type = Provider.of<DoctorProvider>(context).doctor;
    }
    if (user.role == 'Patient') {
      type = Provider.of<PatientProvider>(context).patient;
    }
    return Container(
      margin: EdgeInsets.only(
          top: deviceSize.height * 0.14, left: deviceSize.width * 0.07),
      child: Column(
        children: <Widget>[
          Container(
            width: deviceSize.width * 0.3,
            height: deviceSize.width * 0.3,
            margin: EdgeInsets.only(right: deviceSize.width * 0.04),
            child: CircleAvatar(
              backgroundImage: NetworkImage(type.image),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: deviceSize.height * 0.015, left: deviceSize.width * 0.015),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.account_circle_outlined,
                  color: Color(0xFF8587dc),
                  size: deviceSize.width * 0.07,
                ),
                Container(
                  width: deviceSize.width * 0.6,
                  margin: EdgeInsets.only(left: deviceSize.width * 0.04),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: deviceSize.width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    initialValue: user.name,
                    readOnly: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: deviceSize.height * 0.01, left: deviceSize.width * 0.015),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.email_outlined,
                  color: Color(0xFF8587dc),
                  size: deviceSize.width * 0.07,
                ),
                Container(
                  width: deviceSize.width * 0.6,
                  margin: EdgeInsets.only(left: deviceSize.width * 0.04),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: deviceSize.width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    initialValue: user.email,
                    readOnly: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: deviceSize.height * 0.01, left: deviceSize.width * 0.015),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.group,
                  color: Color(0xFF8587dc),
                  size: deviceSize.width * 0.07,
                ),
                Container(
                  width: deviceSize.width * 0.6,
                  margin: EdgeInsets.only(left: deviceSize.width * 0.04),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      labelStyle: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: deviceSize.width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    initialValue: type.gender,
                    readOnly: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: deviceSize.height * 0.01, left: deviceSize.width * 0.015),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.phone_enabled,
                  color: Color(0xFF8587dc),
                  size: deviceSize.width * 0.07,
                ),
                Container(
                  width: deviceSize.width * 0.6,
                  margin: EdgeInsets.only(left: deviceSize.width * 0.04),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Contact',
                      labelStyle: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: deviceSize.width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    initialValue: type.contact,
                    readOnly: true,
                  ),
                ),
              ],
            ),
          ),
          if (user.role == 'Patient')
            Container(
              margin: EdgeInsets.only(
                  top: deviceSize.height * 0.01,
                  left: deviceSize.width * 0.015),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.group,
                    color: Color(0xFF8587dc),
                    size: deviceSize.width * 0.07,
                  ),
                  Container(
                    width: deviceSize.width * 0.6,
                    margin: EdgeInsets.only(left: deviceSize.width * 0.04),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Age',
                        labelStyle: TextStyle(
                          fontFamily: 'League Spartan',
                          fontSize: deviceSize.width * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.04,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'League Spartan',
                      ),
                      initialValue: type.age,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
            ),
          if (user.role == 'Doctor')
            Container(
              margin: EdgeInsets.only(
                  top: deviceSize.height * 0.01,
                  left: deviceSize.width * 0.015),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.app_registration_rounded,
                    color: Color(0xFF8587dc),
                    size: deviceSize.width * 0.07,
                  ),
                  Container(
                    width: deviceSize.width * 0.6,
                    margin: EdgeInsets.only(left: deviceSize.width * 0.04),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Specialization',
                        labelStyle: TextStyle(
                          fontFamily: 'League Spartan',
                          fontSize: deviceSize.width * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.04,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'League Spartan',
                      ),
                      initialValue: type.specialization,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
            ),
          if (user.role == 'Doctor')
            Container(
              margin: EdgeInsets.only(
                  top: deviceSize.height * 0.01,
                  left: deviceSize.width * 0.015),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.app_registration_rounded,
                    color: Color(0xFF8587dc),
                    size: deviceSize.width * 0.07,
                  ),
                  Container(
                    width: deviceSize.width * 0.6,
                    margin: EdgeInsets.only(left: deviceSize.width * 0.04),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          fontFamily: 'League Spartan',
                          fontSize: deviceSize.width * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.04,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'League Spartan',
                      ),
                      initialValue: type.description,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
            ),
          if (user.role == 'Doctor')
            Container(
              margin: EdgeInsets.only(
                  top: deviceSize.height * 0.01,
                  left: deviceSize.width * 0.015),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.badge,
                    color: Color(0xFF8587dc),
                    size: deviceSize.width * 0.07,
                  ),
                  Container(
                    width: deviceSize.width * 0.6,
                    margin: EdgeInsets.only(left: deviceSize.width * 0.04),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Experience',
                        labelStyle: TextStyle(
                          fontFamily: 'League Spartan',
                          fontSize: deviceSize.width * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.04,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'League Spartan',
                      ),
                      initialValue: type.experience,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
            ),
          if (user.role == 'Doctor')
            Container(
              margin: EdgeInsets.only(
                  top: deviceSize.height * 0.01,
                  left: deviceSize.width * 0.015),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.money,
                    color: Color(0xFF8587dc),
                    size: deviceSize.width * 0.07,
                  ),
                  Container(
                    width: deviceSize.width * 0.6,
                    margin: EdgeInsets.only(left: deviceSize.width * 0.04),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Consultation Charges',
                        labelStyle: TextStyle(
                          fontFamily: 'League Spartan',
                          fontSize: deviceSize.width * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.04,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'League Spartan',
                      ),
                      initialValue: type.fees,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
            ),
          if (user.role == 'Doctor')
            Container(
              margin: EdgeInsets.only(
                  top: deviceSize.height * 0.01,
                  left: deviceSize.width * 0.015),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.watch_later_outlined,
                    color: Color(0xFF8587dc),
                    size: deviceSize.width * 0.07,
                  ),
                  Container(
                    width: deviceSize.width * 0.6,
                    margin: EdgeInsets.only(left: deviceSize.width * 0.04),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Time of Availability',
                        labelStyle: TextStyle(
                          fontFamily: 'League Spartan',
                          fontSize: deviceSize.width * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.04,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'League Spartan',
                      ),
                      initialValue: type.time,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
