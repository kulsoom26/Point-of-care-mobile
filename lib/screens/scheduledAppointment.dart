// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:test/widgets/canceledAppointment.dart';
import 'package:test/widgets/completedAppointment.dart';
import '../widgets/upcomingAppointmentList.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/appointment-schedule';

  const ScheduleScreen({Key? key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _buttonIndex = 0;

  final _scheduleWidgets = [
    const UpcomingSchedule(),
    const CompletedAppointment(),
    const CanceledAppointment(),
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: deviceSize.height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: deviceSize.width * 0.05,
              ),
              child: Text(
                "Schedule",
                style: TextStyle(
                  fontSize: 32 * textScaleFactor,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins', // Set fontFamily to 'Poppins'
                ),
              ),
            ),
            SizedBox(height: deviceSize.height * 0.02),
            Center(
              child: Container(
                width: deviceSize.width * 0.95,
                padding: const EdgeInsets.all(5),
                margin: EdgeInsets.only(left: deviceSize.width * 0.001),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F6FA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _buttonIndex = 0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: deviceSize.height * 0.015,
                          horizontal: deviceSize.width * 0.05,
                        ),
                        decoration: BoxDecoration(
                          color: _buttonIndex == 0
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Upcoming",
                          style: TextStyle(
                            fontSize: 13 * textScaleFactor,
                            fontWeight: FontWeight.w500,
                            fontFamily:
                                'Poppins', // Set fontFamily to 'Poppins'
                            color: _buttonIndex == 0
                                ? Colors.white
                                : Colors.black38,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _buttonIndex = 1;
                        });
                      },
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: deviceSize.height * 0.015,
                            horizontal: deviceSize.width * 0.05,
                          ),
                          decoration: BoxDecoration(
                            color: _buttonIndex == 1
                                ? Theme.of(context).primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: 13 * textScaleFactor,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                                  'Poppins', // Set fontFamily to 'Poppins'
                              color: _buttonIndex == 1
                                  ? Colors.white
                                  : Colors.black38,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _buttonIndex = 2;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: deviceSize.height * 0.015,
                          horizontal: deviceSize.width * 0.05,
                        ),
                        decoration: BoxDecoration(
                          color: _buttonIndex == 2
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Canceled",
                          style: TextStyle(
                            fontSize: 13 * textScaleFactor,
                            fontWeight: FontWeight.w500,
                            fontFamily:
                                'Poppins', // Set fontFamily to 'Poppins'
                            color: _buttonIndex == 2
                                ? Colors.white
                                : Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: deviceSize.height * 0.03),
            _scheduleWidgets[_buttonIndex],
          ],
        ),
      ),
    );
  }
}
