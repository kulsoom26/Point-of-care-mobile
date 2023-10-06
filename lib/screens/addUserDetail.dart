// ignore_for_file: file_names, unnecessary_null_comparison

import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/user_provider.dart';
import '../services/auth_services.dart';

class AddUserDetail extends StatefulWidget {
  static const routeName = '/add-user-profile';
  const AddUserDetail({super.key});

  @override
  State<AddUserDetail> createState() => _AddUserDetailState();
}

class _AddUserDetailState extends State<AddUserDetail> {
  int id = 1;
  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _feesController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String _errorMessage = '';
  String _errorMessage1 = '';
  String _errorMessage2 = '';
  String _errorMessage3 = '';
  String _errorMessage4 = '';
  String _errorMessage5 = '';
  String _errorMessage6 = '';

  final AuthService authService = AuthService();

  void addDoctor(String id) {
    authService.addDoctor(
      context: context,
      userId: id,
      gender: _genderController.text,
      contact: _contactController.text,
      experience: _experienceController.text,
      specialization: _specializationController.text,
      description: _descriptionController.text,
      time: _timeController.text,
      fees: _feesController.text,
      image: _imageController.text,
    );
  }

  void addPatient(String id) async {
    authService.addPatient(
      context: context,
      userId: id,
      gender: _genderController.text,
      contact: _contactController.text,
      age: _ageController.text,
      image: _imageController.text,
    );
  }

