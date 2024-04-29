import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/repository/homework_preview_repository/homework_preview_repository.dart';
import 'package:student_helper/common/domain/model/homework_preview/homework_preview.dart';

part 'homework_preview_controller.g.dart';

@riverpod
class HomeworkPreviewController extends _$HomeworkPreviewController {

  HomeworkPreviewRepository get _repository => ref.read(homeworkPreviewRepositoryProvider);

  @override
  Future<List<HomeworkPreview>> build() async {
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

}