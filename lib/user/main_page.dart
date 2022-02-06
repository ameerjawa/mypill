import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/user/doctor/login_as_a_doctor.dart';
import 'package:mypill/user/guest/login_as_a_guest.dart';
import 'package:mypill/user/sign_in_user.dart';
import 'package:mypill/user/sign_up_user.dart';

import 'doctor/signUp_as_doctor.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _signInUserState createState() => _signInUserState();
}

class _signInUserState extends State<MainPage> {

  User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.blueGrey[900]),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Text('MyPill',
                    style: GoogleFonts.luckiestGuy(
                        textStyle: TextStyle(
                            letterSpacing: 10,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.blue[400]))),
                SizedBox(
                  height: 60,
                ),
                Text(
                    "App that will keep track of your medicine and \n                            medical status",style:TextStyle(color: Colors.blue[50]
                    ),),
                SizedBox(
                  height: 15,
                ),
                Text("We will save you some headache",style: TextStyle(color: Colors.blue[50]),),
                SizedBox(
                  height: 240,
                ),
                Center(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
          
                      children:[ Column(
                        children: [
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () => {
                                  Navigator.of(context)
                                       .pushReplacement(ScaleRoute(page: Login_As_A_Doctor()))
                                },
                                child: Text("Doc login",style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white
                    )),),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.grey[700])),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(onPressed: () => {
                                
                                  Navigator.of(context)
                                       .pushReplacement(ScaleRoute(page: HomePage(user: user,)))
                              }, child: Text("Guest",style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white
                    )),),style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.grey[700])),)
                            ],
                          ),
                          Row(
                            children: [
                              ElevatedButton(onPressed: () => {
                                  Navigator.of(context)
                                       .pushReplacement(ScaleRoute(page: SignInUser()))
                              }, child: Text("SignIn",style:GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white
                    ))),style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.grey[700])),),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(onPressed: () => {
                                  Navigator.of(context)
                                       .pushReplacement(ScaleRoute(page: SignUpAsUser()))
                              }, child: Text("SignUp",style:GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white
                    ))),style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.grey[700])),)
                            ],
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                              ElevatedButton(onPressed: () => {
                                  Navigator.of(context)
                                       .pushReplacement(ScaleRoute(page: SignUpAsDoctor()))
                              }, child: Text("Doc SignUp",style:GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white
                    ))),style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.grey[700])),)
          
                          ],)
                        ],
                      ),]
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