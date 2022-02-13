import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypill/constants/ColorsHex.dart';
import 'package:mypill/constants/showAlertDialog.dart';
import 'package:mypill/backend/fireBase/fire-auth.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/user/patient/patientActions/appointments.dart';

class AddAppointment extends StatefulWidget {
  final doctors;
  final User? user;
  final userAppointments;
  final userData;

  const AddAppointment(
      {Key? key, this.doctors, this.user, this.userAppointments,this.userData})
      : super(key: key);

  @override
  _AddAppointmentState createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  var date;
  var selectedDoctor;
  TextEditingController dateController = new TextEditingController();
  TextEditingController doctorNameController = new TextEditingController();
  TextEditingController appoinmentTitleController = new TextEditingController();
  TextEditingController appoinmentLocationController =
      new TextEditingController();
  TextEditingController appoinmentDiscreptionController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<dynamic> doctors = widget.doctors;
    List<String> doctorsNames = [];
    // The logic to find out which ones should appear
    doctors.forEach((element) {
      doctorsNames.add(element["doctorName"]);
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 23.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: appBarColorBlue,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () => {
                              Navigator.of(context).pushReplacement(ScaleRoute(
                                  page: Appointments(
                                user: widget.user,
                                userAppointments: widget.userAppointments,
                                userData: widget.userData,
                              )))
                            },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: backgroundColorIvory,
                        ))
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        // ignore: avoid_unnecessary_containers
                        Container(
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () => {},
                                  icon: Icon(Icons.change_circle_rounded,color: backgroundColorNeonGreen,)),
                              SizedBox(
                                width: 20,
                              ),
                              Text("Add New Appointment",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,color: backgroundColorBlueGrotto))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Column(children: [
                          TextFormField(
                            controller: appoinmentTitleController,
                            decoration: const InputDecoration(
                              labelText: 'Enter Appointment Title',
                            ),
                            validator: (value) {
                              if (value == "") {
                                return 'Appointment Title is required';
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "enter doctor name",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                          Autocomplete<String>(
                            optionsBuilder: (TextEditingValue value) {
                              // When the field is empty
                              if (value.text.isEmpty) {
                                return [];
                              }

                              return doctorsNames.where((suggestion) =>
                                  suggestion
                                      .toLowerCase()
                                      .contains(value.text.toLowerCase()));
                            },
                            onSelected: (value) {
                              setState(() {
                                selectedDoctor = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: dateController,
                            onTap: () async {
                              date = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(hour: 10, minute: 5));

                              var minutes = date.minute < 10
                                  ? "0${date.minute}"
                                  : date.minute;

                              var hours =
                                  date.hour < 10 ? "0${date.hour}" : date.hour;

                              dateController.text = "${hours} : ${minutes}";
                            },
                            decoration: const InputDecoration(
                              labelText: 'pick a time for the appointment',
                            ),
                            validator: (value) {
                              if (value == "") {
                                return 'Retype New Password is required';
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: appoinmentLocationController,
                            decoration: const InputDecoration(
                              labelText: 'Enter Appointment Location',
                            ),
                            validator: (value) {
                              if (value == "") {
                                return 'Appointment Location is required';
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: appoinmentDiscreptionController,
                            decoration: const InputDecoration(
                              labelText: 'Enter Appointment Description',
                            ),
                            validator: (value) {},
                          ),
                          Container(
                            height: 120,
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      backgroundColorBlueGrotto)),
                              onPressed: () async {
                                if (appoinmentTitleController.text == "" ||
                                    selectedDoctor.toString() == "" ||
                                    dateController.text == "" ||
                                    appoinmentLocationController.text == "" ||
                                    appoinmentDiscreptionController.text ==
                                        "") {
                                  showAlertDialog(
                                      context, "wrong or empty fields");
                                } else {
                                  var data = {
                                    "userEmail": widget.user?.email.toString(),
                                    "title":
                                        appoinmentTitleController.text != null
                                            ? appoinmentTitleController.text
                                            : "",
                                    "doctorName":
                                        selectedDoctor.toString() != null
                                            ? selectedDoctor.toString()
                                            : "",
                                    "time": dateController.text != null
                                        ? dateController.text
                                        : "",
                                    "location":
                                        appoinmentLocationController.text !=
                                                null
                                            ? appoinmentLocationController.text
                                            : "",
                                    "discreption":
                                        appoinmentDiscreptionController.text !=
                                                null
                                            ? appoinmentDiscreptionController
                                                .text
                                            : ""
                                  };

                                  await FireAuth.addAppointmentAsUser(data);
                                  widget.userAppointments.add(data);

                                  Navigator.of(context).pushReplacement(
                                      ScaleRoute(
                                          page: Appointments(
                                              user: widget.user,
                                              userAppointments:
                                                  widget.userAppointments)));
                                }
                              },
                              child: Text("Done",style:TextStyle(color: backgroundColorIvory)),
                            ),
                          )
                        ]),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
