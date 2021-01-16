import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'constants.dart' as Courses;

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      home: Scaffold(
        appBar: AppBar(
          title: Text("DrawGraph Package"),
        ),
        body: Graphs(),
      ),
    );
  }
}

class Graphs extends StatefulWidget {
  @override
  _GraphsState createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> {
  List<Feature> features = [];

  _GraphsState() {
    for (var i = 0; i < Courses.courses.length; i++) {
      features.add(Feature(
        title: Courses.courses[i],
        color: Courses.color[i],
        data: Courses.data[i],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 64.0),
          child: Text(
            "Tasks Track",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        LineGraph(
          features: features,
          size: Size(500, 500),
          labelX: Courses.weeks,
          labelY: Courses.gradeIncrements,
          showDescription: true,
          graphColor: Colors.white30,
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
