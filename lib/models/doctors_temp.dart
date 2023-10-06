class DoctorModel {
  final String name;
  final String specialization;
  final int averageReview;
  final int totalReviews;
  final String profile;
  DoctorModel({
    required this.name,
    required this.specialization,
    required this.averageReview,
    required this.totalReviews,
    required this.profile,
  });
}

final List<DoctorModel> nearbyDoctors = [
  DoctorModel(
    name: "Luke Holland",
    specialization: "General Practitioner",
    averageReview: 0,
    totalReviews: 0,
    profile: "assets/images/doctor_1.jpg",
  ),
  DoctorModel(
    name: "Sophie Harmon",
    specialization: "General Practitioner",
    averageReview: 0,
    totalReviews: 0,
    profile: "assets/images/doctor_2.jpg",
  ),
  DoctorModel(
    name: "Louise Reid",
    specialization: "General Practitioner",
    averageReview: 2,
    totalReviews: 0,
    profile: "assets/images/doctor_3.jpg",
  ),
  DoctorModel(
    name: "Louise Reid",
    specialization: "General Practitioner",
    averageReview: 2,
    totalReviews: 0,
    profile: "assets/images/doctor_4.jpg",
  ),
  DoctorModel(
    name: "Louise Reid",
    specialization: "General Practitioner",
    averageReview: 2,
    totalReviews: 0,
    profile: "assets/images/doctor_5.jpg",
  ),
];
