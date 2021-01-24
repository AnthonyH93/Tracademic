import 'package:flutter/material.dart';
import 'package:tracademic_app/database/DatabaseHelper.dart';
import '../models/constants.dart' as Constants;

int courseIndex;
String courseName;

class SummaryOuterPage extends StatefulWidget {
  //create the summary page state class
  final int course_index;
  final String course_name;

  SummaryOuterPage(
      {Key key, @required this.course_index, @required this.course_name})
      : super(key: key);
  @override
  _SummaryOuterPageState createState() => _SummaryOuterPageState();
}

class _SummaryOuterPageState extends State<SummaryOuterPage> {
  final dbHelper = DatabaseHelper.instance;

  var courseIdentifiers;
  var gradeWeights;
  var gradeNumbers;
  var gradeCategories;

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: getAllGrades(),
      builder: (context, snapshot) {
        if (snapshot.hasData && (courseIdentifiers.length > 0)) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                  backgroundColor: Colors.blueGrey[50],
                  // backgroundColor: Color.fromRGBO(54, 66, 97, 100),
                  body: Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            height: 20,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
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
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 100,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Quizzes:' + '    90',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 100,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Assignments:' + '   1000',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 100,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Exams:' + '  76',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ))));
        } else {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                  backgroundColor: Colors.blueGrey[50],
                  // backgroundColor: Color.fromRGBO(54, 66, 97, 100),
                  body: Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            height: 20,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
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
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 100,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Quizzes:' + '    90',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 100,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Assignments:' + '   94',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 100,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Exams:' + '  76',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ))));
        }
      });

  Future<bool> getAllGrades() async {
    int gradeCount = await dbHelper.queryRowCountGrades();

    if (gradeCount == 0) {
      courseIdentifiers = [];
      return false;
    } else {
      List<Map<String, dynamic>> allGrades =
          await dbHelper.queryAllRowsGrades();
      List<int> array = [];
      List<int> array2 = [];
      List<int> array3 = [];
      List<int> array4 = [];
      allGrades
          .forEach((row) => array.add(row[DatabaseHelper.relatedCourseId]));
      courseIdentifiers = array;
      allGrades
          .forEach((row) => array2.add(row[DatabaseHelper.numericalGrade]));
      gradeNumbers = array2;
      allGrades.forEach((row) => array3.add(row[DatabaseHelper.courseWeight]));
      gradeWeights = array3;
      allGrades.forEach((row) => array4.add(row[DatabaseHelper.gradeCategory]));
      gradeCategories = array4;
      allGrades.forEach((row) => print(row));
      return true;
    }
  }
}
