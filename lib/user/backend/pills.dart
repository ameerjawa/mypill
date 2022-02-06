import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

getAllPillsFromGlobalListFireBase() async {
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
