// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  static const routeName = '/aboutus-screen';

  const AboutUs({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('About us')),
    );
  }
}
