// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracademic',
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
          child: LoginPage(),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  //create the login page state class
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
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
                decoration: InputDecoration(
                  hintText: 'Username',
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
                decoration: InputDecoration(
                    hintText: 'Password',
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
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Logging in ...')));
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ));
  }
}
