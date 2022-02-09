import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mypill/backend/fireBase/fire-auth.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/user/patient/patientActions/addappointment.dart';
import 'package:mypill/user/doctor/searchForUser.dart';
import 'package:mypill/user/patient/patientDisplays/userprofile.dart';
import 'package:mypill/constants/ColorsHex.dart';

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
       color: backgroundColorBlueGrotto,
      child: Text("Cancel",style:TextStyle(color: backgroundColorIvory)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget deleteButton = FlatButton(
       color: backgroundColorBlueGrotto,
      child: Text("Delete",style:TextStyle(color: backgroundColorIvory)),
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
      title: Text("Hi Doctor",style:TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.italic,
            fontFamily: 'Rowdies',
            shadows: [
              Shadow(
                color: backgroundColorBlueGrotto,
                blurRadius: 10.0,
                offset: Offset(5.0, 5.0),
              ),
              Shadow(
                color: backgroundColorNeonGreen,
                blurRadius: 10.0,
                offset: Offset(-5.0, 5.0),
              ),
            ],
          )),
      content: Text("appointment title : ${childTitle}",style:TextStyle(color: backgroundColorBlueGrotto)),
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
      body: Container(
        decoration: BoxDecoration(color: backgroundColorIvory),
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(color: appBarColorBlue),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(appBarColorBlue)),
                        onPressed: () => {
                          Navigator.of(context).pushReplacement(ScaleRoute(
                              page: SearchForUser(
                            doctor: widget.doctor,
                            users: widget.users,
                          )))
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 40,
                          color: Colors.pink[50],
                        ),
                      ),
                      Center(
                          child: Text(
                        "Your Appoinments",
                        style: TextStyle(fontSize: 25, color: Colors.white),
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
                                    color: backgroundColorNeonGreen,
                                    spreadRadius: 3),
                              ],
                            ),
                            child: ListTile(
                              title: Text(
                                '${strone["title"]}',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: backgroundColorBlueGrotto,
                                    fontFamily: 'Rowdies'),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                    "time: ${strone["time"]} , location: ${strone["location"]} , Doctor ${strone["doctorName"]} \nuserEmail : ${strone['userEmail']}"),
                              ),
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
      ),
    );
  }
}
