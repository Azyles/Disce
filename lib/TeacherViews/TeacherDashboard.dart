import 'dart:ui';

import 'package:Disce/TeacherViews/CreateClassView.dart';
import 'package:Disce/TeacherViews/classView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class TeacherDashboard extends StatefulWidget {
  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  CollectionReference classes = FirebaseFirestore.instance
      .collection('UserData')
      .doc("${auth.currentUser.uid}")
      .collection("Classes");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.11,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              "Dashboard",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: classes.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Material(
                      color: Colors.black,
                      child: Center(
                          child: Text(
                        "Something went wrong",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 40,
                            fontWeight: FontWeight.w300),
                      )));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Material(
                      color: Colors.black,
                      child: Center(
                          child: Text(
                        "Disce",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 40,
                            fontWeight: FontWeight.w300),
                      )));
                }
                if (snapshot.data.size == 0) {
                  return GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return CreateClass();
                            }),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[900],
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Center(
                              child: Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.grey[400],
                          )),
                        ),
                      ),
                    ],
                  );
                } else {
                  return new GridView(
                    padding: EdgeInsets.all(20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return ClassView(
                                document.data()['ID'],
                                document.data()['Name'],
                              );
                            }),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[900],
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://source.unsplash.com/featured/?${[
                                    document.data()['Name']
                                  ]}'),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.matrix(<double>[
                                    0.2126,
                                    0.7152,
                                    0.0722,
                                    0,
                                    0,
                                    0.2126,
                                    0.7152,
                                    0.0722,
                                    0,
                                    0,
                                    0.2126,
                                    0.7152,
                                    0.0722,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    1,
                                    0,
                                  ]))
                              //border: Border.all(width: 4, color: Colors.grey[900])
                              ),
                          child: Center(
                              child: new Text(
                            document.data()['Name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          )),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[900],
          child: Center(
              child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          )),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return CreateClass();
              }),
            );
          }),
    );
  }
}
