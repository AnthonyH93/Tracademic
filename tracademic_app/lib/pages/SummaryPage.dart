import 'package:flutter/material.dart';
import 'package:tracademic_app/database/DatabaseHelper.dart';
import '../models/constants.dart' as Constants;

class SummaryOuterPage extends StatelessWidget {
  final int course_index;
  final String course_name;

  SummaryOuterPage(
      {Key key, @required this.course_index, @required this.course_name})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        // backgroundColor: Color.fromRGBO(54, 66, 97, 100),
        body: Padding(
          padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
          child:
              SummaryPage(course_index: course_index, course_name: course_name),
        ),
      ),
    );
  }
}

class SummaryPage extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;

  final int course_index;
  final String course_name;

  SummaryPage(
      {Key key, @required this.course_index, @required this.course_name})
      : super(key: key);

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
            'Labs:' + '   87',
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
            'Assignments:' + '   94',
            style: TextStyle(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 100,
          alignment: Alignment.centerLeft,
          child: Text(
            'Exams:' + '  76',
            style: TextStyle(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Future<bool> getAllGrades() async {
    int courseCount = await dbHelper.queryRowCountCourses();

    if (courseCount == 0) {
      //courses = [];
      return false;
    } else {
      List<Map<String, dynamic>> allCourses =
          await dbHelper.queryAllRowsCourses();
      List<String> array = [];
      List<int> array2 = [];
      allCourses.forEach((row) => array.add(row[DatabaseHelper.courseName]));
      //courses = array;
      allCourses.forEach((row) => array2.add(row[DatabaseHelper.courseGrade]));
      //grades = array2;
      return true;
    }
  }
}
