import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/database/mapper/group_participant_mapper.dart';
import 'package:student_helper/common/database/model/group_participant_db.dart';

import '../../../domain/model/group_participant/group_participant.dart';

part 'group_participant_dao.g.dart';

@riverpod
GroupParticipantDao groupParticipantDao(GroupParticipantDaoRef ref) {
  return GroupParticipantDao(ref.watch(databaseProvider));
}

@DriftAccessor(tables: [GroupParticipantDb])
class GroupParticipantDao extends DatabaseAccessor<AppDatabase> with _$GroupParticipantDaoMixin {
  final GroupParticipantMapper mapper = GroupParticipantMapper();

  GroupParticipantDao(AppDatabase db) : super(db);

  Future<void> cleanUpsert(List<GroupParticipant> items) {
    final toInsert = items.map((e) => mapper.toDb(e));
    return transaction(() async {
      await delete(groupParticipantDb).go();
      await batch((batch) {
        batch.insertAll(
            groupParticipantDb,
            toInsert,
            mode: InsertMode.insertOrReplace
        );
      });
    });
  }

  Future<List<GroupParticipant>> get() async {
    return (await (select(groupParticipantDb)).get())
        .map((e) => mapper.fromDb(e)).toList();
  }

  Stream<List<GroupParticipant>> watch() {
    return (select(groupParticipantDb)).watch()
        .map((event) => event.map((e) => mapper.fromDb(e)).toList());
  }

}