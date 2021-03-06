import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mypill/constants/ColorsHex.dart';
import 'package:mypill/constants/showAlertDialog.dart';
import 'package:mypill/backend/fireBase/fire-auth.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/backend/googleApi/googleSignIn.dart';
import 'package:mypill/user/patient/personalInformation/changepassworduser.dart';
import 'package:mypill/user/guest/login_as_a_guest.dart';
import 'package:mypill/user/main_page.dart';
import 'package:mypill/user/patient/personalInformation/personalinformation.dart';
import 'package:share/share.dart';

class UserProfile extends StatefulWidget {
  User? user;
  final userData;
  UserProfile({Key? key, this.user, this.userData}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0),
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
                                page: HomePage(
                              user: widget.user,
                              userData: widget.userData,
                            )))
                          },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color:  backgroundColorIvory,
                      ))
                ],
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2.5, color:backgroundColorIvory),
                          borderRadius: BorderRadius.circular(50)),
                      child: GestureDetector(
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(widget
                                      .userData?["userPhoto"] !=
                                  null
                              ? widget.userData["userPhoto"]
                              : "https://image.shutterstock.com/image-photo/young-hispanic-latino-businessman-walking-600w-1152383948.jpg"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "${widget.userData?["username"] != null ? widget.userData["username"] : 'Guest'}",
                      style: TextStyle(fontSize: 30,color: backgroundColorIvory),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [Text("Privacy & Security")],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () => {
                            if (widget.user != null)
                              {
                                Navigator.of(context)
                                    .pushReplacement(ScaleRoute(
                                        page: ChangePasswordUser(
                                  user: widget.user,
                                  userData: widget.userData,
                                )))
                              }
                            else
                              {
                                showAlertDialog(
                                    context, "Access Denied for Guest")
                              }
                          },
                          child: Container(
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () => {},
                                    icon: Icon(Icons.change_circle_rounded,color: backgroundColorNeonGreen,)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Change Password",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => {
                            if (widget.user != null)
                              {
                                Navigator.of(context)
                                    .pushReplacement(ScaleRoute(
                                        page: PersonalInformation(
                                  user: widget.user,
                                  userData: widget.userData,
                                )))
                              }
                            else
                              {
                                showAlertDialog(
                                    context, "Access Denied for Guest")
                              }
                          },
                          child: Container(
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () => {},
                                    icon: Icon(Icons.person_pin_outlined,color: backgroundColorNeonGreen)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Personal Information",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [Text("More")],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () => {},
                          child: Container(
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () => {},
                                    icon: Icon(Icons.bluetooth,color: backgroundColorNeonGreen)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("BlueTooth",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => {},
                          child: Container(
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () => {},
                                    icon: Icon(Icons.data_saver_off,color: backgroundColorNeonGreen)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Data Usage",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await _onShareWithEmptyOrigin(
                                context, widget.userData);
                          },
                          child: Container(
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () => {},
                                    icon: Icon(Icons.share,color: backgroundColorNeonGreen)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Share",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(backgroundColorBlueGrotto)),
                              onPressed: () async {
                                await FireAuth.userSignOutAuth();

                                Navigator.of(context).pushReplacement(
                                    ScaleRoute(page: MainPage()));
                              },
                              child: Text("logout",style: TextStyle(color: backgroundColorIvory),),
                            ),
                          ),
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
    );
  }

  _onShareWithEmptyOrigin(BuildContext context, userData) async {
    await Share.share(userData.toString());
  }
}
