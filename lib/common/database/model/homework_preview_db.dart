import 'package:drift/drift.dart';

class HomeworkPreviewDb extends Table {
  TextColumn get id => text()();
  TextColumn get subjectName => text()();
  TextColumn get homeworkText => text()();
  TextColumn get color => text()();

  @override
  Set<Column>? get primaryKey => {id};
}