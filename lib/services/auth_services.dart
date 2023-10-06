// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/models/allDoctors.dart';
import 'package:test/models/doctor.dart';
import 'package:test/providers/user_provider.dart';
import 'package:test/providers/doctor_profile.dart';
import 'package:test/screens/addUserDetail.dart';
import 'package:test/screens/authentication.dart';
import 'package:test/screens/emailOTP.dart';
import 'package:test/screens/profile.dart';
import 'package:test/screens/tabScreen.dart';
import 'package:test/utils/constantUri.dart';
import '../models/patient.dart';
import '../models/user.dart';
import '../providers/patient_profile.dart';
import '../utils/snack_bar_util.dart';
import 'package:http/http.dart' as http;

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String name,
    required String role,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        role: role,
        token: '',
      );
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse('${ConstantUri.uri}/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userProvider.setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const AddUserDetail(),
            ),
            (route) => false,
          );
          showSnackBar(
            context,
            'User Registered, please complete the profile!',
          );
        },
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  //User Login
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      var doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
      var patientProvider =
          Provider.of<PatientProvider>(context, listen: false);

      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse('${ConstantUri.uri}/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final Map<String, dynamic> responseData = jsonDecode(res.body);
          userProvider.setUser(jsonEncode(responseData['user']));

          if (responseData.containsKey('doctor')) {
            doctorProvider.setDoctor(jsonEncode(responseData['doctor']));
          }

          if (responseData.containsKey('patient')) {
            patientProvider.setPatient(jsonEncode(responseData['patient']));
          }

          await prefs.setString(
              'x-auth-token', jsonEncode(responseData['token']));
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const TabsScreen(),
            ),
            (route) => false,
          );
          showSnackBar(
            context,
            'Account Logged in!',
          );
        },
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  //get user data
  void getUserData(BuildContext context) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('${ConstantUri.uri}/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('${ConstantUri.uri}/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );
        userProvider.setUser(userRes.body);
      }
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  //SignOut
  void signOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const Authentication(),
      ),
      (route) => false,
    );
  }

  //add Doctor
  void addDoctor({
    required BuildContext context,
    required String userId,
    required String gender,
    required String contact,
    required String experience,
    required String specialization,
    required String description,
    required String time,
    required String fees,
    required String image,
  }) async {
    try {
      Doctor doctor = Doctor(
        userId: userId,
        gender: gender,
        contact: contact,
        experience: experience,
        specialization: specialization,
        description: description,
        time: time,
        fees: fees,
        image: image,
      );
      final navigator = Navigator.of(context);
      var doctorProvider = Provider.of<DoctorProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('${ConstantUri.uri}/api/addDoctor'),
        body: doctor.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          // ignore: unnecessary_null_comparison
          if (res.body != null) {
            doctorProvider.setDoctor(res.body);
          } else {
            showSnackBar(context, 'Response body is null');
          }
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

  //add Patient
  void addPatient({
    required BuildContext context,
    required String userId,
    required String gender,
    required String contact,
    required String age,
    required String image,
  }) async {
    try {
      Patient patient = Patient(
        userId: userId,
        gender: gender,
        contact: contact,
        age: age,
        image: image,
      );
      final navigator = Navigator.of(context);
      var patientProvider =
          Provider.of<PatientProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('${ConstantUri.uri}/api/addPatient'),
        body: patient.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          // ignore: unnecessary_null_comparison
          if (res.body != null) {
            patientProvider.setPatient(res.body);
          } else {
            showSnackBar(context, 'Response body is null');
          }
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

  //verify email if exist for password recovery
  void verifyEmailForPasswordRecovery({
    required BuildContext context,
    required String email,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      EmailOTP myauth = EmailOTP();
      http.Response res = await http.post(
        Uri.parse('${ConstantUri.uri}/api/emailVerification'),
        body: jsonEncode({
          'email': email,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var response = jsonDecode(res.body);
      print(response);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          if (response == false) {
            showSnackBar(
              context,
              'Email is not registered, Please enter correct email',
            );
          } else {
            userProvider.setUser(res.body);
            myauth.setConfig(
                appEmail: "me@rohitchouhan.com",
                appName: "Point-Of-Care",
                userEmail: email,
                otpLength: 6,
                otpType: OTPType.digitsOnly);
            if (await myauth.sendOTP() == true) {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("OTP has been sent"),
              ));
            } else {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Oops, OTP send failed"),
              ));
            }
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => EmailOtp(myauth: myauth),
              ),
              (route) => true,
            );
          }
        },
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  //reset new password
  void passwordReset({
    required BuildContext context,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse('${ConstantUri.uri}/api/passwordReset'),
        body: jsonEncode({
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const Authentication(),
            ),
            (route) => false,
          );
          showSnackBar(
            context,
            'Password reset successfully!',
          );
        },
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  //update doctor
  void updateDoctor(
      {required BuildContext context,
      required String name,
      required String email,
      required String contact,
      required String experience,
      required String specialization,
      required String description,
      required String time,
      required String fees,
      required String image,
      required String gender}) async {
    try {
      final navigator = Navigator.of(context);
      print(
        name,
      );
      http.Response res = await http.post(
        Uri.parse('${ConstantUri.uri}/api/updateDoctor'),
        body: jsonEncode({
          'email': email,
          'name': name,
          'contact': contact,
          'experience': experience,
          'specialization': specialization,
          'description': description,
          'time': time,
          'fees': fees,
          'image': image,
          'gender': gender
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final Map<String, dynamic> responseData = jsonDecode(res.body);

          // ignore: unnecessary_null_comparison
          if (res.body != null) {
            userProvider.setUser(jsonEncode(responseData['updatedUser']));
            doctorProvider.setDoctor(jsonEncode(responseData['updatedDoctor']));
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => Profile(),
              ),
              (route) => false,
            );
            showSnackBar(
              context,
              'Information updated successfully!!',
            );
          } else {
            showSnackBar(context, 'Response body is null');
          }
        },
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  //update patient
  void updatePatient(
      {required BuildContext context,
      required String name,
      required String email,
      required String contact,
      required String age,
      required String image,
      required String gender}) async {
    try {
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse('${ConstantUri.uri}/api/updatePatient'),
        body: jsonEncode({
          'email': email,
          'name': name,
          'contact': contact,
          'age': age,
          'image': image,
          'gender': gender
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var patientProvider =
          Provider.of<PatientProvider>(context, listen: false);
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final Map<String, dynamic> responseData = jsonDecode(res.body);

          // ignore: unnecessary_null_comparison
          if (res.body != null) {
            userProvider.setUser(jsonEncode(responseData['updatedUser']));
            patientProvider
                .setPatient(jsonEncode(responseData['updatedPatient']));
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => Profile(),
              ),
              (route) => false,
            );
            showSnackBar(
              context,
              'Information updated successfully!!',
            );
          } else {
            showSnackBar(context, 'Response body is null');
          }
        },
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  void deleteAccount({
    required BuildContext context,
    required String email,
  }) async {
    try {
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse('${ConstantUri.uri}/api/deleteAccount'),
        body: jsonEncode({
          'email': email,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          // ignore: unnecessary_null_comparison
          final navigator = Navigator.of(context);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('x-auth-token', '');
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const Authentication(),
            ),
            (route) => false,
          );
          showSnackBar(
            context,
            'Account Deactivated Successfully!!',
          );
        },
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  void getDoctor({required BuildContext context}) async {
    try {
      http.Response res = await http.get(
        Uri.parse('${ConstantUri.uri}/api/getDoctor'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final List<dynamic> responseData = json.decode(res.body);
          final List<Doctors> doctorsList = responseData.map((doctorData) {
            return Doctors(
              userId: doctorData['userId']['_id'],
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
            );
          }).toList();
          doctorProvider.setDoctorsList(doctorsList);
        },
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }
}
