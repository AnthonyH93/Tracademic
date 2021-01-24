import 'package:flutter/material.dart';
import 'package:tracademic_app/pages/CoursesPage.dart';
import 'package:tracademic_app/pages/OverviewPage.dart';
import 'database/DatabaseHelper.dart';
import 'pages/GraphPage.dart';

import 'pages/LoginPage.dart';

void main() {
  runApp(Nav2App());
}

class Nav2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(54, 66, 97, 100),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(54, 66, 97, 100),
          title: Center(
            child: Text(''),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(40, 50, 40, 0),
          child: LoginPage(),
        ),
      ),
    );
  }
}
