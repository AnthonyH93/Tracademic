import 'package:flutter/material.dart';
import 'package:tracademic_app/AddCourseForm.dart';
import 'coursePage.dart';
import 'constants.dart' as Constants;

class OverviewPage extends StatefulWidget {
  //create the courses page state class
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    num average = 0;
    for (var i = 0; i < Constants.courses_courses_grades.length; i++) {
      average += Constants.courses_courses_grades[i];
    }
    average /= Constants.courses_courses_grades.length;
    int rounded_average = average.toInt();
    Widget averageSection = Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(children: <Widget>[
        Text("Overall Average",
            style: TextStyle(fontSize: 24, color: Colors.white)),

        Text(rounded_average.toString(), style: TextStyle(fontSize: 80, color: Colors.white))
      ]),
    );
    Widget coursesSection = Container(
      child: ListView.separated(
        itemCount: Constants.courses_courses.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TabBarDemo(Constants.courses_courses[index], index)));
            },
            child: ListTile(
              title: Text('${Constants.courses_courses[index]}', style: TextStyle(fontSize: 24, color: Colors.white)),
              trailing: Text('${Constants.courses_courses_grades[index]}', style: TextStyle(fontSize: 24, color: Colors.white)),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
    return MaterialApp(
      title: 'Courses Overview',
      home: Scaffold(
        backgroundColor: Color.fromRGBO(54, 66, 97, 100),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(54, 66, 97, 100),
          title : const Text("Courses Overview"),
        ),
        body: Column(
          children: <Widget>[
            new Container(height: 10),
            averageSection,
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child:Text("Courses", style: TextStyle(fontSize: 24, color: Colors.white))
            ),
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
            print("Button pressed");
            //Navigate to AddCourseForm
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddCourseForm()));
          }),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Text("Add Course"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
