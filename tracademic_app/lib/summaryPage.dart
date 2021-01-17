import 'package:flutter/material.dart';
import 'constants.dart' as Constants;

class SummaryOuterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        // backgroundColor: Color.fromRGBO(54, 66, 97, 100),
        body: Padding(
          padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: SummaryPage(),
        ),
      ),
    );
  }
}

class SummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
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
