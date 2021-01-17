import 'package:flutter/material.dart';
import 'main.dart';

class TermPage extends StatefulWidget {
  @override
  _TermPageState createState() => _TermPageState();
}

class _TermPageState extends State<TermPage> {
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
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyApp()));
          },
          child: Text('Logout'),
        ),
      ),
    );
    ;
  }
}