  Future<void> uploadImage(String name) async {
    final firebaseStorage = FirebaseStorage.instance;
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (imgXFile != null) {
      // Upload to Firebase
      var file = File(imgXFile!.path);
      var storageRef = firebaseStorage.ref().child(name);

      var uploadTask = storageRef.putFile(file);

      // Wait for the upload to complete and get the download URL
      var snapshot = await uploadTask.whenComplete(() {});

      if (snapshot.state == TaskState.success) {
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          _imageController.text = downloadUrl;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            // Header Image
            const Image(
              image: AssetImage('assets/images/eclipse.png'),
            ),

            // Title
            Container(
              margin: EdgeInsets.only(
                top: deviceSize.height * 0.1,
                left: deviceSize.width * 0.1,
              ),
              child: Text(
                'Complete Profile',
                style: TextStyle(
                  color: const Color(0xff200E32).withOpacity(0.8),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            // Form
            Container(
              height: user.role == "Doctor"
                  ? deviceSize.height * 1.2
                  : deviceSize.height * 0.8,
              margin: EdgeInsets.only(
                top: deviceSize.width * 0.3,
                left: deviceSize.width * 0.05,
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        uploadImage(user.name);
                      },
                      child: CircleAvatar(
                        radius: deviceSize.width * 0.20,
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.5),
                        backgroundImage: imgXFile == null
                            ? null
                            : FileImage(File(imgXFile!.path)),
                        child: Visibility(
                          visible: imgXFile ==
                              null, // Hide the icon when imgXFile is not null
                          child: Icon(
                            Icons.add_photo_alternate,
                            color: Colors.white,
                            size: deviceSize.width * 0.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (user.role == 'Doctor')
                    Row(
                      children: [
                        const Icon(Icons.app_registration_rounded,
                            color: Colors.grey),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Specialization",
                          style: TextStyle(
                            fontFamily: "League Spartan",
                            fontSize: deviceSize.width * 0.04,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  if (user.role == 'Doctor')
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2, left: 6),
                      child: TextField(
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                          hintText: 'Enter your specialization',
                          hintStyle: TextStyle(
                              fontSize: deviceSize.width * 0.035,
                              fontFamily: 'League Spartan',
                              color: Colors.black26),
                        ),
                        controller: _specializationController,
                        onChanged: (val) {
                          validateSpecialization(val);
                        },
                      ),
                    ),
                  if (user.role == 'Doctor')
                    Padding(
                      padding: EdgeInsets.only(top: deviceSize.height * 0.01),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          _errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: deviceSize.width * 0.03,
                            fontFamily: 'League Spartan',
                          ),
                        ),
                      ),
                    ),
                  if (user.role == 'Doctor')
                    Row(
                      children: [
                        const Icon(Icons.app_registration_rounded,
                            color: Colors.grey),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(
                            fontFamily: "League Spartan",
                            fontSize: deviceSize.width * 0.04,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  if (user.role == 'Doctor')
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2, left: 6),
                      child: TextField(
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                          hintText: 'describe yourself',
                          hintStyle: TextStyle(
                              fontSize: deviceSize.width * 0.035,
                              fontFamily: 'League Spartan',
                              color: Colors.black26),
                        ),
                        controller: _descriptionController,
                        onChanged: (val) {
                          validateDescription(val);
                        },
                      ),
                    ),
                  if (user.role == 'Doctor')
                    Padding(
                      padding: EdgeInsets.only(top: deviceSize.height * 0.01),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          _errorMessage1,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: deviceSize.width * 0.03,
                            fontFamily: 'League Spartan',
                          ),
                        ),
                      ),
                    ),
                  if (user.role == 'Doctor')
                    Row(
                      children: [
                        const Icon(Icons.badge, color: Colors.grey),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Experience",
                          style: TextStyle(
                            fontFamily: "League Spartan",
                            fontSize: deviceSize.width * 0.04,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  if (user.role == 'Doctor')
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2, left: 6),
                      child: TextField(
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                          hintText: 'Enter your experience',
                          hintStyle: TextStyle(
                              fontSize: deviceSize.width * 0.035,
                              fontFamily: 'League Spartan',
                              color: Colors.black26),
                        ),
                        controller: _experienceController,
                        onChanged: (val) {
                          validateExperience(val);
                        },
                      ),
                    ),
                  if (user.role == 'Doctor')
                    Padding(
                      padding: EdgeInsets.only(top: deviceSize.height * 0.01),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          _errorMessage2,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: deviceSize.width * 0.03,
                            fontFamily: 'League Spartan',
                          ),
                        ),
                      ),
                    ),
                  Row(
                    children: [
                      const Icon(Icons.call, color: Colors.grey),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Contact Number",
                        style: TextStyle(
                          fontFamily: "League Spartan",
                          fontSize: deviceSize.width * 0.04,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2, left: 6),
                    child: TextField(
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                        hintText: 'Enter your contact',
                        hintStyle: TextStyle(
                            fontSize: deviceSize.width * 0.035,
                            fontFamily: 'League Spartan',
                            color: Colors.black26),
                      ),
                      controller: _contactController,
                      onChanged: (val) {
                        validateContact(val);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: deviceSize.height * 0.01),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _errorMessage3,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: deviceSize.width * 0.03,
                          fontFamily: 'League Spartan',
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.group, color: Colors.grey),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Gender",
                        style: TextStyle(
                          fontFamily: "League Spartan",
                          fontSize: deviceSize.width * 0.04,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: id,
                        onChanged: (val) {
                          setState(() {
                            id = 1;
                            _genderController.text = 'Male';
                          });
                        },
                      ),
                      Text(
                        'Male',
                        style: TextStyle(
                          fontFamily: 'League Spartan',
                          fontSize: deviceSize.width * 0.04,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF696969),
                        ),
                      ),
                      Radio(
                        value: 2,
                        groupValue: id,
                        onChanged: (val) {
                          setState(() {
                            _genderController.text = 'Female';
                            id = 2;
                          });
                        },
                      ),
                      Text(
                        'Female',
                        style: TextStyle(
                          fontFamily: 'League Spartan',
                          fontSize: deviceSize.width * 0.04,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF696969),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (user.role == 'Doctor')
                    Row(
                      children: [
                        const Icon(Icons.money, color: Colors.grey),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Consultation Charges",
                          style: TextStyle(
                            fontFamily: "League Spartan",
                            fontSize: deviceSize.width * 0.04,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  if (user.role == 'Doctor')
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2, left: 6),
                      child: TextField(
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                          hintText: 'Enter your fees',
                          hintStyle: TextStyle(
                              fontSize: deviceSize.width * 0.035,
                              fontFamily: 'League Spartan',
                              color: Colors.black26),
                        ),
                        controller: _feesController,
                        onChanged: (val) {
                          validatefees(val);
                        },
                      ),
                    ),
                  if (user.role == 'Doctor')
                    Padding(
                      padding: EdgeInsets.only(top: deviceSize.height * 0.01),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          _errorMessage4,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: deviceSize.width * 0.03,
                            fontFamily: 'League Spartan',
                          ),
                        ),
                      ),
                    ),
                  if (user.role == 'Doctor')
                    Row(
                      children: [
                        const Icon(Icons.watch_later_outlined,
                            color: Colors.grey),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Time of Availability",
                          style: TextStyle(
                            fontFamily: "League Spartan",
                            fontSize: deviceSize.width * 0.04,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  if (user.role == 'Doctor')
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2, left: 6),
                      child: TextField(
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                          hintText: 'Enter your time',
                          hintStyle: TextStyle(
                              fontSize: deviceSize.width * 0.035,
                              fontFamily: 'League Spartan',
                              color: Colors.black26),
                        ),
                        controller: _timeController,
                        onChanged: (val) {
                          validateTime(val);
                        },
                      ),
                    ),
                  if (user.role == 'Doctor')
                    Padding(
                      padding: EdgeInsets.only(top: deviceSize.height * 0.01),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          _errorMessage5,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: deviceSize.width * 0.03,
                            fontFamily: 'League Spartan',
                          ),
                        ),
                      ),
                    ),
                  if (user.role == 'Patient')
                    Row(
                      children: [
                        const Icon(Icons.calendar_month, color: Colors.grey),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Age",
                          style: TextStyle(
                            fontFamily: "League Spartan",
                            fontSize: deviceSize.width * 0.04,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  if (user.role == 'Patient')
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2, left: 6),
                      child: TextField(
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                          hintText: 'Enter your age',
                          hintStyle: TextStyle(
                              fontSize: deviceSize.width * 0.035,
                              fontFamily: 'League Spartan',
                              color: Colors.black26),
                        ),
                        controller: _ageController,
                        onChanged: (val) {
                          validateAge(val);
                        },
                      ),
                    ),
                  if (user.role == 'Patient')
                    Padding(
                      padding: EdgeInsets.only(top: deviceSize.height * 0.01),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          _errorMessage6,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: deviceSize.width * 0.03,
                            fontFamily: 'League Spartan',
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        if (user.role == 'Doctor') {
                          addDoctor(user.id);
                        } else {
                          addPatient(user.id);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFFB9A0E6),
                              Color(0xFF8587DC),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: deviceSize.width * 0.85,
                          height: deviceSize.height * 0.065,
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              'Save Changes',
                              style: TextStyle(
                                fontSize: deviceSize.width * 0.048,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validateSpecialization(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Please enter valid input, it connot be empty";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }

  void validateDescription(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage1 = "Please enter valid input, it connot be empty";
      });
    } else {
      setState(() {
        _errorMessage1 = "";
      });
    }
  }

  void validateExperience(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage2 = "Please enter valid input, it connot be empty";
      });
    } else {
      setState(() {
        _errorMessage2 = "";
      });
    }
  }

  void validateContact(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage3 = "Please enter valid input, it connot be empty";
      });
    } else {
      setState(() {
        _errorMessage3 = "";
      });
    }
  }

  void validatefees(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage4 = "Please enter valid input, it connot be empty";
      });
    } else {
      setState(() {
        _errorMessage4 = "";
      });
    }
  }

  void validateTime(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage5 = "Please enter valid input, it connot be empty";
      });
    } else {
      setState(() {
        _errorMessage5 = "";
      });
    }
  }

  void validateAge(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage6 = "Please enter valid input, it connot be empty";
      });
    } else {
      setState(() {
        _errorMessage6 = "";
      });
    }
  }
}
