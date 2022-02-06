import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/user/changeusername.dart';
import 'package:mypill/user/enterdoctorname.dart';
import 'package:mypill/user/enterheightandweight.dart';
import 'package:mypill/user/enteridnumber.dart';
import 'package:mypill/user/userprofile.dart';

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
        padding: const EdgeInsets.only(top: 48.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.blueGrey,
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
                                    fontSize: 18, fontWeight: FontWeight.w600))
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
                                    icon: Icon(Icons.person)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Change Username",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => {
                            Navigator.of(context).pushReplacement(ScaleRoute(
                                page: EnterIdNumber(
                              userData: widget.userData,
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
                                    icon: Icon(Icons.person)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Enter Id Number",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => {
                            Navigator.of(context).pushReplacement(ScaleRoute(
                                page: EnterHeightAndWeight(
                              userData: widget.userData,
                            )))
                          },
                          child: Container(
                            height: 65,
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1))),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () => {}, icon: Icon(Icons.add)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("height & width",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600))
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
                                    icon: Icon(Icons.date_range)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Birth Date",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => {
                            Navigator.of(context).pushReplacement(
                                ScaleRoute(page: EnterDoctorName(userData: widget.userData)))
                          },
                          child: Container(
                            height: 65,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () => {},
                                    icon: Icon(Icons.person)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("My Doctor",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600))
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
