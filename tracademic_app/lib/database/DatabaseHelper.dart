import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../models/term.dart';

class DatabaseHelper {
  static final _databaseName = "CoursesDatabase.db";
  static final _databaseVersion = 1;

  //Database tables
  static final coursesTable = 'courses_table';
  static final gradesTable = 'grades_table';

  //Courses_table columns
  static final courseIdentifier = '_id';
  static final courseName = 'courseName';
  static final courseGrade = 'courseGrade';

  //Grades_table columns
  static final gradeIdentifier = '_id';
  static final relatedCourseId = 'relatedCourseId';
  //1=quiz, 2=assignment, 3=lab, 4=exam
  static final gradeCategory = 'gradeCategory';
  static final numericalGrade = 'numericalGrade';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $coursesTable (
            $courseIdentifier INTEGER PRIMARY KEY,
            $courseName STRING NOT NULL,
            $courseGrade INTEGER
          )
          ''');
    await db.execute('''
          CREATE TABLE $gradesTable (
            $gradeIdentifier INTEGER PRIMARY KEY,
            $relatedCourseId INTEGER NOT NULL,
            $gradeCategory INTEGER NOT NULL,
            $numericalGrade INTEGER NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(coursesTable, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(coursesTable);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $coursesTable'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[courseIdentifier];
    return await db.update(coursesTable, row,
        where: '$courseIdentifier = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db
        .delete(coursesTable, where: '$courseIdentifier = ?', whereArgs: [id]);
  }
}
