import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import '../models/constants.dart' as Constants;
import '../database/DatabaseHelper.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);
int courseIndex;
String courseName;

class GraphPage extends StatelessWidget {
  final int course_index;
  final String course_name;

  GraphPage({Key key, @required this.course_index, @required this.course_name})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    courseIndex = course_index;
    courseName = course_name;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        body: Padding(
          padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Graphs(),
        ),
      ),
    );
  }
}

class Graphs extends StatefulWidget {
  @override
  _GraphsState createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> {
  final dbHelper = DatabaseHelper.instance;

  List<Feature> features = Constants.features;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(),
        LineGraph(
          features: Constants.features,
          size: Size(600, 450),
          labelX: Constants.weeks,
          labelY: Constants.gradeIncrements,
          showDescription: true,
          graphColor: Colors.black,
        ),
        SizedBox(
          height: 100,
        )
      ],
    );
  }
}
