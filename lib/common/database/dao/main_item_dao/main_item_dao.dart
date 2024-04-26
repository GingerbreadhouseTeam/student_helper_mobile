import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/database/mapper/main_item_mapper.dart';

import '../../../domain/model/main_item/main_item.dart';
import '../../model/main_item_db.dart';

part 'main_item_dao.g.dart';

@riverpod
MainItemDao mainItemDao(MainItemDaoRef ref) {
  return MainItemDao(ref.watch(databaseProvider));
}

@DriftAccessor(tables: [MainItemDb])
class MainItemDao extends DatabaseAccessor<AppDatabase> with _$MainItemDaoMixin {
  final MainItemMapper mapper = MainItemMapper();

  MainItemDao(AppDatabase db) : super(db);

  Future<void> upsertAll(List<MainItem> items) async {
    final toInsert = items.map((e) => mapper.toDb(e));
    await batch((batch) => batch.insertAll(
        mainItemDb,
        toInsert,
        mode: InsertMode.insertOrReplace
    ));
  }

  Future<void> cleanUpsert(List<MainItem> items) {
    final toInsert = items.map((e) => mapper.toDb(e));
    return transaction(() async {
      await delete(mainItemDb).go();
      await batch((batch) {
        batch.insertAll(
            mainItemDb,
            toInsert,
            mode: InsertMode.insertOrReplace
        );
      });
    });
  }

  Future<List<MainItem>> get() async {
    return (await (select(mainItemDb)).get())
        .map((e) => mapper.fromDb(e)).toList();
  }

  Stream<List<MainItem>> watch() {
    return (select(mainItemDb)).watch()
        .map((event) => event.map((e) => mapper.fromDb(e)).toList());
  }
}