import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/database/mapper/queue_mapper.dart';
import 'package:student_helper/common/database/model/queue_db.dart';

import '../../../domain/model/queue_element/queue_element.dart';

part 'queue_dao.g.dart';

@riverpod
QueueDao queueDao(QueueDaoRef ref) {
  return QueueDao(ref.watch(databaseProvider));
}


@DriftAccessor(tables: [QueueDb])
class QueueDao extends DatabaseAccessor<AppDatabase> with _$QueueDaoMixin {
  final QueueMapper mapper = QueueMapper();

  QueueDao(AppDatabase db) : super(db);

  Future<void> upsert(Queue item) async {
    await into(queueDb).insert(
      mapper.toDb(item),
      mode: InsertMode.insertOrReplace
    );
  }

  Future<Queue?> getById(String id) async {
    final queue = await (select(queueDb)..where((tbl) => tbl.queueId.equals(id))).getSingleOrNull();
    if (queue == null) return null;
    return mapper.fromDb(queue);
  }

  Stream<Queue> watchById(String id) {
    return (select(queueDb)..where((tbl) => tbl.queueId.equals(id)))
        .watchSingle().map((event) => mapper.fromDb(event));
  }

}