import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/endpoints/endpoints.dart';
import 'package:student_helper/common/database/dao/topic_selection_element_dao/topic_selection_element_dao.dart';
import 'package:student_helper/common/network/api_client.dart';
import 'package:student_helper/common/network/impl/api_client_provider.dart';
import 'package:student_helper/common/utils/color_types.dart';

import '../../../domain/model/topic_selection_element/topic_selection_element.dart';

part 'topic_selection_element_repository.g.dart';

@riverpod
TopicSelectionElementRepository topicSelectionElementRepository(TopicSelectionElementRepositoryRef ref) {
  return TopicSelectionElementRepository(ref);
}

class TopicSelectionElementRepository {
  final Ref _ref;

  ApiClient get _api => _ref.read(apiClientProvider);

  TopicSelectionElementDao get _dao => _ref.read(topicSelectionElementDaoProvider);

  Endpoints get _ep => _ref.read(endpointsProvider);

  TopicSelectionElementRepository(this._ref);

  Future<void> addTopic(Topic item) async {
    await _dao.upsert(item);
  }

  Future<void> addTopicElement({
    required String topicId,
    required TopicSelectionElement toAdd
  }) async {
    await _dao.addTopicElement(topicId: topicId, toAdd: toAdd);
  }

  Future<void> changeContent({
    required String topicId,
    required String topicElementId,
    required String newContent
  }) async {
    await _dao.changeContent(topicId: topicId, topicElementId: topicElementId, newContent: newContent);
  }

  Future<void> addUser({
    required String topicId,
    required String userId,
    required String userName,
    required String topicElementId
  }) async {
    await _dao.addUser(topicId: topicId, userId: userId, userName: userName, topicElementId: topicElementId);
  }

  Future<void> removeUser({
    required String topicId,
    required String userId,
    required String topicElementId
  }) async {
    await _dao.removeUser(
        topicId: topicId, userId: userId, topicElementId: topicElementId);
  }

  Future<void> get({
    required String id
}) async {
    final topic = await _api.post(
        path: _ep.group.topicElement,
        body: {
          'topic_id': id
        },
        map: (data) async {
          if (data['topic'] == null) return null;
          return Topic(
            topicId: data['topic']['topic_id'],
            color: ItemColor.fromJson(data['topic']['topic_color']),
            topics: (data['topic']['list'] as Iterable).map(
                    (e) => TopicSelectionElement.fromJson(e)).toList()
          );
        }
    );
    await _dao.upsert(topic!);
  }

  Stream<Topic> watch({required String id}) async* {
    final cache = await _dao.getById(id);
    if (cache == null) {
      await get(id: id);
    } else {
      get(id: id);
    }
    yield* _dao.watchById(id);
  }
}