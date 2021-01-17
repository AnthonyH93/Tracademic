import 'package:flutter/material.dart';
import 'package:draw_graph/models/feature.dart';

//Constants for Graphs.dart
var courses = ['ECE 252', 'ECE 224', 'ECE 208'];
var color = [Colors.cyan, Colors.green, Colors.red];
List<List<double>> data = [
  [
    0.6,
    0.45,
    0.91,
    0.5,
    0.7,
    0.4,
  ],
  [
    0.9,
    0.35,
    0.6,
    0.53,
    0.7,
    0.73,
  ],
  [
    0.9,
    0.35,
    0.6,
    0.53,
    0.7,
    0.73,
  ],
];

const weeks = [
  'W0',
  'W1',
  'W2',
  'W3',
  'W4',
];

const gradeIncrements = ['20%', '40%', '60%', '80%', '100%'];

final List<Feature> features = [
  Feature(
    title: "Quizzes",
    color: Colors.blue,
    data: [0.2, 0.8, 0.4, 0.7, 0.6],
  ),
  Feature(
    title: "Assignments",
    color: Colors.pink,
    data: [1, 0.8, 0.6, 0.7, 0.3],
  ),
  Feature(
    title: "Labs",
    color: Colors.cyan,
    data: [0.5, 0.4, 0.85, 0.4, 0.7],
  ),
  Feature(
    title: "Tests",
    color: Colors.green,
    data: [0.6, 0.2, 0, 0.1, 1],
  ),
];

//Constants for Courses.dart
final List<String> courses_courses = <String>['ECE 201', 'ECE 203', 'ECE 207', 'ECE 208', 'ECE 224', 'ECE 252', 'SCI 238', 'ECE 222', 'ECE 222', 'ECE 222'];
final List<String> courses_courses_grades = <String>['67', '78', '72', '85', '91', '87', '00', '00', '00', '00'];