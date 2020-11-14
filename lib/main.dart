import 'dart:ui';

import 'package:Disce/StudentViews/StudentDashboard.dart';
import 'package:Disce/TeacherViews/TeacherDashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'TeacherViews/teacherNavigation.dart';
import 'auth/registerview.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Disce',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: App(),
    );
  }
}

FirebaseAuth auth = FirebaseAuth.instance;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          FirebaseAuth auth = FirebaseAuth.instance;

          if (auth.currentUser != null) {
            print("Logged In");
            return RouteView();
          } else {
            print("Logged Out");
            return SignUpView();
          }
        }

        // Otherwise, show something whilst waiting for initialization to complete
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
        //return Center(child: CircularProgressIndicator(strokeWidth: 3,backgroundColor: Colors.grey[900],));
      },
    );
  }
}

class RouteView extends StatelessWidget {
  DocumentReference users = FirebaseFirestore.instance
      .collection('UserData')
      .doc("${auth.currentUser.uid}");
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          //return Text("Full Name: ${data['full_name']} ${data['last_name']}");
          if (data['AccType'] == "Student") {
            print("Student");
            return StudentDashboard();
          } else if (data['AccType'] == "Teacher") {
            print("Teacher");
            return TeacherNavigation();
          }
        }

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
      },
    );
  }
}
