import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:student_helper/common/network/impl/interceptors/map_interceptor.dart';

import '../../../data/endpoints/endpoints.dart';

class MockInterceptor extends Interceptor {
  late Future _futureManifestLoaded;
  final List<Future> _futuresBundleLoaded = [];
  final Map<String, Map<String, dynamic>> _routes = {};

  final ep = Endpoints();

  late final excludes = [];

  MockInterceptor() {
    _futureManifestLoaded = rootBundle.loadString("AssetManifest.json")
        .then((content) {
          Map<String, dynamic> manifestMap = json.decode(content);

          List<String> mockResoursePaths = manifestMap.keys
            .where((String key) => key.contains('mock/') && key.endsWith('.json'))
            .toList();

          if (mockResoursePaths.isEmpty) {
            return;
          }

          for (var path in mockResoursePaths) {
            Future bundleLoaded = rootBundle.load(path).then((ByteData data) {
              String routeModule = utf8.decode(
                data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
              );
              json.decode(routeModule).forEach((dynamic map) {
                Map<String, dynamic> route = map as Map<String, dynamic>;
                String path = route['path'] as String;
                _routes.putIfAbsent(path, () => route);
              });
            });
            _futuresBundleLoaded.add(bundleLoaded);
          }
    });
  }

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
  ) async {
    if (excludes.contains(options.path)) {
      return handler.next(options);
    }

    await _futureManifestLoaded;
    await Future.wait(_futuresBundleLoaded);

    Map<String, dynamic>? route = _routes[options.path];

    if (route == null) {
      handler.reject(DioException(
          requestOptions: options,
          error: 'Путь не обнаружен: ${options.path}'
      ));
      return;
    }

    String method = route['method'] as String;
    if (options.method != method) {
      handler.reject(DioException(
          requestOptions: options,
          error: "Путь не обнаружен: ${options.path}:${options.method}"
      ));
      return;
    }

    int statusCode = route['statusCode'] as int;

    Map<String, dynamic>? template = route['template'];
    Map<String, dynamic>? data = route['data'];

    if (template == null && data == null) {
      handler.resolve(Response(
          requestOptions: options,
          statusCode: statusCode,
      ));
      return;
    }

    Map<String, dynamic>? vars = route['vars'];
    var exContext = vars ?? {};

    exContext.putIfAbsent('req', () => {
      'headers': options.headers,
      'queryParameters': options.queryParameters,
      'baseUrl': options.baseUrl,
      'method': options.method,
      'path': options.path,
    });

    if (options.data != null) {
      if (options.data is Map) {
        exContext.update('req', (value) {
          value['data'] = options.data;
          return value;
        });
      }
    }

    if (options.data is FormData) {
      List<MapEntry<String, String>> fields = (options.data as FormData).fields;
      exContext.update('req', (value) {
        value['data'] = {for (var e in fields) e.key: e.value};
        return value;
      });
    }

    final mapper = MapInterceptor();

    handler.resolve(mapper.map(Response(
        data: data,
        requestOptions: options,
        statusCode: statusCode,
    )));

  }

}