import 'package:flutter/material.dart';
import 'package:tracademic_app/Overview.dart';
import 'package:tracademic_app/database/DatabaseHelper.dart';
import 'AddGradeForm.dart';

class LoginPage extends StatefulWidget {
  //create the login page state class
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final _formKey = GlobalKey<FormState>();
  final dbHelper = DatabaseHelper.instance;
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

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
                Text(
                  'Tracademic',
                  style: TextStyle(fontSize: 50, color: Colors.white),
                ),
                //Email Textfield
                Padding(
                  padding:
                      EdgeInsets.only(top: 70, bottom: 30, left: 10, right: 10),
                  child: TextFormField(
                    controller: controller1,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a valid email';
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
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                ),
                //Password textfield

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
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
