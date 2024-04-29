import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:student_helper/common/database/dao/homework_preview_dao/homework_preview_dao.dart';
import 'package:student_helper/common/database/dao/main_item_dao/main_item_dao.dart';
import 'package:student_helper/common/database/dao/subject_preview_dao/subject_preview_dao.dart';
import 'package:student_helper/common/database/model/homework_preview_db.dart';
import 'package:student_helper/common/database/model/subject_preview_db.dart';

import 'model/main_item_db.dart';

part 'app_database.g.dart';

@Riverpod(keepAlive: true)
AppDatabase database(DatabaseRef ref) {
  return AppDatabase();
}

@DriftDatabase(
    tables: [
      MainItemDb,
      SubjectPreviewDb,
      HomeworkPreviewDb,
    ],
    daos: [
      MainItemDao,
      SubjectPreviewDao,
      HomeworkPreviewDao,
    ])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  final dbVersion = 3;

  @override
  int get schemaVersion => dbVersion;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from < dbVersion && to == dbVersion) {
          for (final table in allTables) {
            await m.deleteTable(table.actualTableName);
            await m.createTable(table);
          }
        }
      }
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cacheBase = (await getTemporaryDirectory()).path;

    sqlite3.tempDirectory = cacheBase;

    return NativeDatabase.createInBackground(file);
  });
}