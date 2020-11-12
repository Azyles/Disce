import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:nanoid/async/nanoid.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class CreateClass extends StatefulWidget {
  @override
  _CreateClassState createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  Future<void> createClass(String pwd, String name) async {
    var customLengthId = await nanoid(7);
    CollectionReference classData =
        FirebaseFirestore.instance.collection('Classes');
    // Call the user's CollectionReference to add a new user
    return classData
        .doc("${customLengthId}")
        .set({
          'PasswordJoin': passwordJoin,
          'Hidden': hidden,
          'ShareData': sendAnalytics,
          'Beta': betaFeatures,
          'HideNames': hideNames,
          'classChat': classChat,
          'MaxSize': 35,
          'Type': "Base",
          'Name': name,
          'ID': customLengthId,
          'Password': pwd,
          'TeacherEmail': "${auth.currentUser.email}"
        })
        .then((value) => print("Logged failed Attempt"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  final _formKey = new GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool passwordJoin = false;
  bool hidden = false;
  bool classChat = false;
  bool hideNames = false;
  bool betaFeatures = false;
  bool sendAnalytics = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                Text(
                  "Create",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 2, color: Colors.grey[900])),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.name,
                          controller: _nameController,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700),
                              border: InputBorder.none,
                              hintText: 'Class Name'),
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'Class Name cannot be blank';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.85,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 2, color: Colors.grey[900])),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700),
                              border: InputBorder.none,
                              hintText: 'Password'),
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'Password cannot be blank';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.85,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Expanded(
              child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 2.7 / 1,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (passwordJoin == true) {
                      print("false");
                      passwordJoin = false;
                    } else {
                      print("true");
                      passwordJoin = true;
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                      child: Text(
                    'Password Join',
                    style: TextStyle(
                        color: passwordJoin ? Colors.white : Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: passwordJoin ? Colors.grey[800] : Colors.grey[900],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (hidden == true) {
                      print("false");
                      hidden = false;
                    } else {
                      print("true");
                      hidden = true;
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                      child: Text(
                    'Hidden',
                    style: TextStyle(
                        color: hidden ? Colors.white : Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: hidden ? Colors.grey[800] : Colors.grey[900],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (classChat == true) {
                      print("false");
                      classChat = false;
                    } else {
                      print("true");
                      classChat = true;
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                      child: Text(
                    'Class Chat',
                    style: TextStyle(
                        color: classChat ? Colors.white : Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: classChat ? Colors.grey[800] : Colors.grey[900],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (hideNames == true) {
                      print("false");
                      hideNames = false;
                    } else {
                      print("true");
                      hideNames = true;
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                      child: Text(
                    'Hide Names',
                    style: TextStyle(
                        color: hideNames ? Colors.white : Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: hideNames ? Colors.grey[800] : Colors.grey[900],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (sendAnalytics == true) {
                      print("false");
                      sendAnalytics = false;
                    } else {
                      print("true");
                      sendAnalytics = true;
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                      child: Text(
                    'Share Data',
                    style: TextStyle(
                        color: sendAnalytics ? Colors.white : Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: sendAnalytics ? Colors.grey[800] : Colors.grey[900],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (betaFeatures == true) {
                      print("false");
                      betaFeatures = false;
                    } else {
                      print("true");
                      betaFeatures = true;
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                      child: Text(
                    'Beta',
                    style: TextStyle(
                        color: betaFeatures ? Colors.white : Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: betaFeatures ? Colors.grey[800] : Colors.grey[900],
                  ),
                ),
              ),
            ],
          )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Center(
            child: Container(
              child: new Material(
                child: new InkWell(
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      await createClass(_passwordController.text,_nameController.text);

                      // notify feedback model listeners
                      Navigator.pop(context);
                    }
                  },
                  child: new Container(
                    child: Center(
                      child: Text(
                        'Create Class',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.025,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.transparent,
              ),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                color: Colors.pink[200],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
        ],
      ),
    );
  }
}
