import 'package:drift/drift.dart';
import 'package:student_helper/common/database/app_database.dart';

class TopicSelectionElementDb extends Table {
  TextColumn get topicId => text()();
  TextColumn get topicColor => text()();

  TextColumn get topicSelectionElements => text().map(const TopicSelectionElementConverter())();

  @override
  Set<Column> get primaryKey => {topicId};
}