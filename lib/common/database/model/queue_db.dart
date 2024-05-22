import 'package:drift/drift.dart';
import 'package:student_helper/common/database/app_database.dart';

class QueueDb extends Table {
  TextColumn get queueId => text()();

  TextColumn get queueList => text().map(QueueElementsConverter())();

  @override
  Set<Column>? get primaryKey => {queueId};
}