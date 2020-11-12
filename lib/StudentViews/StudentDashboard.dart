import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
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

                return new GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  children:
                      snapshot.data.docs.map((DocumentSnapshot document) {
                    return new Container(
                      child: new Text(document.data()['Name']),
                      );
                  }).toList(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
