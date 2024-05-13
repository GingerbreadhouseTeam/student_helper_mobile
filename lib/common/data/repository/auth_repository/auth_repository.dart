import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/endpoints/endpoints.dart';
import 'package:student_helper/common/data/repository/token_repository/token_repository.dart';
import 'package:student_helper/common/domain/model/auth_token/auth_token.dart';
import 'package:student_helper/common/network/api_client.dart';
import 'package:student_helper/common/network/impl/api_client_provider.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(ref);
}

class AuthRepository {

  final Ref _ref;

  Endpoints get _ep => _ref.read(endpointsProvider);

  ApiClient get _api => _ref.read(apiClientProvider);

  TokenRepository get _tokenRepository => _ref.read(tokenRepositoryProvider);

  AuthRepository(this._ref);

  Future<void> signIn({required String email, required String password}) async {
    final resp = await _api.post<AuthToken>(
        path: _ep.auth.signIn,
        body: {
          "email": email,
          "password": password
        },
        map: (data) async {
          return AuthToken.fromJson(data);
        }
    );
    await _tokenRepository.setTnx(resp!.tnx);
  }

  Future<void> logout() async {
    await _tokenRepository.removeTnx();
  }

}