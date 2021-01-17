import 'package:flutter/material.dart';

import 'database/DatabaseHelper.dart';

class AddCourseForm extends StatefulWidget {
  @override
  AddCourseFormState createState() {
    return AddCourseFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class AddCourseFormState extends State<AddCourseForm> {
  
  final _formKey = GlobalKey<FormState>();
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
              // Add TextFormFields and ElevatedButton here.
        ]
     )
    );
  }
}
