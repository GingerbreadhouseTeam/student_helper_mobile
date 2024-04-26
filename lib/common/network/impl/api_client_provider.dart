import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/network/api_client.dart';
import 'package:dio/dio.dart';
import 'package:student_helper/common/network/impl/interceptors/map_interceptor.dart';
import 'package:student_helper/common/network/impl/interceptors/mock_interceptor.dart';


part 'api_client_provider.g.dart';

part 'dio_client_impl.dart';

@riverpod
ApiClient apiClient(ApiClientRef ref) {
  return _DioClientImpl(ref);
}