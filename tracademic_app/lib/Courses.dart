import 'package:flutter/material.dart';

class CoursesPage extends StatefulWidget {
  //create the courses page state class
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  final List<String> courses = <String>['ECE 201', 'ECE 203', 'ECE 207', 'ECE 208', 'ECE 224', 'ECE 252', 'SCI 238', 'ECE 222', 'ECE 222', 'ECE 222'];
  final List<String> courses_grades = <String>['67', '78', '72', '85', '91', '87', '00', '00', '00', '00'];
  Widget build(BuildContext context) {
    Widget averageSection = Container(
      height: 215,
      child: Column(
        children: <Widget>[
          Text("Overall Average", style: TextStyle(fontSize: 24, color: Colors.white)),
          Text("75", style: TextStyle(fontSize: 80))
        ]
      ),
    );
    Widget coursesSection = Container(
      child: ListView.separated(
        itemCount: courses.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              print('${courses[index]}');
            },
            child: ListTile(
              title: Text('${courses[index]}'),
              trailing: Text('${courses_grades[index]}'),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
    return new Scaffold(
      body: Column(
        children: <Widget>[
          averageSection,
          Text("Courses", style: TextStyle(fontSize: 24, color: Colors.white)),
          new Expanded(child: coursesSection)
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: RaisedButton(
        onPressed: () => setState(() {
          print("Button pressed");
        }),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text("Add Course"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}