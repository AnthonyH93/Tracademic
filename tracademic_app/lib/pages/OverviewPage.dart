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
                return InkWell(
                  onTap: () async {
                    final value = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TabbedCourseView(
                                  course_index: index,
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
      int gradeCount = await dbHelper.queryRowCountGrades();
      if (gradeCount > 0) {
        getGradeInformation(courseCount);
      }

      List<Map<String, dynamic>> allCourses =
          await dbHelper.queryAllRowsCourses();
      List<String> array = [];
      allCourses.forEach((row) => array.add(row[DatabaseHelper.courseName]));
      courses = array;
      allCourses.forEach((row) => print(row));

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
        if (courseIdList[index2] == index) {
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
}
