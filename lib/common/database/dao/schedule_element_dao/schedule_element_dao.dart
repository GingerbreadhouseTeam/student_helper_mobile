import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/database/mapper/schedule_element_mapper.dart';

import '../../../domain/model/schedule_element/schedule_element.dart';
import '../../model/schedule_elememt.dart';

part 'schedule_element_dao.g.dart';

@riverpod
ScheduleElementDao scheduleElementDao(ScheduleElementDaoRef ref) {
  return ScheduleElementDao(ref.watch(databaseProvider));
}


@DriftAccessor(tables: [ScheduleElementDb])
class ScheduleElementDao extends DatabaseAccessor<AppDatabase> with _$ScheduleElementDaoMixin {
  final ScheduleElementMapper mapper = ScheduleElementMapper();

  ScheduleElementDao(AppDatabase db) : super(db);

  Future<void> upsertAll(List<ScheduleElement> items) async {
    final toInsert = items.map((e) => mapper.toDb(e));
    await batch((batch) => batch.insertAll(
        scheduleElementDb,
        toInsert,
        mode: InsertMode.insertOrReplace
    ));
  }
  
  Future<void> cleanUpsert(List<ScheduleElement> items) {
    final toInsert = items.map((e) => mapper.toDb(e));
    return transaction(() async {
      await delete(scheduleElementDb).go();
      await batch((batch) => batch.insertAll(
          scheduleElementDb,
          toInsert,
          mode: InsertMode.insertOrReplace
      ));
    });
  }
  
  Future<List<ScheduleElement>> get() async {
    return (await (select(scheduleElementDb)).get())
        .map((e) => mapper.fromDb(e)).toList();
  }

  Stream<List<ScheduleElement>> watch() {
    return (select(scheduleElementDb)).watch()
        .map((event) => event.map((e) => mapper.fromDb(e)).toList());
  }
}