import 'package:flutter/material.dart';
import 'constants.dart' as Constants;

class SummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      // home: ListView(
      // padding: const EdgeInsets.all(150),
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
            'Current Grades:',
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
            'Tests:' + '  90',
            style: TextStyle(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
