// ignore: file_names
// ignore_for_file: file_names

import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/user/main_page.dart';

// ignore: camel_case_types
class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splash_Screen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context)
            .pushReplacement(ScaleRoute(page: MainPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.blueGrey[900]),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text('MyPill',
                    style: GoogleFonts.luckiestGuy(
                        textStyle: TextStyle(
                            letterSpacing: 10,
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            color: Colors.white))),
              ),
              SizedBox(height: 20),
              const SpinKitRipple(
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
