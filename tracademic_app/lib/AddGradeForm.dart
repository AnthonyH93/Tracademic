import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracademic_app/Overview.dart';
import 'package:tracademic_app/graphs.dart';
import 'coursePage.dart';
import 'database/DatabaseHelper.dart';

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
  var options = <String>['Quiz', 'Exam', 'Lab', 'Assignment'];
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
                  items: options.map<DropdownMenuItem<String>>((String value) {
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
                        print(options.indexOf(dropdownValue));
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
