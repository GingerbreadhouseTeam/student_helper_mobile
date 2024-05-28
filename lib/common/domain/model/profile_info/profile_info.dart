import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_info.g.dart';
part 'profile_info.freezed.dart';

enum UserRole {
  student('student'),
  headman('headman'),
  coHeadman('co_headman'),
  unknown('');

  final String role;
  const UserRole(this.role);

  static UserRole fromJson(String? value) {
    return UserRole.values.firstWhere(
            (element) => element.role == value,
      orElse: () => UserRole.unknown
    );
  }

  static String toJson(UserRole value) {
    return value.role;
  }

}

@freezed
class ProfileInfo with _$ProfileInfo {
  factory ProfileInfo({
    @JsonKey(name: 'user_id')
    required String userId,
    @JsonKey(name: 'group_id')
    required String groupId,
    @JsonKey(name: 'group_name')
    required String groupName,
    required String name,
    required String email,
    @JsonKey(fromJson: UserRole.fromJson, toJson: UserRole.toJson)
    required UserRole role
}) = _ProfileInfo;
  factory ProfileInfo.fromJson(Map<String, dynamic> json) =>
      _$ProfileInfoFromJson(json);
}