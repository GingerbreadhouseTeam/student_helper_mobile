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
}