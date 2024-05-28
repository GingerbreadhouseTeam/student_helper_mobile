import 'package:drift/drift.dart';

class GroupParticipantDb extends Table {
  TextColumn get userId => text()();
  TextColumn get role => text()();
  TextColumn get name => text()();

  @override
  Set<Column>? get primaryKey => {userId};
}