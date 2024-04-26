import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Override>> getOverridesDependency() async {
  final sp = await SharedPreferences.getInstance();
  return [
    sharedPrefProvider.overrideWithValue(sp),
  ];
}

final sharedPrefProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});