import 'package:flutter/material.dart';
import 'package:tracademic_app/AddGradeForm.dart';

import 'database/DatabaseHelper.dart';
import 'GraphPage.dart';
import 'SummaryPage.dart';

class TabBarDemo extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;
  final int course_index;
  final String course_name;

  TabBarDemo({Key key, @required this.course_index, @required this.course_name})
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
            // backgroundColor: Color.fromARGB(255, 18, 32, 47),
            // backgroundColor: Colors.blue[800],
            bottom: TabBar(
              tabs: [
                // Tab(icon: Icon(Icons.directions_car)),
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
              SummaryOuterPage(),
              GraphPage(),
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
                            course_idx: course_index,
                            course_nme: course_name,
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
