import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/endpoints/endpoints.dart';
import 'package:student_helper/common/database/dao/schedule_element_dao/schedule_element_dao.dart';
import 'package:student_helper/common/domain/model/schedule_element/schedule_element.dart';
import 'package:student_helper/common/network/api_client.dart';
import 'package:student_helper/common/network/impl/api_client_provider.dart';

part 'schedule_element_repository.g.dart';

@riverpod
ScheduleElementRepository scheduleElementRepository(ScheduleElementRepositoryRef ref) {
  return ScheduleElementRepository(ref);
}

class ScheduleElementRepository {
  final Ref _ref;

  ApiClient get _api => _ref.read(apiClientProvider);

  ScheduleElementDao get _dao => _ref.read(scheduleElementDaoProvider);

  Endpoints get _ep => _ref.read(endpointsProvider);

  ScheduleElementRepository(this._ref);

  Future<void> get() async {
    final items = await _api.get(
      path: _ep.group.schedule,
      map: (data) async {
        if (data?['list'] == null) return <ScheduleElement>[];
        return (data?['list'] as Iterable).map(
                (e) => ScheduleElement.fromJson(e)).toList();
      }
    );
    await _dao.cleanUpsert(items!);
  }

  Stream<List<ScheduleElement>> watch() async* {
    final items = await _dao.get();
    if (items.isEmpty) {
      await get();
    } else {
      get();
    }
    yield* _dao.watch();
  }
}