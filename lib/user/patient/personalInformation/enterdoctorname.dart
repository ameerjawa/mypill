import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypill/backend/fireBase/fire-auth.dart';
import 'package:mypill/constants/ColorsHex.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/user/patient/personalInformation/personalinformation.dart';

class EnterDoctorName extends StatefulWidget {
  final userData;
  User? user;
   EnterDoctorName({Key? key, this.userData,this.user}) : super(key: key);

  @override
  _EnterDoctorNameState createState() => _EnterDoctorNameState();
}

class _EnterDoctorNameState extends State<EnterDoctorName> {
  final _formKey = GlobalKey<FormState>();
  var doctorNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 23.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: appBarColorBlue,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => {
                            Navigator.of(context).pushReplacement(ScaleRoute(
                                page: PersonalInformation(
                              userData: widget.userData,
                              user:widget.user
                            )))
                          },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
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
                                icon: Icon(
                                  Icons.person,
                                  color: backgroundColorNeonGreen,
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Text("My Doctor",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: backgroundColorBlueGrotto))
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Form(
                        key: _formKey,
                        child: Column(children: [
                          TextFormField(
                            controller: doctorNameController,
                            decoration: const InputDecoration(
                              labelText: 'Enter Doctor Name',
                            ),
                            validator: (value) {
                              if (value == "") {
                                return 'Doctor name is required';
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 100,
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      backgroundColorBlueGrotto)),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await FireAuth.changeDoctor(
                                      widget.userData["docId"],
                                      doctorNameController.text);
                                  Navigator.of(context)
                                      .pushReplacement(ScaleRoute(
                                          page: PersonalInformation(
                                    userData: widget.userData,
                                    user:widget.user
                                  )));
                                }
                              },
                              child: Text(
                                "Done",
                                style: TextStyle(color: backgroundColorIvory),
                              ),
                            ),
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
