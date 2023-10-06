// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/reports.dart';

class ReportList extends StatefulWidget {
  const ReportList({super.key});

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  @override
  Widget build(BuildContext context) {
    final report = Provider.of<Reports>(context);
    final reportList = report.reports;
    final deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: reportList.length,
      itemBuilder: (context, position) {
        return Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: deviceSize.width * 0.8,
            child: Card(
                elevation: 18,
                child: ListTile(
                  title: Text(
                    reportList[position].name,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF200e32),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    // ignore: prefer_interpolation_to_compose_strings
                    'Result: ' + reportList[position].result,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  leading: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xFFB9A0E6),
                            Color(0xFF8587DC),
                          ]),
                    ),
                    child: Container(
                      width: 55,
                      height: 55,
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(children: [
                        Text(
                          reportList[position].date.substring(0, 2),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          reportList[position].date.substring(3, 6),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }
}
