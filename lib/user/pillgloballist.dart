import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypill/routes/pageRouter.dart';
import 'package:mypill/user/backend/pills.dart';
import 'package:mypill/user/guest/login_as_a_guest.dart';

class PillGlobalList extends StatefulWidget {
  final User? user;
  final userData;
  final globalList;
  final userPillsFromDb;

  const PillGlobalList(
      {Key? key, required this.user, this.userData, this.globalList,this.userPillsFromDb})
      : super(key: key);

  @override
  PillGlobalListState createState() =>
      PillGlobalListState(this.user, this.globalList);
}

class PillGlobalListState extends State<PillGlobalList> {
  final User? user;
  final globalList;

  var pills = [];

  var filteredPills = [];

  PillGlobalListState(
    this.user,
    this.globalList, {
    Key? key,
  }) : super();

  @override
  void initState() {
    filteredPills.addAll(this.globalList);
    super.initState();
  }

  void filterSearchResults(String query) {
    var dummySearchList = [];
    dummySearchList.addAll(pills);
    if (query.isNotEmpty) {
      var dummyListData = [];
      dummySearchList.forEach((item) {
        if (item["pillName"].contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredPills.clear();
        filteredPills.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        filteredPills.clear();
        filteredPills.addAll(pills);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("globalList -> is ${widget.globalList}");
    TimeOfDay selectedTime = TimeOfDay.now();
    pills = widget.globalList;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.of(context).pushReplacement(ScaleRoute(
                        page: HomePage(
                      user: this.user,
                      userData: widget.userData,
                      
                      userPillsFromDb:widget.userPillsFromDb
                    )))
                  },
              icon: Icon(Icons.arrow_back))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white70),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.blueGrey),
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.search),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (value) => {filterSearchResults(value)},
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search people & places",
                                hintStyle: TextStyle()),
                          ),
                        ),
                        Icon(
                          Icons.mic_none_sharp,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: filteredPills.map((strone) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: Colors.blueGrey, width: 1.0))),
                      child: ListTile(
                        title: Text(
                          strone["pillName"],
                          style: TextStyle(fontSize: 30),
                        ),
                        subtitle: Text(strone["description"]),
                        onTap: () async {
                          // keep from here TODO

                          TimeOfDay? date = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(hour: 10, minute: 5));

                          print("date hour -> ${date?.hour}");
                          print("date minute -> ${date?.minute}");
                          List<dynamic> userPillsList = [];
                          strone["time"] = "${date?.hour} : ${date?.minute}";

                          if (user != null) {
                            userPillsList = widget.userData["userPills"];

                            userPillsList.add(strone);
                            await FirebaseFirestore.instance
                                .collection("Users")
                                .doc(widget.userData["docId"])
                                .update({"userPills": userPillsList});
                          } else {
                            userPillsList.add(strone);
                          }

                          if (date != null) {
                            print("ameeeeeeeeeeeeeeeeeeeeer");
                            Navigator.of(context).pushReplacement(ScaleRoute(
                                page: HomePage(
                              user: user,
                              
                            
                              userData: widget.userData,
                              userPillsFromDb: userPillsList,
                            )));
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
