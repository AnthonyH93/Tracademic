import 'package:flutter/material.dart';
import 'Overview.dart';
import 'database/DatabaseHelper.dart';

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
  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  final _formKey = GlobalKey<FormState>();

  final textFieldController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
            child: TextFormField(
              controller: textFieldController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  hintText: 'Course Name',
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a course name';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
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
                  // If the form is valid, enter data into the database
                  String newCourseName = textFieldController.text;
                  insertCourse(newCourseName);

                  //Navigate back to Courses
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => OverviewPage()));
                }
              },
              child: Text('Add Course'),
            ),
          ),
        ],
      ),
    );
  }

  // Button onPressed methods
  void insertCourse(String name) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.courseName: name,
      DatabaseHelper.courseGrade: 0
    };
    final id = await dbHelper.insertCourses(row);
    print('inserted row id: $id');
  }
}
