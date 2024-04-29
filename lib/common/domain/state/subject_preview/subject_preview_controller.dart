import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/repository/subject_preview_repository/subject_preview_repository.dart';
import 'package:student_helper/common/domain/model/subject_preview/subject_preview.dart';

part 'subject_preview_controller.g.dart';

@riverpod
class SubjectPreviewController extends _$SubjectPreviewController {

  SubjectPreviewRepository get _repository => ref.read(subjectPreviewRepositoryProvider);

  @override
  Future<List<SubjectPreview>> build() async {
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