import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/endpoints/endpoints.dart';
import 'package:student_helper/common/database/dao/homework_preview_dao/homework_preview_dao.dart';
import 'package:student_helper/common/network/api_client.dart';
import 'package:student_helper/common/network/impl/api_client_provider.dart';

import '../../../domain/model/homework_preview/homework_preview.dart';

part 'homework_preview_repository.g.dart';

@riverpod
HomeworkPreviewRepository homeworkPreviewRepository(HomeworkPreviewRepositoryRef ref) {
  return HomeworkPreviewRepository(ref);
}

class HomeworkPreviewRepository {
  final Ref _ref;

  ApiClient get _api => _ref.read(apiClientProvider);

  HomeworkPreviewDao get _dao => _ref.read(homeworkPreviewDaoProvider);

  Endpoints get _ep => _ref.read(endpointsProvider);

  HomeworkPreviewRepository(this._ref);

  Future<void> get() async {
    final items = await _api.get(
        path: _ep.homeworkPreview.homeworks,
        map: (data) async {
          if (data?['list'] == null) return <HomeworkPreview>[];
          return (data?['list'] as Iterable).map(
                  (e) => HomeworkPreview.fromJson(e)
          ).toList();
        }
    );

    await _dao.cleanUpsert(items!);
  }

  Stream<List<HomeworkPreview>> watch() async* {
    final items = await _dao.get();
    if (items.isEmpty) {
      await get();
    } else {
      get();
    }
    yield* _dao.watch();
  }

}