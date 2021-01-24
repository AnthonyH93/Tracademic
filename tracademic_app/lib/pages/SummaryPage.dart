import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tracademic_app/database/DatabaseHelper.dart';
import '../models/constants.dart' as Constants;

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
          double screenHeight = MediaQuery.of(context).size.height;
          screenHeight -= 100;

          int courseIndex = widget.course_index;
          String courseName = widget.course_name;

          //Need to calculate the average marks
          int quizAverage = 0;
          int examAverage = 0;
          int labAverage = 0;
          int assignmentAverage = 0;
          int quizCounter = 1;
          int examCounter = 1;
          int labCounter = 1;
          int assignmentCounter = 1;
          int overallAverage = 0;
          for (var counter = 0; counter < courseIdentifiers.length; counter++) {
            if (courseIdentifiers[counter] != courseIndex) {
              //Skip grade
            } else {
              switch (gradeCategories[counter]) {
                case 0:
                  quizCounter += gradeWeights[counter];
                  quizAverage += gradeNumbers[counter] * gradeWeights[counter];
                  break;
                case 1:
                  examCounter += gradeWeights[counter];
                  examAverage += gradeNumbers[counter] * gradeWeights[counter];
                  break;
                case 2:
                  labCounter += gradeWeights[counter];
                  labAverage += gradeNumbers[counter] * gradeWeights[counter];
                  break;
                case 3:
                  assignmentCounter += gradeWeights[counter];
                  assignmentAverage +=
                      gradeNumbers[counter] * gradeWeights[counter];
                  break;
                default:
                  break;
              }

              //Add to overall average in any case
              overallAverage += gradeNumbers[counter] * gradeWeights[counter];
            }
          }
          //Ready to calculate averages
          quizCounter -= 1;
          examCounter -= 1;
          labCounter -= 1;
          assignmentCounter -= 1;

          double overallAverageFinal = overallAverage /
              (quizCounter + examCounter + labCounter + assignmentCounter);

          //Update overall average in database
          updateCourseGrade(
              courseIndex, overallAverageFinal.round(), courseName);

          double quizAverageFinal = quizAverage / quizCounter;
          double examAverageFinal = examAverage / examCounter;
          double labAverageFinal = labAverage / labCounter;
          double assignmentAverageFinal = assignmentAverage / assignmentCounter;

          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                  backgroundColor: Colors.blueGrey[50],
                  body: Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            height: screenHeight / 10,
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
                            height: screenHeight / 10,
                            alignment: Alignment.centerLeft,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Exams',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    examAverageFinal.toStringAsFixed(1) + '%',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                          Container(
                            height: screenHeight / 10,
                            alignment: Alignment.centerLeft,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Quizzes',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    quizAverageFinal.toStringAsFixed(1) + '%',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                          Container(
                            height: screenHeight / 10,
                            alignment: Alignment.centerLeft,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Assignments',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    assignmentAverageFinal.toStringAsFixed(1) +
                                        '%',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                          Container(
                            height: screenHeight / 10,
                            alignment: Alignment.centerLeft,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Labs',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    labAverageFinal.toStringAsFixed(1) + '%',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                          Container(
                            height: screenHeight / 10,
                            alignment: Alignment.centerLeft,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Overall Average',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    overallAverageFinal.toStringAsFixed(1) +
                                        '%',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                        ],
                      ))));
        } else {
          double screenHeight = MediaQuery.of(context).size.height;
          screenHeight -= 100;
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                  backgroundColor: Colors.blueGrey[50],
                  body: Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            height: screenHeight / 10,
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
                            height: screenHeight / 10,
                            alignment: Alignment.centerLeft,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Exams',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '0%',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                          Container(
                            height: screenHeight / 10,
                            alignment: Alignment.centerLeft,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Quizzes',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '0%',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                          Container(
                            height: screenHeight / 10,
                            alignment: Alignment.centerLeft,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Assignments',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '0%',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                          Container(
                            height: screenHeight / 10,
                            alignment: Alignment.centerLeft,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Labs',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '0%',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                          Container(
                            height: screenHeight / 10,
                            alignment: Alignment.centerLeft,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Overall Average',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '0%',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
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

  void updateCourseGrade(
      int courseIdToUpdate, int newGrade, String courseName) async {
    Map<String, dynamic> row = {
      DatabaseHelper.courseIdentifier: courseIdToUpdate,
      DatabaseHelper.courseName: courseName,
      DatabaseHelper.courseGrade: newGrade
    };
    final result = await dbHelper.updateCourses(row);
    print('Updated row $result');
  }
}
