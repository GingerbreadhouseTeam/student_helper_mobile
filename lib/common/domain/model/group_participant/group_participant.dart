import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:student_helper/common/domain/model/profile_info/profile_info.dart';

part 'group_participant.g.dart';
part 'group_participant.freezed.dart';

@freezed
class GroupParticipant with _$GroupParticipant {
  factory GroupParticipant({
    @JsonKey(name: "user_id")
    required String userId,
    @JsonKey(fromJson: UserRole.fromJson, toJson: UserRole.toJson)
    required UserRole role,
    required String name
}) = _GroupParticipant;

  factory GroupParticipant.fromJson(Map<String, dynamic> json) => _$GroupParticipantFromJson(json);
}