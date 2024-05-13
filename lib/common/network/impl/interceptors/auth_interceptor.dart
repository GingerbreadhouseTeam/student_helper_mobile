import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/data/repository/token_repository/token_repository.dart';
import 'package:student_helper/common/network/errors.dart';

class AuthInterceptor extends InterceptorsWrapper {
  final Ref _ref;

  TokenRepository get _tokenRepository => _ref.read(tokenRepositoryProvider);

  AuthInterceptor(this._ref);

  @override
  void onError(DioException err, handler) {
    if (err is BadRequest) {
      throw err;
    }
    if (err.response?.statusCode == 401) {
      _tokenRepository.removeTnx();
    }
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, handler) async {
    final token = await _tokenRepository.getTnx();

    options.headers.addAll(
      {
        if (token != null && token.isNotEmpty) 'tnx': token,
      }
    );
    return handler.next(options);
  }

  @override
  void onResponse(Response response, handler) {
    if (response.data.toString().contains('unauthorized')) {
      _tokenRepository.removeTnx();
    }
    handler.next(response);
  }
}