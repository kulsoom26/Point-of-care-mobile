// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/diseaseLabels.dart';

class ResultLabels extends StatefulWidget {
  const ResultLabels({super.key});

  @override
  State<ResultLabels> createState() => _ResultLabelsState();
}

class _ResultLabelsState extends State<ResultLabels> {
  @override
  Widget build(BuildContext context) {
    final labels = Provider.of<DiseaseLabels>(context);
    final labelList = labels.labels;
    final deviceSize = MediaQuery.of(context).size;

    return ListView.builder(
      itemCount: 14,
      itemBuilder: (context, position) {
        return Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: deviceSize.width * 0.8,
            child: Card(
              elevation: 18,
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: deviceSize.height * 0.01,
                    horizontal: deviceSize.width * 0.01,
                  ),
                  child: Text(
                    labelList[position].name,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF200e32),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: deviceSize.height * 0.005,
                    horizontal: deviceSize.width * 0.01,
                  ),
                  child: Text(
                    labelList[position].percentage,
                    style: const TextStyle(
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                leading: Padding(
                  padding: EdgeInsets.only(
                    top: deviceSize.height * 0.015,
                    left: deviceSize.width * 0.02,
                  ),
                  child: const Icon(
                    Icons.remove_red_eye,
                    color: Color(0xFF200e32),
                  ),
                ),
                trailing: Container(
                  margin: EdgeInsets.only(
                    top: deviceSize.height * 0.03,
                  ),
                  child: Text(
                    labelList[position].likeness,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black45,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
