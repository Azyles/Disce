import 'dart:ui';

import 'package:Disce/TeacherViews/classViewHome.dart';
import 'package:Disce/TeacherViews/studentsView.dart';
import 'package:flutter/material.dart';

class ClassView extends StatefulWidget {
  final String classID;
  final String className;
  ClassView(this.classID, this.className, {Key, key}) : super(key: key);
  @override
  _ClassViewState createState() => _ClassViewState();
}

class _ClassViewState extends State<ClassView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://source.unsplash.com/featured/?${[
                      widget.className
                    ]}'),
                    fit: BoxFit.cover,
                  )),
              height: 50,
              width: 50,
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(100.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 3,
                  ),
                  Text(widget.className,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500, fontSize: 19),),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    widget.classID,
                    style: TextStyle(color: Colors.grey[700], fontSize: 15),
                  ),
                  TabBar(
                    indicatorColor: Colors.deepOrange[300],
                    indicatorWeight: 2,
                    labelStyle: TextStyle(fontWeight: FontWeight.w700),
                    labelColor: Colors.white,
                    unselectedLabelStyle: TextStyle(color: Colors.grey),
                    tabs: [
                      Tab(text: "Home"),
                      Tab(text: "Students"),
                      Tab(text: "Announcement"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              ClassViewHome(),
              StudentsView(),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
    );
  }
}
