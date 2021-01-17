import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/term.dart';

Future<void> insertCourse(Course course) async {
  // Get a reference to the database.
  //final Database db = await database;

  // Insert the Dog into the correct table. Also specify the
  // `conflictAlgorithm`. In this case, if the same dog is inserted
  // multiple times, it replaces the previous data.
  //await db.insert(
  //  'dogs',
  //  dog.toMap(),
  //  conflictAlgorithm: ConflictAlgorithm.replace,
  //);
}
