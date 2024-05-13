import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/repository/token_repository/token_repository.dart';

part 'navigation_controller.g.dart';

sealed class NavigationState {}

class Authorized extends NavigationState {}

class Unauthorized extends NavigationState {}

@Riverpod(keepAlive: true)
class NavigationController extends _$NavigationController {
  @override
  FutureOr<NavigationState> build() async{
    final token = await ref.read(
      tokenRepositoryProvider.select((value) => value.getTnx())
    );

    if (token == null || token.isEmpty) return Unauthorized();
    return Authorized();
  }
}