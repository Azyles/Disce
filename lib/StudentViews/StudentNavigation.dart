import 'dart:ui';

import 'package:Disce/StudentViews/StudentDashboard.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class StudentNavigation extends StatefulWidget {
  @override
  _StudentNavigationState createState() => _StudentNavigationState();
}

class _StudentNavigationState extends State<StudentNavigation> {
  int selectedIndex = 0;

  PageController controller = PageController();

  List<StatefulWidget> screens = [StudentDashboard(),StudentDashboard(),StudentDashboard(),];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBody: true,
        body: PageView.builder(
          onPageChanged: (page) {
          },
          controller: controller,
          itemBuilder: (context, position) {
            return screens[position];
          },
          itemCount: 3, // Can be null
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
            child: Container(
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                  child: Container(
                    decoration:
                        new BoxDecoration(color: Colors.white.withOpacity(0.07)),
                    child: new Center(
                      child: SafeArea(
                        child: new Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7.0, vertical: 3),
                            child: GNav(
                                curve: Curves.easeInSine,
                                duration: Duration(milliseconds: 300),
                                tabs: [
                                  GButton(
                                    gap: 10,
                                    iconActiveColor: Colors.grey[400],
                                    iconColor: Colors.grey[600],
                                    textColor: Colors.grey[400],
                                    backgroundColor:
                                        Colors.grey.withOpacity(.1),
                                    iconSize: 24,
                                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                                    icon: Icons.data_usage,
                                    text: 'Dash',
                                  ),
                                  GButton(
                                    gap: 10,
                                   iconActiveColor: Colors.grey[400],
                                    iconColor: Colors.grey[600],
                                    textColor: Colors.grey[400],
                                    backgroundColor:
                                        Colors.grey.withOpacity(.1),
                                    iconSize: 24,
                                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                                    icon: Icons.home_outlined,
// textStyle: t.textStyle,
                                    text: 'Home',
                                  ),
                                  GButton(
                                    gap: 10,
                                    iconActiveColor: Colors.grey[400],
                                    iconColor: Colors.grey[600],
                                    textColor: Colors.grey[400],
                                    backgroundColor:
                                        Colors.grey.withOpacity(.1),
                                    iconSize: 24,
                                    icon: Icons.school,
                                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                                    
// textStyle: t.textStyle,
                                    text: 'School',
                                  ),
                                ],
                                selectedIndex: selectedIndex,
                                onTabChange: (index) {
                                  // _debouncer.run(() {

                                  print(index);
                                  setState(() {
                                    selectedIndex = index;
                                    // badge = badge + 1;
                                  });
                                  controller.jumpToPage(index);
                                  // });
                                }),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
