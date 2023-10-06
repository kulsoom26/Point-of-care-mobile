import 'package:flutter/material.dart';
import 'package:test/models/allDoctors.dart';
import '../models/doctor.dart';

class DoctorProvider extends ChangeNotifier {
  Doctor _doctor = Doctor(
    userId: '',
    gender: '',
    contact: '',
    experience: '',
    specialization: '',
    description: '',
    time: '',
    fees: '',
    image: '',
  );

  List<Doctors> _doctorsList = [];

  Doctor get doctor => _doctor;

  List<Doctors> get doctorsList => _doctorsList;

  void setDoctor(String doctor) {
    _doctor = Doctor.fromJson(doctor);
    notifyListeners();
  }

  void setDoctorFromModel(Doctor doctor) {
    _doctor = doctor;
    notifyListeners();
  }

  void setDoctorsList(List<Doctors> doctorsList) {
    _doctorsList = doctorsList;
    notifyListeners();
  }
}
