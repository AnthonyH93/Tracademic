import 'package:flutter/material.dart';

class AddCourseForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Add Course';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(54, 66, 97, 100),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(54, 66, 97, 100),
          title: Text(appTitle),
        ),
        body: AddCourseFormWidget(),
      ),
    );
  }
}

// Create a Form widget.
class AddCourseFormWidget extends StatefulWidget {
  @override
  AddCourseFormState createState() {
    return AddCourseFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class AddCourseFormState extends State<AddCourseFormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
            child: TextFormField(
              style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Course Name',
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20))
                  ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some a course name';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(50),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(0, 224, 199, 100)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.fromLTRB(80, 15, 80, 15)),
              ),
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is enter data into the database
                }
              },
              child: Text('Add Course'),
            ),
          ),
        ],
      ),
    );
  }
}
