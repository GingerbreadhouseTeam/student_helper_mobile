import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/endpoints/endpoints.dart';
import 'package:student_helper/common/database/dao/subject_preview_dao/subject_preview_dao.dart';
import 'package:student_helper/common/network/api_client.dart';
import 'package:student_helper/common/network/impl/api_client_provider.dart';

import '../../../domain/model/subject_preview/subject_preview.dart';

part 'subject_preview_repository.g.dart';

@riverpod
SubjectPreviewRepository subjectPreviewRepository(SubjectPreviewRepositoryRef ref) {
  return SubjectPreviewRepository(ref);
}

class SubjectPreviewRepository {
  final Ref _ref;

  ApiClient get _api => _ref.read(apiClientProvider);

  SubjectPreviewDao get _dao => _ref.read(subjectPreviewDaoProvider);

  Endpoints get _ep => _ref.read(endpointsProvider);

  SubjectPreviewRepository(this._ref);

  Future<void> get() async {
    final items = await _api.get(
        path: _ep.subjectPreview.subjects,
        map: (data) async {
          if (data?['list'] == null) return <SubjectPreview>[];
          return (data?['list'] as Iterable).map(
                  (e) => SubjectPreview.fromJson(e)
          ).toList();
        }
    );

    await _dao.cleanUpsert(items!);
  }

  Stream<List<SubjectPreview>> watch() async* {
    final items = await _dao.get();
    if (items.isEmpty) {
      await get();
    } else {
      get();
    }
    yield* _dao.watch();
  }

}