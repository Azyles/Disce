import 'package:Disce/auth/registerview.dart';
import 'package:Disce/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class SignInView extends StatelessWidget {
  final _formKey = new GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  signInEmail(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // ignore: unnecessary_statements
      userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              child: Image.asset("asset/images/Wallpaper.png"),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(1),
                spreadRadius: 30,
                blurRadius: 50,
                offset: Offset(0, -1), // changes position of shadow
              ),
            ], color: Colors.black),
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2,color: Colors.grey[900])
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.w700),
                                  border: InputBorder.none, hintText: 'Email'),
                              validator: (value) {
                                if (value == null || value == '') {
                                  return 'Email cannot be blank';
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
                          border: Border.all(width: 2,color: Colors.grey[900])
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.w700),
                                  border: InputBorder.none, hintText: 'Password'),
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
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Center(
                    child: Container(
                      child: new Material(
                        child: new InkWell(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              await signInEmail(_emailController.text,
                                  _passwordController.text);

                              // notify feedback model listeners
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => App()));
                            }
                          },
                          child: new Container(
                            child: Center(
                              child: Text(
                                'Login',
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
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.transparent,
                      ),
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.pink[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpView()));
        },
        backgroundColor: Colors.grey[900],
        child: Icon(Icons.swap_calls),
      ),
    );
  }
}
