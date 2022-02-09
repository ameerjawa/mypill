import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypill/constants/ColorsHex.dart';
import 'package:mypill/constants/showAlertDialog.dart';
import 'package:mypill/backend/fireBase/fire-auth.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/user/doctor/searchForUser.dart';

import '../main_page.dart';

class Login_As_A_Doctor extends StatefulWidget {
  const Login_As_A_Doctor({Key? key}) : super(key: key);

  @override
  _Login_As_A_DoctorState createState() => _Login_As_A_DoctorState();
}

class _Login_As_A_DoctorState extends State<Login_As_A_Doctor> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController doctorIdController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColorBlue,
        title: Text("SignIn As Doctor"),
        actions: [
          ElevatedButton(
            style:ButtonStyle(backgroundColor: MaterialStateProperty.all(appBarColorBlue)),
              onPressed: () => {
                    Navigator.of(context)
                        .pushReplacement(ScaleRoute(page: MainPage()))
                  },
              child: Icon(
                Icons.arrow_back,
              ))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: backgroundColorIvory),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                TextFormField(
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Must Enter email';
                      }
                      return null;
                    }
                  },
                  controller: emailController,
                  decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: backgroundColorNeonGreen),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Enter Email'),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Must Enter id';
                      }
                      return null;
                    }
                  },
                  controller: doctorIdController,
                  decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: backgroundColorNeonGreen),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Enter ID'),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Must Enter password';
                      }
                      return null;
                    }
                  },
                  controller: passwordController,
                  decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: backgroundColorNeonGreen),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Enter Your password'),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    width: 300,
                    child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(backgroundColorBlueGrotto)),
                        onPressed: () async {
                          if (emailController.text != null &&
                              passwordController.text != null) {
                            User? user =
                                await FireAuth.signInUsingEmailPassword(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context);
                            if (user != null) {

                              // get doctor details
                              var doctorData = await FireAuth.getDoctorDetails(
                                  emailController.text);

                             
                              // get all users names to let the doctor search and filter them
                              var users = await FireAuth.getAllUsersForDoctor();

                              Navigator.pushReplacement(
                                  context,
                                  ScaleRoute(
                                      page: SearchForUser(
                                          doctor: doctorData, users: users)));
                            } else {
                              showAlertDialog(context, "something went wrong");
                            }
                          } else {
                            showAlertDialog(context,
                                "cant login if email or password are empty");
                          }
                        },
                        child: Text("login",style:TextStyle(color: backgroundColorIvory,fontSize: 18))))
              ],
            ),
          ),
        ),
      ),
    );
  }
}


