import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracademic_app/Overview.dart';
import 'package:tracademic_app/graphs.dart';
import 'coursePage.dart';
import 'database/DatabaseHelper.dart';

/*
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
}*/

class MyAddGradeForm extends StatelessWidget {
  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

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
            child: Text('Add a new grade:'),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(40, 50, 40, 0),
          child: AddGradeForm(),
        ),
      ),
    );
  }
}

class AddGradeForm extends StatefulWidget {
  @override
  _AddGradeFormState createState() => _AddGradeFormState();
}

class _AddGradeFormState extends State<AddGradeForm> {
  final _formKey = GlobalKey<FormState>();
  final dbHelper = DatabaseHelper.instance;
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  String dropdownValue = 'Quiz';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                //Email Textfield
                Padding(
                  padding:
                      EdgeInsets.only(top: 70, bottom: 30, left: 10, right: 10),
                  child: TextFormField(
                    controller: controller1,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Grade',
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a valid grade';
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: controller2,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        hintText: 'Assesment weight',
                        hintStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a valid weight';
                      }
                      return null;
                    },
                  ),
                ),
                //Password textfield
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  focusColor: Colors.white,
                  iconDisabledColor: Colors.white,
                  dropdownColor: Colors.white,
                  style: TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['Quiz', 'Exam', 'Lab', 'Assignment']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(0, 224, 199, 100)),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.fromLTRB(80, 15, 80, 15)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        //connect to firebase and validate user
                        print(controller1.text);
                        print(controller2.text);
                        //Navigate to TermPage
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OverviewPage()));
                      }
                    },
                    child: Text(
                      'Add Grade',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
