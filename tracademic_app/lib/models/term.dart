//Class representing a course for the database
class Course {
  final int courseIdentifier;
  final int termIdentifier;
  final String courseName;
  final int courseGrade;

  Course(
      {this.courseIdentifier,
      this.termIdentifier,
      this.courseName,
      this.courseGrade});
}
