part of 'api_client_provider.dart';

class _DioClientImpl implements ApiClient {
  final Ref _ref;

  late final _dio = Dio(BaseOptions(baseUrl: "htts://api.gingerb.sthelp/"))
    ..interceptors.addAll([
      MockInterceptor(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
      MapInterceptor(),
    ]);

  _DioClientImpl(this._ref);

  @override
  Future<T?> delete<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    Mapper<T>? map,
  }) async {
    final result = await _dio.delete(path, queryParameters: queryParams);
    return map?.call(result.data);
  }

  @override
  Future<T?> get<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    Mapper<T>? map,
  }) async {
    final result = await _dio.get(path, queryParameters: queryParams);
    return map?.call(result.data);
  }

  @override
  Future<T?> patch<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    Mapper<T>? map,
  }) async {
    final result = await _dio.patch(path, queryParameters: queryParams, data: body);
    return map?.call(result.data);
  }

  @override
  Future<T?> post<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    Mapper<T>? map,
  }) async {
    final result = await _dio.post(path, queryParameters: queryParams, data: body);
    return map?.call(result.data);
  }

  @override
  Future<T?> put<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    Mapper<T>? map
  }) async {
    final result = await _dio.put(path, queryParameters: queryParams, data: body);
    return map?.call(result.data);
  }
}
