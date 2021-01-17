import 'package:flutter/material.dart';
import 'package:tracademic_app/AddGradeForm.dart';

import 'database/DatabaseHelper.dart';
import 'graphs.dart';
import 'summaryPage.dart';

class TabBarDemo extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;

  String name;
  int index;
  TabBarDemo(this.name, this.index) {
    name = this.name;
    index = this.index;
  }
  @override
  Widget build(BuildContext context) {
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
            title: Text(name),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyAddGradeForm()));
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
