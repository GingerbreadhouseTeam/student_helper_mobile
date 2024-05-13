import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/repository/profile_info_repository/profile_info_repository.dart';

import '../../model/profile_info/profile_info.dart';

part 'profile_info_controller.g.dart';

@Riverpod(keepAlive: true)
class ProfileInfoController extends _$ProfileInfoController {

  ProfileInfoRepository get _repository => ref.read(profileInfoRepositoryProvider);

  @override
  Future<ProfileInfo> build() {
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