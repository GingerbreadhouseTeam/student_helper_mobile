import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/database/mapper/subject_info_mapper.dart';
import 'package:student_helper/common/database/model/subject_info_db.dart';

import '../../../domain/model/subject_info/subject_info.dart';

part 'subject_info_dao.g.dart';

@riverpod
SubjectInfoDao subjectInfoDao(SubjectInfoDaoRef ref) {
  return SubjectInfoDao(ref.watch(databaseProvider));
}

@DriftAccessor(tables: [SubjectInfoDb])
class SubjectInfoDao extends DatabaseAccessor<AppDatabase> with _$SubjectInfoDaoMixin {
  final SubjectInfoMapper mapper = SubjectInfoMapper();

  SubjectInfoDao(AppDatabase db) : super(db);

  Future<void> upsert(SubjectInfo item) async {
    await into(subjectInfoDb).insert(
        mapper.toDb(item),
        mode: InsertMode.insertOrReplace
    );
  }

  Future<SubjectInfo?> getById(String id) async {
    final item = await (select(subjectInfoDb)..where((tbl) => tbl.subjectId.equals(id))).getSingleOrNull();
    if (item == null) return null;
    return mapper.fromDb(item);
  }

  Stream<SubjectInfo> watchById(String id) {
    return (select(subjectInfoDb)..where((tbl) => tbl.subjectId.equals(id)))
        .watchSingle().map((event) => mapper.fromDb(event));
  }

}