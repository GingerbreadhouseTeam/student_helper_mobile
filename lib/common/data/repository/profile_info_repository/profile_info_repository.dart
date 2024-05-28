import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/endpoints/endpoints.dart';
import 'package:student_helper/common/database/dao/profile_info_dao/profile_info_dao.dart';
import 'package:student_helper/common/network/api_client.dart';
import 'package:student_helper/common/network/impl/api_client_provider.dart';

import '../../../domain/model/profile_info/profile_info.dart';

part 'profile_info_repository.g.dart';

@riverpod
ProfileInfoRepository profileInfoRepository(ProfileInfoRepositoryRef ref) {
  return ProfileInfoRepository(ref);
}

class ProfileInfoRepository {

  final Ref _ref;

  Endpoints get _ep => _ref.read(endpointsProvider);

  ApiClient get _api => _ref.read(apiClientProvider);

  ProfileInfoDao get _dao => _ref.read(profileInfoDaoProvider);

  ProfileInfoRepository(this._ref);

  Future<void> get() async {
    final profile = await _api.get<ProfileInfo>(
        path: _ep.profile.profileInfo,
        map: (data) async {
          return ProfileInfo.fromJson(data);
        }
    );
    await _dao.cleanUpsert(profile!);
  }

  Stream<ProfileInfo> watch() async* {
    final cache = await _dao.get();
    if (cache == null) {
      await get();
    } else {
      get();
    }

    yield* _dao.watch();
  }

}
@riverpod
Future<String> getGroupCodeRepository(GetGroupCodeRepositoryRef ref, String groupId) async {
  Endpoints ep = ref.read(endpointsProvider);
  ApiClient api = ref.read(apiClientProvider);

  final response = await api.post<String>(
      path: ep.group.code,
      body: {
        "groupId": groupId
      },
      map: (data) async {
        if (data?['code'] == null) return "";
        return data?['code'];
      }
  );
  return response!;
}
