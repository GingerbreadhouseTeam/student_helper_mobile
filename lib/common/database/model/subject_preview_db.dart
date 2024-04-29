import 'package:drift/drift.dart';

class SubjectPreviewDb extends Table {
  TextColumn get id => text()();
  TextColumn get control => text()();
  TextColumn get color => text()();
  TextColumn get title => text()();

  @override
  Set<Column>? get primaryKey => {id};
}