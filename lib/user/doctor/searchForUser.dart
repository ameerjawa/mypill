import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypill/constants/showAlertDialog.dart';
import 'package:mypill/backend/fireBase/fire-auth.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/backend/googleApi/googleSignIn.dart';

import '../main_page.dart';
import 'doctor_appointments.dart';

class SearchForUser extends StatefulWidget {
  var users;
  var doctor;
  SearchForUser({Key? key, this.doctor, this.users}) : super(key: key);

  @override
  SearchForUserState createState() => SearchForUserState(users);
}

class SearchForUserState extends State<SearchForUser> {
  var pills = [];

  var filteredPills = [];
  var users;

  SearchForUserState(this.users);
  @override
  void initState() {
    filteredPills.addAll(this.users);
    super.initState();
  }

  void filterSearchResults(String query) {
    var dummySearchList = [];
    dummySearchList.addAll(pills);
    if (query.isNotEmpty) {
      var dummyListData = [];
      dummySearchList.forEach((item) {
        print("item ${item}");
        if (item["userPhoneNumber"] != null) {
          if (item["userPhoneNumber"].contains(query) ||
              item["username"].contains(query)) {
            dummyListData.add(item);
          }
        } else {
          if (item["username"].contains(query)) {
            dummyListData.add(item);
          }
        }
      });
      setState(() {
        filteredPills.clear();
        filteredPills.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        filteredPills.clear();
        filteredPills.addAll(pills);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("users -->${widget.users}");
    pills = widget.users;

    return Scaffold(
      appBar: AppBar(
        title: Text("Hi D'r ${widget.doctor['doctorName']}"),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey)),
            onPressed: () async {
              var doctor_appointments = await FireAuth.getDoctorAppointments(
                  widget.doctor['doctorName']);

              Navigator.of(context).pushReplacement(ScaleRoute(
                  page: DoctorAppointments(
                doctor: widget.doctor,
                users: widget.users,
                userAppointments: doctor_appointments,
              )));
            },
            child: Text("appointments"),
          ),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            onPressed: () async {
              await FireAuth.userSignOutAuth();

              Navigator.of(context)
                  .pushReplacement(ScaleRoute(page: MainPage()));
            },
            child: Text("logout"),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.blueGrey),
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.search),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (value) => {filterSearchResults(value)},
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search Users By Name or Phone",
                                hintStyle: TextStyle()),
                          ),
                        ),
                        Icon(
                          Icons.mic_none_sharp,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: filteredPills.map((strone) {

                    return Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: Colors.blueGrey, width: 1.0))),
                      child: ListTile(
                        title: Text(
                          strone["username"],
                          style: TextStyle(fontSize: 30),
                        ),
                        subtitle: Text(strone["userPhoneNumber"] != null
                            ? strone["userPhoneNumber"]
                            : "user does'nt provide phone number "),
                        onTap: () async {
                          showAlertDialog(context, strone);
                        
                        },
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

  showAlertDialog(BuildContext context, var userData) {
    // set up the button
    Widget okButton = FlatButton(
      color: Colors.purple[800],
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    var pillsString = " ";
    if (userData["userPills"] != null) {
      if (userData["userPills"].length > 0) {
        for (var i = 0; i < 3; i++) {
          pillsString += "  ${i + 1}. " +
              userData["userPills"][i]["pillName"].toString() +
              "\n ";
        }
      } else {
        pillsString = "user does'nt add any pill";
      }
    }

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      scrollable: true,
      title: Text("User Details ",
          style: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.italic,
            shadows: [
              Shadow(
                color: Colors.blue,
                blurRadius: 10.0,
                offset: Offset(5.0, 5.0),
              ),
              Shadow(
                color: Colors.red,
                blurRadius: 10.0,
                offset: Offset(-5.0, 5.0),
              ),
            ],
          )),
      content: Container(
        height: 200,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Username : ${userData["username"]}"),
              ],
            ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("user Email : ${userData["userEmail"]}"),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    "user phone number : ${userData["userPhoneNumber"] != null ? userData["userPhoneNumber"] : "none"}"),
              ],
            ),

            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("user pills :  "),
                SizedBox(
                  width: 10,
                ),
                Text(pillsString)
              ],
            )
            //  SizedBox(height:10),
            //  Text("user phone number : ${userData["userPhoneNumber"]}")
          ],
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
