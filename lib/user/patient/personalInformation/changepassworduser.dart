// ignore: file_names
// ignore: file_names
// ignore_for_file: prefer_const_constructors, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mypill/backend/fireBase/fire-auth.dart';
import 'package:mypill/constants/ColorsHex.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/user/patient/patientDisplays/userprofile.dart';

class ChangePasswordUser extends StatefulWidget {
  User? user;
  final userData;

  ChangePasswordUser({Key? key, this.user, this.userData}) : super(key: key);

  @override
  _ChangePasswordUserState createState() => _ChangePasswordUserState();
}

class _ChangePasswordUserState extends State<ChangePasswordUser> {
  var oldPasswordController = TextEditingController();
  var newPasswordFirstController = TextEditingController();
  var newPasswordSecondController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 22.0),
        child: SingleChildScrollView(
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
                                  page: UserProfile(
                                      user: widget.user,
                                      userData: widget.userData)))
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
                  height: 470,
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
                              Text("Change Password",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,color: backgroundColorBlueGrotto))
                            ],
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(children: [
                              TextFormField(
                                controller: oldPasswordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Old Password',
                                ),
                                validator: (value) {
                                  if (value == "") {
                                    return 'Old Password is required';
                                  } else if (value !=
                                      widget.userData["userPassword"]) {
                                    return 'old password is incorrect';
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: newPasswordFirstController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'New Password',
                                ),
                                validator: (value) {
                                  if (value == "") {
                                    return 'New Password is required';
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: newPasswordSecondController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Retype New Password',
                                ),
                                validator: (value) {
                                  if (value == "") {
                                    return 'Retype New Password is required';
                                  } else if (newPasswordFirstController.text !=
                                      newPasswordSecondController.text) {
                                    return "New Passwords does not match";
                                  }
                                },
                              ),
                              Container(
                                height: 100,
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              backgroundColorBlueGrotto)),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      widget.user
                                          ?.updatePassword(
                                              newPasswordFirstController.text)
                                          .then((value) => {
                                                FireAuth
                                                    .updateUserPasswordFireStore(
                                                        widget
                                                            .userData["docId"],
                                                        newPasswordFirstController
                                                            .text),
                                                Navigator.of(context)
                                                    .pushReplacement(ScaleRoute(
                                                        page: UserProfile(
                                                  user: widget.user,
                                                  userData: widget.userData,
                                                )))
                                              })
                                          .catchError((err) => print(err));
                                    }
                                  },
                                  child: Text("Done",style: TextStyle(color: backgroundColorIvory),),
                                ),
                              )
                            ]),
                          ),
                        ),
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
