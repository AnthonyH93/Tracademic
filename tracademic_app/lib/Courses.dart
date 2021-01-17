import 'package:flutter/material.dart';
import 'constants.dart' as Constants;

class CoursesPage extends StatefulWidget {
  //create the courses page state class
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    num average = 0;
    for(var i = 0; i < Constants.courses_courses_grades.length; i++){
      average += Constants.courses_courses_grades[i];
    }
    average /= Constants.courses_courses_grades.length;
    int rounded_average = average.toInt();
    Widget averageSection = Container(
      height: 215,
      child: Column(
        children: <Widget>[
          Text("Overall Average", style: TextStyle(fontSize: 24, color: Colors.white)),
          Text(rounded_average.toString(), style: TextStyle(fontSize: 80))
        ]
      ),
    );
    Widget coursesSection = Container(
      child: ListView.separated(
        itemCount: Constants.courses_courses.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              print('${Constants.courses_courses[index]}');
            },
            child: ListTile(
              title: Text('${Constants.courses_courses[index]}'),
              trailing: Text('${Constants.courses_courses_grades[index]}'),
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