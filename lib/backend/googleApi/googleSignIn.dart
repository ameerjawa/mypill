import 'dart:async';
import 'dart:convert' show json;

import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> signOut() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  try {
    await googleSignIn.signOut();

    await FirebaseAuth.instance.signOut();
  } catch (e) {
    print("Error is - >" + e.toString());
  }
}

Future<User?> signInWithGoogle() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;


  final GoogleSignIn googleSignIn = GoogleSignIn(
       scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );



  // the problem is here
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();




  if (googleSignInAccount != null) {
 
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    try {
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        print("Error is -> ${e.toString()}");
        // handle the error here
      } else if (e.code == 'invalid-credential') {
        // handle the error here
        print("Error is -> ${e.toString()}");
      }
    } catch (e) {
      // handle the error here
      print("Error is -> ${e.toString()}");
    }
  }

  return user;
}
