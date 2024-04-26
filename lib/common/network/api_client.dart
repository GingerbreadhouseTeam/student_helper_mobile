typedef Mapper<T> = Future<T> Function(dynamic response);

abstract interface class ApiClient {
  Future<T?> post<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    Mapper<T>? map,
  });

  Future<T?> get<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    Mapper<T>? map,
  });

  Future<T?> put<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    Mapper<T>? map,
  });

  Future<T?> delete<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    Mapper<T>? map,
  });

  Future<T?> patch<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    Mapper<T>? map,
  });
}
