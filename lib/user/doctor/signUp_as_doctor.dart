import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypill/constants/showAlertDialog.dart';
import 'package:mypill/backend/fireBase/fire-auth.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/user/doctor/login_as_a_doctor.dart';
import 'package:mypill/constants/ColorsHex.dart';


import '../main_page.dart';

class SignUpAsDoctor extends StatefulWidget {
  const SignUpAsDoctor({Key? key}) : super(key: key);

  @override
  SignUpAsDoctorState createState() => SignUpAsDoctorState();
}

class SignUpAsDoctorState extends State<SignUpAsDoctor> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController doctorIdController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController doctorNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColorBlue,
        title: Text("Sign Up As Doctor"),
        actions: [
          ElevatedButton(
            style: ButtonStyle(backgroundColor:MaterialStateProperty.all(appBarColorBlue)),
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 80,
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
                      hintText: 'Enter password'),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Must Enter phoneNumber';
                      }
                      return null;
                    }
                  },
                  controller: phoneNumberController,
                  decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: backgroundColorNeonGreen),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Enter Phone Number'),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Must Enter Name';
                      }
                      return null;
                    }
                  },
                  controller: doctorNameController,
                  decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: backgroundColorNeonGreen),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Enter personal Name'),
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
                                await FireAuth.registerUsingEmailPassword(
                                    name: doctorNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                            var data = {
                              "doctorName": doctorNameController.text,
                              "userPhoneNumber": phoneNumberController.text,
                              "doctorEmail": emailController.text,
                              "doctorId": doctorIdController.text
                            };

                            await FireAuth.uploadDataForDoctor(data);

                            if (user != null) {
                              Navigator.pushReplacement(context,
                                  ScaleRoute(page: Login_As_A_Doctor()));
                            } else {
                              showAlertDialog(context, "Something went wrong!");
                            }
                          } else {
                            showAlertDialog(context,
                                "cant login if email or password are empty");
                          }
                        },
                        child: Text("SignUp",style: TextStyle(color: backgroundColorIvory),)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
