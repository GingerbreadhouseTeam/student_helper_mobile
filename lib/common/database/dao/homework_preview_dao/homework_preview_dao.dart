import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/database/mapper/homework_preview_mapper.dart';

import '../../../domain/model/homework_preview/homework_preview.dart';
import '../../model/homework_preview_db.dart';

part 'homework_preview_dao.g.dart';

@riverpod
HomeworkPreviewDao homeworkPreviewDao(HomeworkPreviewDaoRef ref) {
  return HomeworkPreviewDao(ref.watch(databaseProvider));
}

@DriftAccessor(tables: [HomeworkPreviewDb])
class HomeworkPreviewDao extends DatabaseAccessor<AppDatabase> with _$HomeworkPreviewDaoMixin {

  final HomeworkPreviewMapper mapper = HomeworkPreviewMapper();

  HomeworkPreviewDao(AppDatabase db) : super(db);

  Future<void> upsertAll(List<HomeworkPreview> items) async {
    final toInsert = items.map((e) => mapper.toDb(e));

    await batch((batch) => batch.insertAll(
        homeworkPreviewDb,
        toInsert,
        mode: InsertMode.insertOrReplace
    ));
  }

  Future<void> cleanUpsert(List<HomeworkPreview> items) {
    final toInsert = items.map((e) => mapper.toDb(e));

    return transaction(() async {
      await delete(homeworkPreviewDb).go();
      await batch((batch) => batch.insertAll(
          homeworkPreviewDb,
          toInsert,
          mode: InsertMode.insertOrReplace,
      ));
    });
  }

  Future<List<HomeworkPreview>> get() async {
    return (await (select(homeworkPreviewDb)).get())
        .map((e) => mapper.fromDb(e)).toList();
  }

  Stream<List<HomeworkPreview>> watch() {
    return (select(homeworkPreviewDb)).watch()
        .map((event) => event.map((e) => mapper.fromDb(e)).toList());
  }

}