import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/endpoints/endpoints.dart';
import 'package:student_helper/common/database/dao/main_item_dao/main_item_dao.dart';
import 'package:student_helper/common/domain/model/main_item/main_item.dart';
import 'package:student_helper/common/network/api_client.dart';
import 'package:student_helper/common/network/impl/api_client_provider.dart';

part 'main_item_repository.g.dart';

@riverpod
MainItemRepository mainItemRepository(MainItemRepositoryRef ref) {
  return MainItemRepository(ref);
}

class MainItemRepository {
  final Ref _ref;

  ApiClient get _api => _ref.read(apiClientProvider);

  MainItemDao get _dao => _ref.read(mainItemDaoProvider);

  Endpoints get _ep => _ref.read(endpointsProvider);

  MainItemRepository(this._ref);

  Future<void> createMainItemElement(MainItem item) async {
    await _dao.createMainItemElement(item);
  }

  Future<void> get({
    required int page,
    required int pageSize,
}) async {
    final items = await _api.post(
        path: _ep.group.main,
        body: {
          'page': page,
          'pageSize': pageSize
        },
        map: (data) async {
          if (data?['list'] == null) return <MainItem>[];
          return (data?['list'] as Iterable).map(
                  (e) => MainItem.fromJson(e)
          ).toList();
        }
    );

    if (page == 1) {
      await _dao.cleanUpsert(items!);
    } else {
      await _dao.upsertAll(items!);
    }
  }

  Stream<List<MainItem>> watch() async* {
    final items = await _dao.get();
    if (items.isEmpty) {
      await get(page: 1, pageSize: 10);
    } else {
      get(page: 1, pageSize: 10);
    }
    yield* _dao.watch();
  }
}