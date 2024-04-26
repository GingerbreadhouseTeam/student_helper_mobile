import 'package:drift/drift.dart';

class MainItemDb extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()();
  TextColumn get title => text()();
  TextColumn get color => text()();

  @override
  Set<Column>? get primaryKey => {id};
}