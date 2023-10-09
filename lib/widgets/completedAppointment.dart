import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/allAppointments.dart';
import 'package:test/providers/appointment_provider.dart';
import 'package:test/providers/user_provider.dart';
import 'package:test/models/appointment.dart';

class CompletedAppointment extends StatelessWidget {
  const CompletedAppointment({Key? key}) : super(key: key);

  bool isComplete(List<Appointment> appointmentsList) {
    for (final appointment in appointmentsList) {
      if (appointment.status != 'completed') {
        continue;
      } else {
        return false;
      }
    }
    return true;
  }

  bool isCompleteAppointment(List<Appointments> appointmentsList) {
    for (final appointment in appointmentsList) {
      if (appointment.status != 'completed') {
        continue;
      } else {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context).user;
    final role = user.role;
    final appointmentsList =
        Provider.of<AppointmentProvider>(context).appointmentsList;
    final doctorAppointments =
        Provider.of<AppointmentProvider>(context).appointmentDoctorList;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (role == 'Doctor') ...[
            if (isComplete(doctorAppointments)) ...[
              SizedBox(
                height: deviceSize.height * 0.6,
                child: const Center(
                  child: Text(
                    "No complete appointments !",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ] else ...[
              for (final appointment in doctorAppointments) ...{
                if (appointment.status == 'completed') ...[
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              appointment.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text("Reason: ${appointment.reason}"),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              thickness: 1,
                              height: 20,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    appointment.date,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_filled,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    appointment.time,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    appointment.status,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ],
              },
            ],
          ],
          if (role == 'Patient') ...{
            if (isCompleteAppointment(appointmentsList)) ...[
              SizedBox(
                height: deviceSize.height * 0.6,
                child: const Center(
                  child: Text(
                    "No complete appointments!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ] else ...[
              for (final appointment in appointmentsList) ...{
                if (appointment.status == 'completed') ...[
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Dr. ${appointment.doctorName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text("Patient name: ${appointment.name}"),
                            trailing: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(appointment.image),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              thickness: 1,
                              height: 20,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    appointment.date,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_filled,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    appointment.time,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    appointment.status,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ],
              },
            ],
          },
          if (appointmentsList.length == 1 || doctorAppointments.length == 1)
            SizedBox(
              height: deviceSize.height * 0.5,
            ),
          if (appointmentsList.length == 2 || doctorAppointments.length == 2)
            SizedBox(
              height: deviceSize.height * 0.3,
            ),
        ],
      ),
    );
  }
}
