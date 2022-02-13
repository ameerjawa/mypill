import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypill/backend/fireBase/fire-auth.dart';
import 'package:mypill/constants/ColorsHex.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/user/patient/personalInformation/personalinformation.dart';

class EnterHeightAndWeight extends StatefulWidget {
  final userData;
  User? user;
   EnterHeightAndWeight({Key? key, this.userData,this.user}) : super(key: key);

  @override
  _EnterHeightAndWeightState createState() => _EnterHeightAndWeightState();
}

class _EnterHeightAndWeightState extends State<EnterHeightAndWeight> {
  final _formKey = GlobalKey<FormState>();
  var heightController = TextEditingController();
  var weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 23.0),
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: appBarColorBlue,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () => {
                              Navigator.of(context).pushReplacement(ScaleRoute(
                                  page: PersonalInformation(
                                userData: widget.userData,
                                user:widget.user
                              )))
                            },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                        ))
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  decoration: BoxDecoration(color: Colors.white),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          // ignore: avoid_unnecessary_containers
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () => {},
                                    icon: Icon(
                                      Icons.person,
                                      color: backgroundColorNeonGreen,
                                    )),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Height & Weight",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: backgroundColorBlueGrotto))
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: Column(children: [
                              TextFormField(
                                controller: heightController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Enter Height in CM',
                                ),
                                validator: (value) {
                                  if (value == "") {
                                    return 'Height is required';
                                  }
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: weightController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Enter Weight in Kilogram',
                                ),
                                validator: (value) {
                                  if (value == "") {
                                    return 'Weight is required';
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 100,
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              backgroundColorBlueGrotto)),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await FireAuth.UpdateHeightAndWidthByUser(
                                          widget.userData["docId"],
                                          heightController.text,
                                          weightController.text);

                                      Navigator.of(context).pushReplacement(
                                          ScaleRoute(
                                              page: PersonalInformation(
                                                user: widget.user,
                                                  userData: widget.userData)));
                                    }
                                  },
                                  child: Text(
                                    "Done",
                                    style:
                                        TextStyle(color: backgroundColorIvory),
                                  ),
                                ),
                              )
                            ]),
                          ),
                        ],
                      ),
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
