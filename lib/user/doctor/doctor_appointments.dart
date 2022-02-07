import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mypill/backend/fireBase/fire-auth.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/user/patient/patientActions/addappointment.dart';
import 'package:mypill/user/doctor/searchForUser.dart';
import 'package:mypill/user/patient/patientDisplays/userprofile.dart';

class DoctorAppointments extends StatefulWidget {
  var userAppointments;
  var users;
  var doctor;
  DoctorAppointments({Key? key, this.users, this.userAppointments, this.doctor})
      : super(key: key);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<DoctorAppointments> {
  showAlertDialog(BuildContext context, String childTitle, var appointments) {
    // set up the button
    Widget CancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget deleteButton =  FlatButton(
      child: Text("Delete"),
      onPressed: () async {
        appointments.removeWhere((element) => element["title"] == childTitle);

        await FireAuth.deleteAppointmentByTitle(
            childTitle, widget.doctor["doctorName"]);

        setState(() {
          widget.userAppointments = appointments;
        });

        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Hi user"),
      content: Text(childTitle),
      actions: [CancelButton, deleteButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var appointments = widget.userAppointments;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(color: Colors.blueGrey[700]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => {
                        Navigator.of(context).pushReplacement(ScaleRoute(
                            page: SearchForUser(
                          doctor: widget.doctor,
                          users: widget.users,
                        )))
                      },
                      icon: Icon(
                        Icons.account_circle_rounded,
                        size: 40,
                        color: Colors.pink[50],
                      ),
                    ),
                    Center(
                        child: Text(
                      "Your Appoinments",
                      style: TextStyle(fontSize: 25),
                    )),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: appointments.map<Widget>((strone) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.indigoAccent, spreadRadius: 3),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              '${strone["title"]}',
                              style: TextStyle(fontSize: 30),
                            ),
                            subtitle: Text(
                                "time: ${strone["time"]} , location: ${strone["location"]} , Doctor ${strone["doctorName"]}"),
                            onTap: () async {
                              showAlertDialog(
                                  context, strone["title"], appointments);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
