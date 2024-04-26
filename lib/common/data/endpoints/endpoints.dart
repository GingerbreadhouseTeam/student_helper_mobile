import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'endpoints.g.dart';

@riverpod
Endpoints endpoints(EndpointsRef ref) {
  return Endpoints();
}

class Endpoints {
  final mainItems = _MainItems();
}

class _MainItems {
  final main = 'group/main';
}