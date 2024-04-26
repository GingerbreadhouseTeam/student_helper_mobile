import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/repository/main_item_repository/main_item_repository.dart';

import '../../model/main_item/main_item.dart';

part 'main_item_controller.g.dart';

@riverpod
class MainItemController extends _$MainItemController {
  final pageSize = 10;
  int page = 1;

  MainItemRepository get _repository => ref.read(mainItemRepositoryProvider);

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