import 'package:dio/dio.dart';

sealed class NetworkException extends DioException {
  NetworkException() : super(requestOptions: RequestOptions());
}

class BadRequest extends NetworkException {
  String key;
  String? desc;

  BadRequest({
    required this.key,
    required this.desc,
  }) : super();
}

class NotFound extends NetworkException {}

class ServerInternal extends NetworkException {}

class NoInternetConnection extends NetworkException {}

class UnknownError extends NetworkException {}

class ToLargeError extends NetworkException {}

class TimeDelay extends NetworkException {
  final int seconds;

  TimeDelay(this.seconds);
}