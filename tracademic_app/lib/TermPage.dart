import 'package:flutter/material.dart';
import 'coursePage.dart';
import 'database/DatabaseHelper.dart';

class TermPage extends StatefulWidget {
  @override
  _TermPageState createState() => _TermPageState();
}

class _TermPageState extends State<TermPage> {

  final dbHelper = DatabaseHelper.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Term Page"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => TabBarDemo('ECE 252')));
          },
          child: Text('Logout'),
        ),
      ),
    );
    ;
  }
}
