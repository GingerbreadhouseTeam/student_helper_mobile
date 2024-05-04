import 'package:drift/drift.dart';

class ScheduleElementDb extends Table {
  TextColumn get id => text()();
  TextColumn get subjectName => text()();
  TextColumn get homework => text().nullable()();
  DateTimeColumn get start => dateTime()();
  DateTimeColumn get end => dateTime()();
  TextColumn get type => text()();
  IntColumn get indexNumber => integer()();
  TextColumn get color => text()();

  @override
  Set<Column>? get primaryKey => {id};
}