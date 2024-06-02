import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/repository/queue_repostiory/queue_repository.dart';

import '../../model/queue_element/queue_element.dart';

part 'queue_controller.g.dart';

@riverpod
class QueueController extends _$QueueController {

  QueueRepository get repository => ref.read(queueRepositoryProvider);

  @override
  Future<Queue> build(String id) {

    final stream = repository.watch(id: id).asBroadcastStream();

    final sub = stream.listen((event) {
      state = AsyncData(event);
    },
    onError: (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
    );

    ref.onDispose(() {
      sub.cancel();
    });

    return stream.first;

  }

  Future<void> addUserToQueue({
    required String queueId,
    required String userId,
    required int index,
    required String userName
  }) async {
    await repository.addUserToQueue(queueId: queueId, userId: userId, index: index, userName: userName);
  }

  Future<void> deleteUserFromQueue({
    required String queueId,
    required String userId,
    required int index,
    required String userName
  }) async {
    await repository.deleteUserFromQueue(queueId: queueId, userId: userId, index: index, userName: userName);
  }


}