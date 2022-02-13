import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypill/backend/fireBase/fire-auth.dart';
import 'package:mypill/constants/ColorsHex.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/user/patient/personalInformation/changeusername.dart';
import 'package:mypill/user/patient/personalInformation/enterdoctorname.dart';
import 'package:mypill/user/patient/personalInformation/enterheightandweight.dart';
import 'package:mypill/user/patient/personalInformation/enteridnumber.dart';
import 'package:mypill/user/patient/patientDisplays/userprofile.dart';

import 'package:share/share.dart';

class PersonalInformation extends StatefulWidget {
  User? user;
  final userData;
  PersonalInformation({Key? key, this.user, this.userData}) : super(key: key);

  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  var date;
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
                                page: UserProfile(
                              userData: widget.userData,
                              user: widget.user,
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
                height: 400,
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      // ignore: avoid_unnecessary_containers
                      Container(
                        child: Row(
                          children: [
                            Text("Personal Information",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600,color: backgroundColorBlueGrotto))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(children: [
                        InkWell(
                          onTap: () => {
                            Navigator.of(context).pushReplacement(ScaleRoute(
                                page: ChangeUserName(
                              userData: widget.userData,
                              user:widget.user
                            )))
                          },
                          child: Container(
                            height: 65,
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1))),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () => {},
                                    icon: Icon(Icons.person,color: backgroundColorNeonGreen)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Change Username",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,color: backgroundColorBlueGrotto))
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => {
                            Navigator.of(context).pushReplacement(ScaleRoute(
                                page: EnterIdNumber(
                              userData: widget.userData,
                              user: widget.user,
                            )))
                          },
                          child: Container(
                            height: 65,
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1))),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () => {},
                                    icon: Icon(Icons.person,color: backgroundColorNeonGreen)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Enter Id Number",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,color: backgroundColorBlueGrotto))
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => {
                            Navigator.of(context).pushReplacement(ScaleRoute(
                                page: EnterHeightAndWeight(
                              userData: widget.userData,
                              user:widget.user
                            )))
                          },
                          child: Container(
                            height: 65,
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1))),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () => {}, icon: Icon(Icons.add,color: backgroundColorNeonGreen)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("height & Weight",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,color: backgroundColorBlueGrotto))
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));
                            if (date != null) {
                              await FireAuth.updateBirthDate(
                                  widget.userData["docId"], date);
                              FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(widget.userData["docId"])
                                  .update({"birthDate": date});
                            }
                          },
                          child: Container(
                            height: 65,
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1))),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () => {},
                                    icon: Icon(Icons.date_range,color: backgroundColorNeonGreen)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Birth Date",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,color: backgroundColorBlueGrotto))
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => {
                            Navigator.of(context).pushReplacement(ScaleRoute(
                                page:
                                    EnterDoctorName(userData: widget.userData,user: widget.user,)))
                          },
                          child: Container(
                            height: 65,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () => {},
                                    icon: Icon(Icons.person,color: backgroundColorNeonGreen,)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("My Doctor",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,color: backgroundColorBlueGrotto))
                              ],
                            ),
                          ),
                        ),
                      ]),
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
