import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/database/mapper/subject_preview_mapper.dart';

import '../../../domain/model/subject_preview/subject_preview.dart';
import '../../model/subject_preview_db.dart';

part 'subject_preview_dao.g.dart';

@riverpod
SubjectPreviewDao subjectPreviewDao(SubjectPreviewDaoRef ref) {
  return SubjectPreviewDao(ref.watch(databaseProvider));
}


@DriftAccessor(tables: [SubjectPreviewDb])
class SubjectPreviewDao extends DatabaseAccessor<AppDatabase> with _$SubjectPreviewDaoMixin {
  final SubjectPreviewMapper mapper = SubjectPreviewMapper();

  SubjectPreviewDao(AppDatabase db) : super(db);

  Future<void> upsertAll(List<SubjectPreview> items) async {
    final toInsert = items.map((e) => mapper.toDb(e));
    await batch((batch) => batch.insertAll(
        subjectPreviewDb,
        toInsert,
        mode: InsertMode.insertOrReplace
    ));
  }

  Future<void> cleanUpsert(List<SubjectPreview> items) {
    final toInsert = items.map((e) => mapper.toDb(e));
    return transaction(() async {
      await delete(subjectPreviewDb).go();
      await batch((batch) => batch.insertAll(
          subjectPreviewDb,
          toInsert,
          mode: InsertMode.insertOrReplace
      ));
    });
  }

  Future<List<SubjectPreview>> get() async {
    return (await (select(subjectPreviewDb)).get())
        .map((e) => mapper.fromDb(e)).toList();
  }

  Stream<List<SubjectPreview>> watch() {
    return (select(subjectPreviewDb)).watch()
        .map((event) => event.map((e) => mapper.fromDb(e)).toList());
  }

}