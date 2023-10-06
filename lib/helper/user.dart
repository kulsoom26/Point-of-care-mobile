import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  final String id;
  late final String name;
  late final String username;
  late final String email;
  late final String contact;
  late final String age;
  late final String gender;
  late final String address;
  final String pic;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.contact,
    required this.age,
    required this.gender,
    required this.address,
    required this.pic,
  });
}
