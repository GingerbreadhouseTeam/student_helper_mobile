import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/repository/subject_info_repository/subject_info_repository.dart';

import '../../model/subject_info/subject_info.dart';

part 'subject_info_controller.g.dart';

@riverpod
class SubjectInfoController extends _$SubjectInfoController {

  SubjectInfoRepository get _repository => ref.read(subjectInfoRepositoryProvider);

  @override
  Future<SubjectInfo> build(String subjectId) async {
    final stream = _repository.watchById(subjectId).asBroadcastStream();

    final sub = stream.listen((event)  {
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