import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/repository/auth_repository/auth_repository.dart';

part 'sign_in_controller.g.dart';

@riverpod
class SignInController extends _$SignInController {

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  @override
  FutureOr<void> build() {}

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.signIn(email: email, password: password);
    });
  }

}