import 'package:flutter/material.dart';
import 'package:tracademic_app/forms/AddGradeForm.dart';

import '../database/DatabaseHelper.dart';
import 'GraphPage.dart';
import 'OverviewPage.dart';
import 'SummaryPage.dart';

class TabbedCourseView extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;
  final int course_index;
  final String course_name;

  TabbedCourseView(
      {Key key, @required this.course_index, @required this.course_name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(course_name);
    print(course_index);
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(54, 66, 97, 100),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Summary'),

                Tab(text: 'Graph'),
              ],
            ),
            title: Text(course_name),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: TabBarView(
            children: [
              SummaryOuterPage(
                  course_index: course_index, course_name: course_name),
              GraphPage(course_index: course_index, course_name: course_name),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              color: Color.fromRGBO(54, 66, 97, 100),
              height: 50.0,
            ),
          ),
          floatingActionButton: RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyAddGradeForm(
                            course_index: course_index,
                            course_name: course_name,
                          )));
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text("Add new grade"),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}
