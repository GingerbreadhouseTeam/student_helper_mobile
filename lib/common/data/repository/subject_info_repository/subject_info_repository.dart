import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/endpoints/endpoints.dart';
import 'package:student_helper/common/database/dao/subject_info_dao/subject_info_dao.dart';
import 'package:student_helper/common/network/api_client.dart';
import 'package:student_helper/common/network/impl/api_client_provider.dart';

import '../../../domain/model/subject_info/subject_info.dart';

part 'subject_info_repository.g.dart';

@riverpod
SubjectInfoRepository subjectInfoRepository(SubjectInfoRepositoryRef ref) {
  return SubjectInfoRepository(ref);
}

class SubjectInfoRepository {
  final Ref _ref;

  Endpoints get _ep => _ref.read(endpointsProvider);

  ApiClient get _api => _ref.read(apiClientProvider);

  SubjectInfoDao get _dao => _ref.read(subjectInfoDaoProvider);

  SubjectInfoRepository(this._ref);

  Future<void> getById(String subjectId) async {
    final subjectInfo = await _api.post<SubjectInfo>(
        path: _ep.group.subjectInfo,
        body: {
          "subject_id": subjectId
        },
        map: (data) async {
          return SubjectInfo.fromJson(data);
        }
    );
    await _dao.upsert(subjectInfo!);
  }

  Stream<SubjectInfo> watchById(String subjectId) async* {
    final cache = await _dao.getById(subjectId);
    if (cache == null) {
      await getById(subjectId);
    } else {
      getById(subjectId);
    }
    yield* _dao.watchById(subjectId);
  }
}