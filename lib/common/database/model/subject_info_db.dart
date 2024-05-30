import 'package:drift/drift.dart';
import 'package:student_helper/common/database/app_database.dart';

class SubjectInfoDb extends Table {
  TextColumn get subjectId => text()();
  TextColumn get name => text()();
  TextColumn get control => text()();
  TextColumn get color => text()();
  TextColumn get seminaryTeacher => text()();
  TextColumn get lectureTeacher => text()();
  TextColumn get commentary => text()();
  TextColumn get homeworks => text().map(SubjectInfoHomeworkConverter())();

  @override
  Set<Column>? get primaryKey => {subjectId};
}