import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/user/guest/login_as_a_guest.dart';

class findPatient extends StatefulWidget {
  User? user;
   findPatient({Key? key,this.user}) : super(key: key);

  @override
  _findPatientState createState() => _findPatientState();
}

class _findPatientState extends State<findPatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 48),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.blueGrey[700]),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () => {
                              Navigator.of(context)
                                  .pushReplacement(ScaleRoute(page: HomePage(user: widget.user,)))
                            },
                        icon: Icon(Icons.arrow_back))
                  ],
                ),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            child: Row(
                              children: [
                                Text(
                                  "Find Patient",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.start,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Enter Patient Phone number"),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 60.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    onPressed: () => {}, child: Text("Enter"))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
