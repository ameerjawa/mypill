import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypill/constants/ColorsHex.dart';
import 'package:mypill/constants/showAlertDialog.dart';
import 'package:mypill/backend/fireBase/fire-auth.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/user/patient/patientActions/appointments.dart';
import 'package:mypill/user/patient/personalInformation/changepassworduser.dart';
import 'package:mypill/user/patient/patientActions/findpatient.dart';
import 'package:mypill/user/patient/personalInformation/personalinformation.dart';
import 'package:mypill/user/patient/patientDisplays/pillgloballist.dart';
import 'package:mypill/user/patient/patientDisplays/userprofile.dart';
import 'package:intl/intl.dart';

import '../main_page.dart';
import '../patient/patientDisplays/pilltypes.dart';

class HomePage extends StatefulWidget {
  var strone;
  final User? user;
  final userData;
  var userPillsFromDb;

  HomePage({Key? key, required this.user, this.userData, this.userPillsFromDb})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: backgroundColorIvory);
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');

  // ignore: prefer_final_fields

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  showAlertDialog(BuildContext context, String childTitle, var pills) {
    // set up the button
    Widget CancelButton = FlatButton(
 color: backgroundColorBlueGrotto,
      child: Text("Cancel",style:TextStyle(color: backgroundColorIvory)),      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget DeleteButton = FlatButton(
       color: backgroundColorBlueGrotto,
      child: Text("Delete",style:TextStyle(color: backgroundColorIvory)),
      onPressed: () async {
        pills.removeWhere((element) => element["pillName"] == childTitle);

        if (widget.user != null) {
          await FireAuth.deletePillAsUser(widget.userData["docId"],pills);

         
          setState(() {
            widget.userData["userPills"] = pills;
          });
        } else {
          setState(() {
            widget.userPillsFromDb = pills;
          });
        }

        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Hi user",style: TextStyle(
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
          ),),
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
    var userPills = [];

    userPills = widget.userPillsFromDb == null
        ? widget.user == null
            ? []
            : widget.userData["userPills"]
        : widget.userPillsFromDb;

    print("userPills -> ${userPills}");

    String formattedDate = formatter.format(now);

    List<Widget> _widgetOptions = <Widget>[
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(color: Colors.blue[50]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        "Today , ${formattedDate.split('-').reversed.join('-')}")
                  ],
                ),
              ),
            ),
            Container(
              height: 800,
              child: Center(
                  child: Container(
                      height: 70,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[400],
                      ),
                      child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(backgroundColorBlueGrotto)),
                          onPressed: () async {
                            var globalpills =
                                await FireAuth.getAllPillsFromGlobalListFireBase();

                            Navigator.of(context).pushReplacement(ScaleRoute(
                                page: PillGlobalList(
                                    user: widget.user,
                                    userData: widget.userData,
                                    globalList: globalpills,
                                    userPillsFromDb: widget.userPillsFromDb)));
                          },
                          child: Text("add Medicine",style: TextStyle(color: backgroundColorIvory),)))),
            ),
          ],
        ),
      ),
      Container(
        height:800,
        child: Column(
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(color: Colors.blue[50]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Today , ${formattedDate.split('-').reversed.join('-')}")
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: userPills.length,
                  itemBuilder: (strone, index) {
                    return Column(
                      children:[ Padding(
                        padding: const EdgeInsets.only(left: 5,right:5),
                        child: Container(
                          decoration:BoxDecoration(
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
                              userPills[index]["pillName"] != null
                                  ? userPills[index]["pillName"]
                                  : "",
                              style:  TextStyle(
                                      fontSize: 30,
                                      color: backgroundColorBlueGrotto,
                                      fontFamily: 'Rowdies',fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              " ${userPills[index]["description"] != null ? userPills[index]["description"] : ""} - Time > ${userPills[index]["time"] != null ? userPills[index]["time"] : ""}",
                            ),
                            onTap: () async {
                              showAlertDialog(
                                  context, userPills[index]["pillName"], userPills);
                            },
                          ),
                        ),
                      ),SizedBox(height: 10,)],
                    );
                  }),
            ),
          ],
        ),
      ),
      MoreSettings(
        user: widget.user,
        userData: widget.userData,
      ),
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: SingleChildScrollView(
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
                                  userData: widget.userData)))
                        },
                        icon: Icon(
                          Icons.account_circle_rounded,
                          size: 40,
                          color: backgroundColorNeonGreen,
                        ),
                      ),
                      Text(
                        'Hi ${widget.userData?["username"] != null ? widget.userData["username"] : "Guest"} ',
                        style: optionStyle,
                      ),
                      IconButton(
                          onPressed: () => {
                                Navigator.of(context)
                                    .pushReplacement(ScaleRoute(
                                        page: SpecifecPillTypes(
                                  user: widget.user,
                                  userData: widget.userData,
                                )))
                              },
                          icon: Icon(
                            Icons.add_circle,
                            size: 40,
                            color: backgroundColorNeonGreen,
                          ))
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(),
                    child: _widgetOptions.elementAt(_selectedIndex)),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_rounded),
            label: 'MyList',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: backgroundColorNeonGreen,
        onTap: _onItemTapped,
      ),
    );
  }
}

