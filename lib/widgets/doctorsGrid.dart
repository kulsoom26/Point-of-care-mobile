import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/doctor_profile.dart';
import 'package:test/screens/doctorDetail.dart';
import '../models/doctors_temp.dart';
import 'package:ionicons/ionicons.dart';

class DoctorsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var doctorProvider = Provider.of<DoctorProvider>(context);

    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.22,
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: doctorProvider.doctorsList.length,
        itemBuilder: (context, index) {
          final doctor = doctorProvider.doctorsList[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(DoctorDetail.routeName);
            },
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 18),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              doctor.image), // Use the doctor's image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dr. ${doctor.name}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(doctor.specialization), // Display specialization
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(
                              Ionicons.star,
                              color: Colors.yellow[700],
                              size: 18,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 4, right: 6),
                              child: Text(
                                "4.0", // You can replace with doctor's rating
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text("195 Reviews"), // Display review count
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.watch_later,
                              color: Color(0xFF7165D6),
                              size: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 4, right: 6),
                              child: Text(
                                doctor.time, // Display doctor's time
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
