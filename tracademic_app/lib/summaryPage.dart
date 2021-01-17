import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ListView(
      padding: const EdgeInsets.all(150),
      children: <Widget>[
        Container(
          height: 50,
          // color: Colors.blue,
          child: Text(
            'Quizzes',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        Container(
          height: 50,
          // color: Colors.blue,
          child: Text(
            'Quizzes',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        Container(
          height: 50,
          // color: Colors.blue,
          child: Text(
            'Quizzes',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
      ],
    ));
  }
}
