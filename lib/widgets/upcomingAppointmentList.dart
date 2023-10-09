import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/allAppointments.dart';
import 'package:test/models/appointment.dart';
import 'package:test/providers/appointment_provider.dart';
import 'package:test/providers/user_provider.dart';
import 'package:test/services/appointment_services.dart';

class UpcomingSchedule extends StatelessWidget {
  const UpcomingSchedule({Key? key});
  bool isUpcoming(List<Appointment> appointmentsList) {
    for (final appointment in appointmentsList) {
      if (appointment.status != 'confirmed') {
        continue;
      } else {
        return false;
      }
    }
    return true;
  }

  bool isUpcomingAppointment(List<Appointments> appointmentsList) {
    for (final appointment in appointmentsList) {
      if (appointment.status != 'confirmed') {
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
    AppointmentServices appointmentServices = AppointmentServices();
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
            if (isUpcoming(doctorAppointments)) ...[
              SizedBox(
                height: deviceSize.height * 0.6,
                child: const Center(
                    child: Text(
                  "No upcoming appointments!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                )),
              ),
            ] else ...[
              for (final appointment in doctorAppointments) ...[
                if (appointment.status == 'confirmed') ...[
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
                                      color: Colors.blue,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  print(appointment.id);
                                  appointmentServices.cancelAppointment(
                                      context: context,
                                      id: appointment.id,
                                      status: 'cancelled');
                                },
                                child: Container(
                                  width: 150,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF4F6FA),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  appointmentServices.completeAppointment(
                                      context: context,
                                      id: appointment.id,
                                      status: 'complete');
                                },
                                child: Container(
                                  width: 150,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                      child: Text(
                                    "Complete",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  )),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ],
          ],
          if (role == 'Patient') ...[
            if (isUpcomingAppointment(appointmentsList)) ...[
              SizedBox(
                height: deviceSize.height * 0.6,
                child: const Center(
                    child: Text(
                  "No appointments scheduled yet!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                )),
              ),
            ] else ...[
              for (final appointment in appointmentsList) ...[
                if (appointment.status == 'confirmed') ...[
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
                                      color: Colors.blue,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  print(appointment.id);
                                  appointmentServices.cancelAppointment(
                                      context: context,
                                      id: appointment.id,
                                      status: 'cancelled');
                                },
                                child: Container(
                                  width: 150,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF4F6FA),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  appointmentServices.getAppointmentInformation(
                                      context: context, id: appointment.id);
                                },
                                child: Container(
                                  width: 150,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Reschedule",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ],
          ],
          if (appointmentsList.length == 1 || doctorAppointments.length == 1)
            SizedBox(
              height: deviceSize.height * 0.2,
            ),
          if (appointmentsList.length == 2 || doctorAppointments.length == 2)
            SizedBox(
              height: deviceSize.height * 0.14,
            ),
        ],
      ),
    );
  }
}
