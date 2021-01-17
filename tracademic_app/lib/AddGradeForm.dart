import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'coursePage.dart';
import 'database/DatabaseHelper.dart';

class AddGradeForm extends StatelessWidget {
  @override
  String name;
  int index;
  AddGradeForm(this.name, this.index){
    name = this.name;
    index = this.index;
  }
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
        body: AddGradeFormWidget(name, index),
      ),
    );
  }
}

// Create a Form widget.
class AddGradeFormWidget extends StatefulWidget {
  @override
  String name;
  int index;
  AddGradeFormWidget(this.name, this.index){
    name = this.name;
    index = this.index;
  }
  AddGradeFormState createState() {
    return AddGradeFormState(name, index);
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class AddGradeFormState extends State<AddGradeFormWidget> {

  final _formKey = GlobalKey<FormState>();

  final gradeTextFieldController = TextEditingController();

  final weightTextFieldController = TextEditingController();

  String name;
  int index;
  AddGradeFormState(this.name, this.index){
    name = this.name;
    index = this.index;
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    gradeTextFieldController.dispose();
    weightTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Grade"),
            trailing: TextFormField(
              controller: gradeTextFieldController,
              style: TextStyle(color: Colors.black),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a grade';
                }
                return null;
              },
            ),
          ),
          ListTile(
            title: Text("Weight"),
            trailing: TextFormField(
              controller: weightTextFieldController,
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a weight';
                }
                return null;
              },
            ),
          ),
          ElevatedButton(
            onPressed:() {
              if(_formKey.currentState.validate()) {
                int grade = int.parse(gradeTextFieldController.text);
                int weight = int.parse(weightTextFieldController.text);
                Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => TabBarDemo(name, index)));
              }
            },
            child: Text('Add Grade'),
          )
        ]
      )
    );
  }
  // Button onPressed methods

  void insertCourse(String name) async {

  }
}