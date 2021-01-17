import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'constants.dart' as Constants;

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class GraphPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(54, 66, 97, 100),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(54, 66, 97, 100),
          title: Center(
            child: Text(''),
          ),
        ),
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
  List<Feature> features = Constants.features;

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
            "ECE 252",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        LineGraph(
          features: Constants.features,
          size: Size(500, 450),
          labelX: Constants.weeks,
          labelY: Constants.gradeIncrements,
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
