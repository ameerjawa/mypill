import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypill/backend/googleApi/googleSignIn.dart';

class FireAuth {
  /**
   * 
   * user global back end managment
   * 
   */
  //  sign up using firebase authintication
  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  // sign in using firebase authintcation
  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }

  // user sign out buy fireauth

  static Future<void> userSignOutAuth() async {
    return await signOut();
  }

/*
*
*  doctor backend managment
*
*
*/

// delete appointment as doctor

  static Future<void> deleteAppointmentByTitle(
      String title, String doctorName) async {
    var snapshot = await FirebaseFirestore.instance
        .collection("appoinments")
        .where('title', isEqualTo: title)
        .where("doctorName", isEqualTo: doctorName)
        .get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }

    return;
  }

//get doctor details from firebase firestore

  static Future<Map<dynamic, dynamic>> getDoctorDetails(String email) async {
    var doctorData = {};
    await FirebaseFirestore.instance
        .collection('Doctors')
        .where('doctorEmail', isEqualTo: email)
        .get()
        .then((value) => {doctorData = value.docs.first.data()});

    return doctorData;
  }

  // get users names from firebase firestore for doctor

  static Future<List<dynamic>> getAllUsersForDoctor() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Users").get();

    // Get data from docs and convert map to List
    final users = querySnapshot.docs.map((doc) => doc.data()).toList();

    return users;
  }

// get doctor Appointments from firebase firestore
  static Future<List<dynamic>> getDoctorAppointments(doctorName) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("appoinments").get();

    // Get data from docs and convert map to List
    final appointments = [];

    querySnapshot.docs.forEach((element) {
      if (element.get("doctorName") == doctorName) {
        appointments.add(element.data());
      }
    });

    return appointments;
  }

  static Future<void> uploadDataForDoctor(Map<String, dynamic> data) async {
    return await FirebaseFirestore.instance
        .collection("Doctors")
        .doc()
        .set(data);
  }

  //*****
  //
  // user backend firestore managment
  //
  // */

  static Future<void> deletePillAsUser(String docId, dynamic pills) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(docId)
        .update({"userPills": pills});
  }

  static Future<void> addAppointmentAsUser(Map<String, dynamic> data) async {
    return await FirebaseFirestore.instance
        .collection("appoinments")
        .doc()
        .set(data);
  }

  static Future<void> deleteAppointmentAsUser(
      String title, String? email) async {
    var snapshot = await FirebaseFirestore.instance
        .collection("appoinments")
        .where('title', isEqualTo: title)
        .where("userEmail", isEqualTo: email)
        .get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
    return;
  }

  static Future<List<dynamic>> getAllDoctorsForUsers() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Doctors").get();

    // Get data from docs and convert map to List
    final doctors = querySnapshot.docs.map((doc) => doc.data()).toList();
    return doctors;
  }

  static Future<void> updateUserPasswordFireStore(
      String doxId, String password) {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(doxId)
        .update({"userPassword": password});
  }

  static Future<void> updateUserNameFireStore(String docId, String username) {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(docId)
        .update({"username": username});
  }

  static Future<void> changeDoctor(String docId, String doctorName) {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(docId)
        .update({"doctorName": doctorName});
  }

  static Future<void> UpdateHeightAndWidthByUser(
      String docId, String height, String width) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(docId)
        .update({"userHeight": height, "userWeight": width});
  }

  static Future<void> ChangeIdNumber(String docId, idNumber) async {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(docId)
        .update({"idNumber": idNumber});
  }

  static Future<void> updateBirthDate(String docId, String date) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(docId)
        .update({"birthDate": date});
  }

  static Future<void> updateUserPillsList(String docId, dynamic pills) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(docId)
        .update({"userPills": pills});
  }

  static Future<dynamic> getUserDataFireStore(String? email) async {
    var userData;
    var docId = "";
    await FirebaseFirestore.instance
        .collection('Users')
        .where('userEmail', isEqualTo: email)
        .get()
        .then((value) => {
              if (value.docs.length != 0)
                {
                  userData = value.docs.first.data(),
                  docId = value.docs.first.id,
                  userData["docId"] = docId
                }
            });
    return userData;
  }

  static Future<void> UploadUserDetails(dynamic data)async{
    return await  FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc()
                                  .set(data);

  }

  static getAllPillsFromGlobalListFireBase() async {
  dynamic pills = [];
  await FirebaseFirestore.instance
      .collection("PillGlobalList")
      .get()
      .then((value) => {
            value.docs.forEach((element) {
              pills.add(element.data());
            })
          });

  return pills;
}

}
