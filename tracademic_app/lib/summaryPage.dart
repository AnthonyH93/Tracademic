import 'package:flutter/material.dart';
import 'constants.dart' as Constants;
import 'database/DatabaseHelper.dart';

class SummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        // backgroundColor: Color.fromRGBO(54, 66, 97, 100),
        body: Padding(
          padding: EdgeInsets.fromLTRB(40, 50, 40, 0),
          child: SummaryPage(),
        ),
      ),
    );
  }
}

class SummaryWidget extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          alignment: Alignment.centerLeft,
          child: Text(
            '',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        Container(
          height: 100,
          alignment: Alignment.center,
          child: Text(
            'Current Grades',
            style: TextStyle(
                fontSize: 40,
                color: Colors.blue[900],
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 100,
          alignment: Alignment.centerLeft,
          child: Text(
            'Labs:' + '   90',
            style: TextStyle(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 100,
          alignment: Alignment.centerLeft,
          child: Text(
            'Quizzes:' + '    90',
            style: TextStyle(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 100,
          alignment: Alignment.centerLeft,
          child: Text(
            'Assignments:' + '   90',
            style: TextStyle(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 100,
          alignment: Alignment.centerLeft,
          child: Text(
            'Exams:' + '  90',
            style: TextStyle(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
