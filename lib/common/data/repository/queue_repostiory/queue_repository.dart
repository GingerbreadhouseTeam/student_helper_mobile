import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/endpoints/endpoints.dart';
import 'package:student_helper/common/database/dao/queue_dao/queue_dao.dart';
import 'package:student_helper/common/network/api_client.dart';
import 'package:student_helper/common/network/impl/api_client_provider.dart';
import 'package:student_helper/common/utils/color_types.dart';

import '../../../domain/model/queue_element/queue_element.dart';

part 'queue_repository.g.dart';

@riverpod
QueueRepository queueRepository(QueueRepositoryRef ref) {
  return QueueRepository(ref);
}

class QueueRepository {
  final Ref _ref;

  ApiClient get _api => _ref.read(apiClientProvider);

  QueueDao get _dao => _ref.read(queueDaoProvider);

  Endpoints get _ep => _ref.read(endpointsProvider);

  QueueRepository(this._ref);

  Future<void> addQueue(Queue item) async {
    await _dao.upsert(item);
  }

  Future<void> addUserToQueue({
    required String queueId,
    required String userId,
    required int index,
    required String userName
  }) async {
    await _dao.addUserToQueue(queueId: queueId, userId: userId, index: index, userName: userName);
  }

  Future<void> deleteUserFromQueue({
    required String queueId,
    required String userId,
    required int index,
    required String userName
  }) async {
    await _dao.deleteUserFromQueue(queueId: queueId, userId: userId, index: index, userName: userName);
  }

  Future<void> get({
    required String id
}) async {
    final queue = await _api.post(
        path: _ep.group.queueList,
        body: {
          'queue_id': id
        },
        map: (data) async {
          if (data['queue'] == null) return null;
          return Queue(
            queueId: data['queue']['queue_id'],
            queueType: QueueType.fromJson(data['queue']['queue_type']),
            queueColor: ItemColor.fromJson(data['queue']['queue_color']),
            queueList: (data['queue']['list'] as Iterable).map(
                    (e) => QueueElement.fromJson(e)).toList()
          );
        }
    );

    await _dao.upsert(queue!);
  }

  Stream<Queue> watch({required String id}) async* {
    final cache = await _dao.getById(id);
    if (cache == null) {
      await get(id: id);
    } else {
      get(id: id);
    }
    yield* _dao.watchById(id);
  }
}