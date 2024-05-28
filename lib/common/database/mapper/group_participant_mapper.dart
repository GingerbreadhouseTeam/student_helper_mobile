import 'package:student_helper/common/domain/model/group_participant/group_participant.dart';
import 'package:student_helper/common/domain/model/profile_info/profile_info.dart';
import '../app_database.dart';

class GroupParticipantMapper {

  GroupParticipantDbData toDb(GroupParticipant item) {
    return GroupParticipantDbData(
        userId: item.userId,
        role: UserRole.toJson(item.role),
        name: item.name
    );
  }

  GroupParticipant fromDb(GroupParticipantDbData item) {
    return GroupParticipant(
        userId: item.userId,
        role: UserRole.fromJson(item.role),
        name: item.name
    );
  }
}