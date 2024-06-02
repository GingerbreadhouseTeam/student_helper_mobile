import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/repository/main_item_repository/main_item_repository.dart';
import 'package:student_helper/common/data/repository/queue_repostiory/queue_repository.dart';
import 'package:student_helper/common/data/repository/topic_selection_element_repository/topic_selection_element_repository.dart';

import '../../model/main_item/main_item.dart';
import '../../model/queue_element/queue_element.dart';
import '../../model/topic_selection_element/topic_selection_element.dart';

part 'main_item_controller.g.dart';

@riverpod
class MainItemController extends _$MainItemController {
  final pageSize = 10;
  int page = 1;

  MainItemRepository get _repository => ref.read(mainItemRepositoryProvider);
  TopicSelectionElementRepository get _topRepo => ref.read(topicSelectionElementRepositoryProvider);
  QueueRepository get _queRepo => ref.read(queueRepositoryProvider);

  @override
  Future<List<MainItem>> build() async{
    page = 1;
    final stream = _repository.watch().asBroadcastStream();

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

  Future<void> createMainItemElement(MainItem item) async {
    await _repository.createMainItemElement(item);
  }

  Future<void> addTopic(Topic item) async {
    await _topRepo.addTopic(item);
  }


  Future<void> addQueue(Queue item) async {
    await _queRepo.addQueue(item);
  }

  Future<bool> nextPage() async {
    if (state is AsyncLoading) return true;
    page++;
    state = const AsyncLoading();
    try {
      await _repository.get(page: page, pageSize: pageSize);
      return true;
    } catch (error, stackTrace) {
      page--;
      state = AsyncError(error, stackTrace);
      return false;
    }
  }
}