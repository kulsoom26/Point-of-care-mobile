import 'package:flutter/material.dart';
import 'package:test/models/allAppointments.dart';
import 'package:test/models/appointment.dart';

class AppointmentProvider extends ChangeNotifier {
  Appointment _appointment = Appointment(
    id: '',
    doctorId: '',
    userId: '',
    gender: '',
    contact: '',
    reason: '',
    name: '',
    age: '',
    time: '',
    date: '',
    status: '',
  );

  List<Appointments> _appointmentsList = [];
  List<Appointment> _doctorAppointmentList = [];
  List<Appointment> _singleAppointmentData = [];

  Appointment get appointment => _appointment;

  List<Appointments> get appointmentsList => _appointmentsList;
  List<Appointment> get appointmentDoctorList => _doctorAppointmentList;
  List<Appointment> get singleAppointmentData => _singleAppointmentData;

  void setAppointment(String appointment) {
    _appointment = Appointment.fromJson(appointment);
    notifyListeners();
  }

  void setAppointmentFromModel(Appointment appointment) {
    _appointment = appointment;
    notifyListeners();
  }

  void setAppointmentsList(List<Appointments> appointmentsList) {
    _appointmentsList = appointmentsList;
    notifyListeners();
  }

  void setDoctorAppointmentList(List<Appointment> doctorAppointmentList) {
    _doctorAppointmentList = doctorAppointmentList;
    notifyListeners();
  }

  void setSingleAppointment(List<Appointment> singleAppointmentData) {
    _singleAppointmentData = singleAppointmentData;
    notifyListeners();
  }
}
