import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'constants.dart' as Constants;
import 'database/DatabaseHelper.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class GraphPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        // backgroundColor: Color.fromRGBO(54, 66, 97, 100),
        body: Padding(
          padding: EdgeInsets.fromLTRB(40, 50, 40, 0),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
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
