import 'package:drift/drift.dart';

class ProfileInfoDb extends Table {
  TextColumn get userId => text()();
  TextColumn get groupName => text()();
  TextColumn get groupId => text()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get role => text()();

  @override
  Set<Column>? get primaryKey => {userId};
}