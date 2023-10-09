// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/allAppointments.dart';
import 'package:test/models/allDoctors.dart';
import 'package:test/models/appointment.dart';
import 'package:test/providers/doctor_profile.dart';
import 'package:test/providers/appointment_provider.dart';
import 'package:test/screens/rescheduleAppointment.dart';
import 'package:test/screens/scheduledAppointment.dart';
import 'package:test/screens/tabScreen.dart';
import 'package:test/utils/constantUri.dart';
import '../utils/snack_bar_util.dart';
import 'package:http/http.dart' as http;

class AppointmentServices {
  void getDoctorInformation(
      {required BuildContext context, required String userId}) async {
    try {
      final http.Response res = await http.get(
        Uri.parse('${ConstantUri.uri}/api/user/getDoctorInformation/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final Map<String, dynamic> responseMap = json.decode(res.body);

      if (responseMap != null) {
        final doctorData = responseMap;
        final doctorList = [
          Doctors(
            userId: doctorData['_id'],
            gender: doctorData['gender'],
            contact: doctorData['contact'],
            experience: doctorData['experience'],
            specialization: doctorData['specialization'],
            description: doctorData['description'],
            time: doctorData['time'],
            fees: doctorData['fees'],
            image: doctorData['image'],
            name: doctorData['userId']['name'],
            email: doctorData['userId']['email'],
          ),
        ];

        final doctorProvider =
            // ignore: use_build_context_synchronously
            Provider.of<DoctorProvider>(context, listen: false);

        doctorProvider.setDoctorList(doctorList);
      }
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  //book Appointment
  void addAppointment({
    required BuildContext context,
    required String doctorId,
    required String userId,
    required String gender,
    required String contact,
    required String reason,
    required String name,
    required String age,
    required String time,
    required String date,
    required String status,
  }) async {
    try {
      Appointment appointment = Appointment(
        id: '',
        doctorId: doctorId,
        userId: userId,
        gender: gender,
        contact: contact,
        reason: reason,
        name: name,
        age: age,
        time: time,
        date: date,
        status: status,
      );
      final navigator = Navigator.of(context);
      final appointmentProvider =
          Provider.of<AppointmentProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('${ConstantUri.uri}/api/user/addAppointment'),
        body: appointment.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

// ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          // ignore: unnecessary_null_comparison
          if (res.body != null) {
            appointmentProvider.setAppointment(res.body);
          } else {
            showSnackBar(context, 'Response body is null');
          }
          showSnackBar(context, "Appointment scheduled successfully!");
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const TabsScreen(),
            ),
            (route) => false,
          );
        },
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  void getUserAppointments({
    required BuildContext context,
    required String userId,
  }) async {
    try {
      final http.Response res = await http.get(
        Uri.parse('${ConstantUri.uri}/api/user/getUserAppointments/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var appointmentProvider =
          Provider.of<AppointmentProvider>(context, listen: false);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final List<dynamic> responseData = json.decode(res.body);
          final List<Appointments> appointmentsList =
              responseData.map((appointmentData) {
            return Appointments(
              id: appointmentData['_id'],
              status: appointmentData['status'],
              doctorName: appointmentData['doctorId']['doctorName'],
              name: appointmentData['name'],
              time: appointmentData['time'],
              date: appointmentData['date'],
              image: appointmentData['doctorId']['image'],
            );
          }).toList();
          appointmentProvider.setAppointmentsList(appointmentsList);
        },
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  void getDoctorAppointments({
    required BuildContext context,
    required String userId,
  }) async {
    try {
      final http.Response res = await http.get(
        Uri.parse('${ConstantUri.uri}/api/user/getDoctorAppointments/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var appointmentProvider =
          Provider.of<AppointmentProvider>(context, listen: false);
      if (res.statusCode == 200) {
        final List<dynamic> responseData = json.decode(res.body);
        final List<Appointment> appointmentsList =
            responseData.map((appointmentData) {
          return Appointment(
              id: appointmentData['_id'],
              status: appointmentData['status'],
              reason: appointmentData['reason'],
              name: appointmentData['name'],
              time: appointmentData['time'],
              date: appointmentData['date'],
              age: appointmentData['age'],
              gender: appointmentData['gender'],
              contact: appointmentData['contact'],
              userId: appointmentData['userId'],
              doctorId: appointmentData['doctorId']);
        }).toList();

        appointmentProvider.setDoctorAppointmentList(appointmentsList);
        print(appointmentsList[0].id);
      } else {
        showSnackBar(context, 'Failed to fetch doctor appointments');
      }
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  void updateAppointment({
    required BuildContext context,
    required String id,
    required String doctorId,
    required String userId,
    required String gender,
    required String contact,
    required String reason,
    required String name,
    required String age,
    required String time,
    required String date,
    required String status,
  }) async {
    try {
      Appointment appointment = Appointment(
        id: id,
        doctorId: doctorId,
        userId: userId,
        gender: gender,
        contact: contact,
        reason: reason,
        name: name,
        age: age,
        time: time,
        date: date,
        status: status,
      );
      final navigator = Navigator.of(context);
      final appointmentProvider =
          Provider.of<AppointmentProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('${ConstantUri.uri}/api/user/updateAppointment/$id'),
        body: appointment.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

// ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          // ignore: unnecessary_null_comparison
          if (res.body != null) {
            appointmentProvider.setAppointment(res.body);
          } else {
            showSnackBar(context, 'Response body is null');
          }
          showSnackBar(context, "Appointment rescheduled successfully!");
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const TabsScreen(),
            ),
            (route) => false,
          );
        },
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  void getAppointmentInformation(
      {required BuildContext context, required String id}) async {
    try {
      final http.Response res = await http.get(
        Uri.parse('${ConstantUri.uri}/api/user/getSingleAppointment/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final Map<String, dynamic> responseMap = json.decode(res.body);

      if (responseMap != null) {
        final appointmentData = responseMap;
        final updateAppointmentList = [
          Appointment(
            id: appointmentData['_id'],
            userId: appointmentData['userId'],
            gender: appointmentData['gender'],
            contact: appointmentData['contact'],
            time: appointmentData['time'],
            date: appointmentData['date'],
            reason: appointmentData['reason'],
            name: appointmentData['name'],
            age: appointmentData['age'],
            status: appointmentData['status'],
            doctorId: appointmentData['doctorId'],
          ),
        ];

        final appointmentProvider =
            // ignore: use_build_context_synchronously
            Provider.of<AppointmentProvider>(context, listen: false);

        appointmentProvider.setSingleAppointment(updateAppointmentList);
        await Future.delayed(const Duration(seconds: 1));
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => RescheduleAppointment()),
        );
      }
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  void cancelAppointment({
    required BuildContext context,
    required String id,
    required String status,
  }) async {
    try {
      final navigator = Navigator.of(context);
      final appointmentProvider =
          Provider.of<AppointmentProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('${ConstantUri.uri}/api/user/cancelAppointment'),
        body: jsonEncode({'id': id, 'status': status}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

// ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(context, "Appointment cancelled successfully!");
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const TabsScreen(),
            ),
            (route) => false,
          );
        },
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  void completeAppointment({
    required BuildContext context,
    required String id,
    required String status,
  }) async {
    try {
      final navigator = Navigator.of(context);
      final appointmentProvider =
          Provider.of<AppointmentProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('${ConstantUri.uri}/api/user/completeAppointment/$id'),
        body: jsonEncode({'status': status}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

// ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(context, "Appointment completed successfully!");
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const TabsScreen(),
            ),
            (route) => false,
          );
        },
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }
}
