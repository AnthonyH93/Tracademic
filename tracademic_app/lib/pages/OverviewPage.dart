import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tracademic_app/forms/AddCourseForm.dart';
import 'CoursesPage.dart';
import '../database/DatabaseHelper.dart';

class OverviewPage extends StatefulWidget {
  //create the courses page state class
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  final dbHelper = DatabaseHelper.instance;

  var courses;
  var grades;
  var courseIdentifiers;

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: getAllCourses(),
      builder: (context, snapshot) {
        if (snapshot.hasData && (courses.length > 0)) {
          double average = 0;
          if (grades.length > 0) {
            for (var gradeCount = 0; gradeCount < grades.length; gradeCount++) {
              average += grades[gradeCount];
            }
            average /= grades.length;
          }
          Widget averageSection = Container(
            height: 125,
            child: Column(children: <Widget>[
              Text("Overall Average",
                  style: TextStyle(fontSize: 24, color: Colors.white)),
              Text(average.toStringAsFixed(1) + '%',
                  style: TextStyle(fontSize: 80, color: Colors.white))
            ]),
          );
          Widget coursesSection = Container(
            child: ListView.separated(
              itemCount: courses.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(courses[index]),
                  child: InkWell(
                    onTap: () async {
                      final value = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TabbedCourseView(
                                    course_index: courseIdentifiers[index],
                                    course_name: courses[index],
                                  )));
                      setState(() {
                        getAllCourses();
                      });
                    },
                    child: ListTile(
                      title: Text('${courses[index]}',
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                      trailing: Text('${grades[index]}%',
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    final bool res = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text(
                                "Are you sure you want to delete ${courses[index]}?"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  // Delete course and associated grades from database
                                  deleteCourseFromDatabase(
                                      courseIdentifiers[index]);
                                  setState(() {
                                    courses.removeAt(index);
                                    getAllCourses();
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                    return res;
                  },
                  background: Container(color: Colors.red),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          );
          return MaterialApp(
            title: 'Courses Overview',
            home: Scaffold(
              backgroundColor: Color.fromRGBO(54, 66, 97, 100),
              appBar: AppBar(
                backgroundColor: Color.fromRGBO(54, 66, 97, 100),
                title: const Text("Courses Overview"),
              ),
              body: Column(
                children: <Widget>[
                  new Container(height: 10),
                  averageSection,
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Courses",
                          style: TextStyle(fontSize: 24, color: Colors.white))),
                  new Expanded(child: coursesSection)
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                child: Container(
                  color: Color.fromRGBO(54, 66, 97, 100),
                  height: 50.0,
                ),
              ),
              floatingActionButton: RaisedButton(
                onPressed: () => setState(() {
                  //Navigate to AddCourseForm
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddCourseForm()));
                }),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text("Add Course"),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ),
          );
        } else {
          //Wait
          return MaterialApp(
              title: 'Courses Overview',
              home: Scaffold(
                backgroundColor: Color.fromRGBO(54, 66, 97, 100),
                appBar: AppBar(
                  backgroundColor: Color.fromRGBO(54, 66, 97, 100),
                  title: const Text("Courses Overview"),
                ),
                body: Column(
                  children: <Widget>[
                    new Container(height: 10),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Courses",
                            style:
                                TextStyle(fontSize: 24, color: Colors.white))),
                  ],
                ),
                bottomNavigationBar: BottomAppBar(
                  child: Container(
                    color: Color.fromRGBO(54, 66, 97, 100),
                    height: 50.0,
                  ),
                ),
                floatingActionButton: RaisedButton(
                  onPressed: () => setState(() {
                    //Navigate to AddCourseForm
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCourseForm()));
                  }),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("Add Course"),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
              ));
        }
      });

  Future<bool> getAllCourses() async {
    int courseCount = await dbHelper.queryRowCountCourses();
    if (courseCount == 0) {
      courses = [];
      return false;
    } else {
      List<Map<String, dynamic>> allCourses =
          await dbHelper.queryAllRowsCourses();
      List<String> array = [];
      List<int> array2 = [];
      List<int> array3 = [];
      allCourses.forEach((row) {
        array.add(row[DatabaseHelper.courseName]);
        array2.add(row[DatabaseHelper.courseGrade]);
        array3.add(row[DatabaseHelper.courseIdentifier]);
        print(row);
      });
      courses = array;
      courseIdentifiers = array3;
      int gradeCount = await dbHelper.queryRowCountGrades();
      if (gradeCount > 0) {
        getGradeInformation(courseCount);
      }
      print("Grade count $gradeCount");
      if (gradeCount == 0) {
        grades = array2;
      }

      return true;
    }
  }

  void getGradeInformation(int courseCount) async {
    List<int> courseIdList = [];
    List<int> numericalGradesList = [];
    List<int> weightList = [];
    List<Map<String, dynamic>> allGrades = await dbHelper.queryAllRowsGrades();
    allGrades.forEach((row) {
      courseIdList.add(row[DatabaseHelper.relatedCourseId]);
      numericalGradesList.add(row[DatabaseHelper.numericalGrade]);
      weightList.add(row[DatabaseHelper.courseWeight]);
    });

    List<int> averages = [];
    for (var index = 0; index < courseCount; index++) {
      int gradeCounter = 0;
      int weightSummer = 0;
      for (var index2 = 0; index2 < courseIdList.length; index2++) {
        if (courseIdList[index2] == courseIdentifiers[index]) {
          gradeCounter += weightList[index2];
          weightSummer += numericalGradesList[index2] * weightList[index2];
        } else {
          //Don't count
        }
      }
      if (gradeCounter == 0) {
        averages.add(0);
      } else {
        double unroundedAverage = weightSummer / gradeCounter;
        averages.add(unroundedAverage.round());
      }
    }
    grades = averages;
  }

  void deleteCourseFromDatabase(int courseIdToDelete) async {
    print("Trying to delete course with ID $courseIdToDelete");
    final courseDeleted = await dbHelper.deleteCourses(courseIdToDelete);
    print("Deleted $courseDeleted courses");
    //Delete related grades
    final gradesDeleted = await dbHelper.deleteGrades(courseIdToDelete);
    print("Deleted $gradesDeleted grades");
  }
}
