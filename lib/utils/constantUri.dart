// ignore_for_file: file_names
import 'package:firebase_core/firebase_core.dart';

class ConstantUri {
  static String uri = 'http://127.0.0.1:3000';
}

Future<void> initializeFirebase() async {
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'Point-Of-Care',
    options: const FirebaseOptions(
        apiKey: "AIzaSyDyM0ZRtfwrNKBXwu0ew9qr0jMLhKuJHWU",
        authDomain: "point-of-care-462b2.firebaseapp.com",
        projectId: "point-of-care-462b2",
        storageBucket: "point-of-care-462b2.appspot.com",
        messagingSenderId: "1054959884915",
        appId: "1:1054959884915:web:13b7f2fe7681abd437e806"),
  );
}
