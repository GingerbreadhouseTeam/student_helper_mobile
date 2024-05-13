import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/core/dependency_override.dart';
import 'package:student_helper/common/domain/state/navigation/navigation_controller.dart';

part 'token_repository.g.dart';

@riverpod
TokenRepository tokenRepository(TokenRepositoryRef ref) {
  return TokenRepository(ref);
}

class TokenRepository {

  final Ref _ref;

  FlutterSecureStorage get _fss => _ref.read(flutterSecureStorageProvider);

  TokenRepository(this._ref);

  Future<void> setTnx(String tnx) async {
    await _fss.write(key: "tnx", value: tnx);
    _ref.invalidate(navigationControllerProvider);
  }

  Future<void> removeTnx() async {
    await _fss.delete(key: "tnx");
    _ref.invalidate(navigationControllerProvider);
  }

   Future<String?> getTnx() async {
    return await _fss.read(key: "tnx");
  }

}