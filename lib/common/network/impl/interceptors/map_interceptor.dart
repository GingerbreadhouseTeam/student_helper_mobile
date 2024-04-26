import 'dart:ffi';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:student_helper/common/network/errors.dart';

class MapInterceptor extends InterceptorsWrapper {

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err is BadRequest) {
      return handler.reject(err);
    } else if (err.response == null) {
      return handler.reject(NoInternetConnection());
    }

    var statusCode = err.response?.statusCode ?? 500;

    if (statusCode >= 500 && statusCode <= 599) {
      return handler.reject(ServerInternal());
    }

    if (statusCode == 404) {
      return handler.reject(NotFound());
    }

    if (statusCode == 413) {
      return handler.reject(ToLargeError());
    }

    if (statusCode > 401 && statusCode <= 499) {
      return handler.reject(UnknownError());
    }

    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      return handler.resolve(map(response));
    } on DioException catch (e) {
      return handler.reject(e);
    } catch (e) {
      handler.reject(UnknownError());
    }
  }

  Response map(Response response) {
    if (response.data != null) {
      if (response.data['status'] == 'err') {
        final error = response.data['err'];
        //TODO Добавить текст ошибки
        if (error == 'errors') {
          throw TimeDelay(
              int.tryParse(response.data['errdesc'].toString()) ?? 0);
        }
        throw BadRequest(
          key: response.data['err'] ?? '',
          desc: response.data['errdesc'],
        );
      }
    }

    if (response.data is String || response.data is Uint8List) {
      return Response<dynamic>(
        requestOptions: response.requestOptions,
        data: response.data,
        extra: response.extra,
        redirects: response.redirects,
        statusMessage: response.statusMessage,
        statusCode: response.statusCode,
        isRedirect: response.isRedirect,
        headers: response.headers,
      );
    }

    if (response.data?['response'] is Iterable) {
      return Response<List<dynamic>>(
        requestOptions: response.requestOptions,
        data: response.data?['response'],
        extra: response.extra,
        redirects: response.redirects,
        statusMessage: response.statusMessage,
        statusCode: response.statusCode,
        isRedirect: response.isRedirect,
        headers: response.headers,
      );
    }

    return Response<Map<String, dynamic>>(
      requestOptions: response.requestOptions,
      data: response.data?['response'],
      extra: response.extra,
      redirects: response.redirects,
      statusMessage: response.statusMessage,
      statusCode: response.statusCode,
      isRedirect: response.isRedirect,
      headers: response.headers,
    );
  }

}