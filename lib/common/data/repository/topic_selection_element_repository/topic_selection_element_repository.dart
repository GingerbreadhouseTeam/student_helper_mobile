import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/endpoints/endpoints.dart';
import 'package:student_helper/common/database/dao/topic_selection_element_dao/topic_selection_element_dao.dart';
import 'package:student_helper/common/network/api_client.dart';
import 'package:student_helper/common/network/impl/api_client_provider.dart';

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

  Future<void> get({
    required String id
}) async {
    final topic = await _api.post(
        path: _ep.topic.topicElement,
        body: {
          'topic_id': id
        },
        map: (data) async {
          if (data['topic'] == null) return null;
          return Topic(
            topicId: data['topic']['topic_id'],
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