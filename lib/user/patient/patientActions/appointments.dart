import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mypill/backend/fireBase/fire-auth.dart';
import 'package:mypill/constants/ColorsHex.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/user/patient/patientActions/addappointment.dart';
import 'package:mypill/user/patient/patientDisplays/userprofile.dart';

class Appointments extends StatefulWidget {
  User? user;
  var userAppointments;
  final userData;
  Appointments({Key? key, this.user, this.userAppointments, this.userData})
      : super(key: key);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  showAlertDialog(BuildContext context, String childTitle, var appointments) {
    // set up the button
    Widget CancelButton = FlatButton(
    color: backgroundColorBlueGrotto,

      child: Text("Cancel",style:TextStyle(color: backgroundColorIvory)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget DeleteButton = FlatButton(
             color: backgroundColorBlueGrotto,

      
      child: Text("Delete",style:TextStyle(color: backgroundColorIvory)),
      onPressed: () async {
        appointments.removeWhere((element) => element["title"] == childTitle);

        if (widget.user != null) {
          await FireAuth.deleteAppointmentAsUser(
              childTitle, widget.user?.email);

          setState(() {
            widget.userAppointments = appointments;
          });
        }

        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Hi user",style:TextStyle(
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
      content: Text(childTitle,style:TextStyle(color: backgroundColorBlueGrotto)),
      actions: [CancelButton, DeleteButton],
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
    print("appointments -> ${appointments}");

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(color: appBarColorBlue),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => {
                        Navigator.of(context).pushReplacement(ScaleRoute(
                            page: UserProfile(
                          user: widget.user,
                          userData: widget.userData,
                        )))
                      },
                      icon: Icon(
                        Icons.account_circle_rounded,
                        size: 40,
                        color: backgroundColorNeonGreen,
                      ),
                    ),
                    Center(
                        child: Text(
                      "Your Appoinments",
                      style: TextStyle(fontSize: 25),
                    )),
                    IconButton(
                        onPressed: () async {
                          var doctors = await FireAuth.getAllDoctorsForUsers();

                          Navigator.of(context).pushReplacement(ScaleRoute(
                              page: AddAppointment(
                                  doctors: doctors,
                                  user: widget.user,
                                  userAppointments: widget.userAppointments,userData:widget.userData)));
                        },
                        icon: Icon(
                          Icons.add_circle,
                          size: 40,
                          color: backgroundColorNeonGreen
                        ))
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
                                  color: backgroundColorNeonGreen, spreadRadius: 3),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              '${strone["title"]}',
                              style: TextStyle(fontSize: 30,color: backgroundColorBlueGrotto,fontWeight: FontWeight.bold),
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
