// ignore_for_file: file_names

import 'dart:convert';

class Appointments {
  final String id;
  final String status;
  final String date;
  final String time;
  final String doctorName;
  final String name;
  final String image;

  Appointments(
      {required this.id,
      required this.status,
      required this.date,
      required this.time,
      required this.doctorName,
      required this.image,
      required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'date': date,
      'time': time,
      'doctorName': doctorName,
      'image': image,
      'name': name,
    };
  }

  factory Appointments.fromMap(Map<String, dynamic> map) {
    return Appointments(
        id: map['id'] ?? '',
        status: map['status'] ?? '',
        date: map['date'] ?? '',
        time: map['time'] ?? '',
        doctorName: map['doctorName'] ?? '',
        image: map['image'] ?? '',
        name: map['name'] ?? '');
  }
  String toJson() => json.encode(toMap());

  factory Appointments.fromJson(String source) =>
      Appointments.fromMap(json.decode(source));
}
