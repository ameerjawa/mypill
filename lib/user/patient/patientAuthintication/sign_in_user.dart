import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypill/constants/showAlertDialog.dart';
import 'package:mypill/backend/fireBase/fire-auth.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/backend/googleApi/googleSignIn.dart';
import 'package:mypill/user/guest/login_as_a_guest.dart';
import 'package:mypill/user/main_page.dart';

class SignInUser extends StatefulWidget {
  const SignInUser({Key? key}) : super(key: key);

  @override
  _SignInUserState createState() => _SignInUserState();
}

class _SignInUserState extends State<SignInUser> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In s User"),
        actions: [
          ElevatedButton(
              onPressed: () => {
                    Navigator.of(context)
                        .pushReplacement(ScaleRoute(page: MainPage()))
                  },
              child: Icon(
                Icons.arrow_back,
              ))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 80,),
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
                        borderSide: BorderSide(width: 3, color: Colors.blue),
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
                        return 'Must Enter password';
                      }
                      return null;
                    }
                  },
                  controller: passwordController,
                  decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.blue),
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
                Container(
                    width: 300,
                    child: ElevatedButton(
                        style: ButtonStyle(),
                        onPressed: () async {
                          if (emailController.text != null &&
                              passwordController.text != null) {
                            User? user =
                                await FireAuth.signInUsingEmailPassword(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context);
                            if (user != null) {
                              var userData = {};
                              var docId = "";
                              await FirebaseFirestore.instance
                                  .collection('Users')
                                  .where('userEmail',
                                      isEqualTo: emailController.text)
                                  .get()
                                  .then((value) => {
                                        userData = value.docs.first.data(),
                                        docId = value.docs.first.id,
                                        userData["docId"] = docId
                                      });
                              var userPillsFromFirebase = userData["userPills"];

                              Navigator.pushReplacement(
                                  context,
                                  ScaleRoute(
                                      page: HomePage(
                                    user: user,
                                    userData: userData,
                                  )));
                            } else {
                              showAlertDialog(context, "something went wrong");
                            }
                          } else {
                            showAlertDialog(context,
                                "cant login if email or password are empty");
                          }
                        },
                        child: Text("login"))),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text("OR"),
                ),
                SizedBox(
                  height: 40,
                ),
             
                Container(
                    width: 200,
                    child: ElevatedButton(
                        style: ButtonStyle(),
                        onPressed: () async {
                          User? user = await signInWithGoogle();

                          print("user -> ${user}");
                          if (user != null) {
                            var userData = await FireAuth.getUserDataFireStore(user.email);


                     
                            if (userData == null) {
                              var data = {
                                "username": user.displayName,
                                "userPhoneNumber": user.phoneNumber,
                                "userEmail": user.email,
                                "userPills": []
                              };
                              userData = data;
                              await FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc()
                                  .set(data);
                            }
                            Navigator.pushReplacement(
                                context,
                                ScaleRoute(
                                    page: HomePage(
                                  user: user,
                                  userData: userData,
                                  userPillsFromDb: [],
                                )));
                          } else {
                            showAlertDialog(context, "something went wrong");
                          }
                        },
                        child: Text("login with google"))),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
    );
  }
}
