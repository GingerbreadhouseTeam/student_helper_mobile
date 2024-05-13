import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/database/mapper/profile_info_mapper.dart';
import 'package:student_helper/common/domain/model/profile_info/profile_info.dart';

import '../../model/profile_info_db.dart';

part 'profile_info_dao.g.dart';

@riverpod
ProfileInfoDao profileInfoDao(ProfileInfoDaoRef ref) {
  return ProfileInfoDao(ref.watch(databaseProvider));
}

@DriftAccessor(tables: [ProfileInfoDb])
class ProfileInfoDao extends DatabaseAccessor<AppDatabase> with _$ProfileInfoDaoMixin {
  final ProfileInfoMapper mapper = ProfileInfoMapper();

  ProfileInfoDao(AppDatabase db) : super(db);

  Future<void> cleanUpsert(ProfileInfo item) {
    return transaction(() async {
      await delete(profileInfoDb).go();
      await into(profileInfoDb).insert(
        mapper.toDb(item),
        mode: InsertMode.insertOrReplace
      );
    });
  }

  Future<ProfileInfo?> get() async {
    final item = await (select(profileInfoDb)).getSingleOrNull();
    if (item == null) return null;
    return mapper.fromDb(item);
  }

  Stream<ProfileInfo> watch() {
    return (select(profileInfoDb).watchSingle().map((event) => mapper.fromDb(event)));
  }

}