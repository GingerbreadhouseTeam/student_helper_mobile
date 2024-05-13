import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/domain/model/profile_info/profile_info.dart';

class ProfileInfoMapper {
  ProfileInfo fromDb(ProfileInfoDbData item) {
    return ProfileInfo(
        userId: item.userId,
        groupId: item.groupId,
        name: item.name,
        email: item.email,
        role: UserRole.fromJson(item.role)
    );
  }

  ProfileInfoDbData toDb(ProfileInfo item) {
    return ProfileInfoDbData(
        userId: item.userId,
        groupId: item.groupId,
        name: item.name,
        email: item.email,
        role: UserRole.toJson(item.role)
    );
  }
}