import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../guest/login_as_a_guest.dart';

class SpecifecPillTypes extends StatefulWidget {
  User? user;
  final userData;
  SpecifecPillTypes({Key? key, this.user,this.userData}) : super(key: key);

  @override
  _PillTypesState createState() => _PillTypesState();
}

class _PillTypesState extends State<SpecifecPillTypes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 48),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[700],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () => {
                                    Navigator.of(context)
                                        .pushReplacement(ScaleRoute(
                                            page: HomePage(
                                      user: widget.user,
                                      
                                      userData: widget.userData,
                                    )))
                                  },
                              icon: Icon(Icons.arrow_back)),
                          SizedBox(
                            width: 120,
                          ),
                          Text(
                            "Actos",
                            style: TextStyle(fontSize: 30),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      height: 300,
                      child: StaggeredGridView.countBuilder(
                          crossAxisCount: 2,
                          itemCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => {},
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.4, color: Colors.black),
                                    borderRadius:
                                        BorderRadius.circular(8 * 0.5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Actos 5 mg",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Kaushan',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 8 * 1.5),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 2,
                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey),
                                        ),
                                        SizedBox(
                                          height: 13,
                                        ),
                                        Text("first line"),
                                        Text("second Line"),
                                        Text("Third Line"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () => {},
                                                child: Text("ok"))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          staggeredTileBuilder: (index) =>
                              StaggeredTile.fit(1)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