class MoreSettings extends StatelessWidget {
  User? user;
  final userData;
  MoreSettings({Key? key, this.user, this.userData}) : super(key: key);

  Future<List<dynamic>> getUserAppointments() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("appoinments").get();

    // Get data from docs and convert map to List
    final appointments = [];
    print("yes im in ");

    querySnapshot.docs.forEach((element) {
      print("ELEMENTS ${element.id}");
      print("this user -> ${this.user?.email}");

      if (element.get("userEmail") == this.user?.email) {
        appointments.add(element.data());
      }
    });

    return appointments;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 320,
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Privacy & Security",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () async {
                  if (this.user != null) {
                    var userAppointments = await getUserAppointments();
                    print("userAppointments ${userAppointments}");

                    Navigator.of(context).pushReplacement(ScaleRoute(
                        page: Appointments(
                      user: this.user,
                      userAppointments: userAppointments,
                      userData: userData,
                    )));
                  } else {
                    showAlertDialog(context, "Access Denied for Guest");
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                        width: 0.4, color: Colors.lightBlue.shade900),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.calendar_today_outlined,color: backgroundColorNeonGreen,)),
                      SizedBox(
                        width: 24,
                      ),
                      Text(
                        "Appointment",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600,fontFamily: 'Rowdies'),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => {
                  if (this.user != null)
                    {
                      Navigator.of(context).pushReplacement(ScaleRoute(
                          page: PersonalInformation(
                        user: this.user,
                        userData: this.userData,
                      )))
                    }
                  else
                    {showAlertDialog(context, "Access Denied for Guest")}
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                        width: 0.4, color: Colors.lightBlue.shade900),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.person_pin_outlined,color: backgroundColorNeonGreen)),
                      SizedBox(
                        width: 24,
                      ),
                      Text("Personal Information",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600,fontFamily: 'Rowdies'))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => {
                  if (this.user != null)
                    {
                      Navigator.of(context).pushReplacement(ScaleRoute(
                          page: ChangePasswordUser(
                        user: this.user,
                        userData: this.userData,
                      )))
                    }
                  else
                    {showAlertDialog(context, "Access Denied for Guest")}
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                        width: 0.4, color: Colors.lightBlue.shade900),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.change_circle_rounded,color: backgroundColorNeonGreen)),
                      SizedBox(
                        width: 24,
                      ),
                      Text("Change Password",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600,fontFamily: 'Rowdies'))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}

class ViewselectedPill extends StatelessWidget {
  const ViewselectedPill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: 320,
          decoration: BoxDecoration(color: Colors.white70),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cocaine",
                      style: TextStyle(fontSize: 30),
                    ),
                    Icon(
                      Icons.volume_up,
                      size: 30,
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("5 mg Of Cocaine",
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("1 Dose Per Day",
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Edit Time ", style: TextStyle(fontSize: 18)),
                          ],
                        )
                      ],
                    ),
                    Container(
                        width: 220,
                        child: Center(
                          child: Text(
                            "Note",
                            style: TextStyle(fontSize: 24),
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => {},
                        child: Text("Save"),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blueGrey)),
                      ),
                      ElevatedButton(
                          onPressed: () => {},
                          child: Text("Delete"),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red[400])))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
