// ignore_for_file: file_names

import 'dart:io';
import '../screens/resultScreen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadOptions extends StatefulWidget {
  const UploadOptions({super.key});

  @override
  State<UploadOptions> createState() => _UploadOptionsState();
}

class _UploadOptionsState extends State<UploadOptions> {
  XFile? image;
  bool _active = false;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      _active = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final double iconSize = deviceSize.width * 0.1;
    final double buttonTextSize = deviceSize.width * 0.025;
    final double imageWidth = deviceSize.width * 0.7;
    final double imageHeight = deviceSize.height * 0.3;
    final double submitButtonWidth = deviceSize.width * 0.85;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: deviceSize.width * 0.3,
              height: deviceSize.height * 0.15,
              child: DottedBorder(
                borderType: BorderType.RRect,
                dashPattern: const [5, 5],
                color: Colors.grey,
                strokeWidth: 2,
                child: Center(
                  child: TextButton.icon(
                    icon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.collections,
                          size: iconSize,
                          color: Colors.grey,
                        ),
                        Text(
                          'Upload xray',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                            fontSize: buttonTextSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    label: const Text(''),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: deviceSize.width * 0.3,
              height: deviceSize.height * 0.15,
              child: DottedBorder(
                borderType: BorderType.RRect,
                dashPattern: const [5, 5],
                color: Colors.grey,
                strokeWidth: 2,
                child: Center(
                  child: TextButton.icon(
                    icon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: iconSize,
                          color: Colors.grey,
                        ),
                        Text(
                          'Take Photo',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                            fontSize: buttonTextSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    label: const Text(''),
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        if (image != null)
          Container(
            margin: EdgeInsets.only(top: deviceSize.height * 0.04),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Image.file(
                File(image!.path),
                fit: BoxFit.cover,
                width: imageWidth,
                height: imageHeight,
              ),
            ),
          ),
        SizedBox(
          height: deviceSize.height * 0.05,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: () {
              if (_active) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ResultScreen()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
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
                borderRadius: BorderRadius.circular(50),
              ),
              child: Container(
                width: submitButtonWidth,
                height: deviceSize.height * 0.065,
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: buttonTextSize * 1.5,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
