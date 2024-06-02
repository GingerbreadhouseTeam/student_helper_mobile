import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/repository/topic_selection_element_repository/topic_selection_element_repository.dart';

import '../../model/topic_selection_element/topic_selection_element.dart';

part 'topic_selection_element_controller.g.dart';

@riverpod
class TopicSelectionElementController extends _$TopicSelectionElementController {

  TopicSelectionElementRepository get _repository => ref.read(topicSelectionElementRepositoryProvider);

  @override
  Future<Topic> build(String id) {
    final stream = _repository.watch(id: id).asBroadcastStream();

    final sub = stream.listen((event) {
      state = AsyncData(event);
    }, onError: (error, stackTrace) {
     state = AsyncError(error, stackTrace);
    });

    ref.onDispose(() {
      sub.cancel();
    });

    return stream.first;
  }

  Future<void> addTopicElement({
    required String topicId,
    required TopicSelectionElement toAdd
  }) async {
    await _repository.addTopicElement(topicId: topicId, toAdd: toAdd);
  }

  Future<void> changeContent({
    required String topicId,
    required String topicElementId,
    required String newContent
  }) async {
    await _repository.changeContent(topicId: topicId, topicElementId: topicElementId, newContent: newContent);
  }

  Future<void> addUser({
    required String topicId,
    required String userId,
    required String userName,
    required String topicElementId
  }) async {
    await _repository.addUser(topicId: topicId, userId: userId, userName: userName, topicElementId: topicElementId);
  }

  Future<void> removeUser({
    required String topicId,
    required String userId,
    required String topicElementId
  }) async {
    await _repository.removeUser(topicId: topicId, userId: userId, topicElementId: topicElementId);
  }


}