import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mypill/constants/ColorsHex.dart';
import 'package:mypill/constants/showAlertDialog.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/backend/fireBase/fire-auth.dart';
import 'package:mypill/user/patient/patientAuthintication/sign_in_user.dart';
import 'dart:math';

import '../../main_page.dart';

class SignUpAsUser extends StatefulWidget {
  const SignUpAsUser({Key? key}) : super(key: key);

  @override
  _SignUpAsUserState createState() => _SignUpAsUserState();
}

class _SignUpAsUserState extends State<SignUpAsUser> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController passwordVerifyController = new TextEditingController();
  TextEditingController phonenumberController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<User?> user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:appBarColorBlue,
        title: Text("Sign Up As User"),
        actions: [
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(appBarColorBlue)),
              onPressed: () => {
                    Navigator.of(context)
                        .pushReplacement(ScaleRoute(page: MainPage()))
                  },
              child: Icon(
                Icons.arrow_back,
              ))
        ],
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }
                    },
                    controller: usernameController,
                    decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: backgroundColorNeonGreen),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.red),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Enter UserName'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
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
                    obscureText: true,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
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
                        hintText: 'Enter Password'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }
                    },
                    controller: passwordVerifyController,
                    decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: backgroundColorNeonGreen),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.red),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'verify Password'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }
                    },
                    controller: phonenumberController,
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
                  Container(
                      width: 300,
                      child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(backgroundColorBlueGrotto)),
                          onPressed: () async {
                            if (passwordController.text ==
                                passwordVerifyController.text) {
                              var usersImages = [
                                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                "https://media.istockphoto.com/photos/millennial-male-team-leader-organize-virtual-workshop-with-employees-picture-id1300972574?b=1&k=20&m=1300972574&s=170667a&w=0&h=2nBGC7tr0kWIU8zRQ3dMg-C5JLo9H2sNUuDjQ5mlYfo=",
                                "https://upload.wikimedia.org/wikipedia/en/2/2f/Profile_image_Nadia_Lim_chef_2014.jpg",
                                "https://image.shutterstock.com/image-photo/young-adult-profile-picture-red-600w-1655747050.jpg",
                                "https://image.shutterstock.com/image-photo/portrait-smiling-red-haired-millennial-600w-1194497251.jpg",
                                "https://image.shutterstock.com/image-photo/young-hispanic-latino-businessman-walking-600w-1152383948.jpg"
                              ];

                              Random random = new Random();
                              int randomNumber =
                                  random.nextInt(usersImages.length);

                              User? user =
                                  await FireAuth.registerUsingEmailPassword(
                                      name: usernameController.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                              var data = {
                                "username": usernameController.text,
                                "userPhoneNumber": phonenumberController.text,
                                "userEmail": emailController.text,
                                "userPassword": passwordController.text,
                                "userPills": [],
                                "userPhoto": usersImages[randomNumber]
                              };

                              await FireAuth.UploadUserDetails(data);
                              FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc()
                                  .set(data);

                              if (user != null) {
                                Navigator.pushReplacement(
                                    context, ScaleRoute(page: SignInUser()));
                              } else {
                                showAlertDialog(
                                    context, "Something went wrong!");
                              }
                              // do signup function
                            } else {
                              // display meesage that the passwords not matching each other
                              showAlertDialog(context, "Passwords Not Match!");
                            }
                          },
                          child: Text("Sign up",style: TextStyle(color: backgroundColorIvory),))),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
