import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/database/mapper/topic_selection_element_mapper.dart';

import '../../../domain/model/topic_selection_element/topic_selection_element.dart';
import '../../model/topic_selection_element_db.dart';

part 'topic_selection_element_dao.g.dart';

@riverpod
TopicSelectionElementDao topicSelectionElementDao(TopicSelectionElementDaoRef ref) {
  return TopicSelectionElementDao(ref.watch(databaseProvider));
}

@DriftAccessor(tables: [TopicSelectionElementDb])
class TopicSelectionElementDao extends DatabaseAccessor<AppDatabase> with _$TopicSelectionElementDaoMixin {
  final TopicSelectionElementMapper mapper = TopicSelectionElementMapper();

  TopicSelectionElementDao(AppDatabase db) : super(db);

  Future<void> upsert(Topic item) async {
    await into(topicSelectionElementDb).insert(
      mapper.toDb(item),
      mode: InsertMode.insertOrReplace
    );
  }

  Future<Topic?> getById(String id) async {
    final topic = await (select(topicSelectionElementDb)..where((tbl) => tbl.topicId.equals(id))).getSingleOrNull();
    if (topic == null) return null;
    return mapper.fromDb(topic);
  }

  Stream<Topic> watchById(String id) {
    return (select(topicSelectionElementDb)
      ..where((tbl) => tbl.topicId.equals(id)))
        .watchSingle().map((event) => mapper.fromDb(event));
  }


}