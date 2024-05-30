import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/domain/model/subject_info/subject_info.dart';
import 'package:student_helper/common/domain/model/subject_preview/subject_preview.dart';
import 'package:student_helper/common/utils/color_types.dart';

class SubjectInfoMapper {
  SubjectInfoDbData toDb(SubjectInfo item) {
    return SubjectInfoDbData(
        subjectId: item.subjectId,
        name: item.name,
        control: SubjectControl.toJson(item.control),
        color: ItemColor.toJson(item.color),
        seminaryTeacher: item.seminaryTeacher,
        lectureTeacher: item.lectureTeacher,
        commentary: item.commentary,
        homeworks: item.homeworks
    );
  }

  SubjectInfo fromDb(SubjectInfoDbData item) {
    return SubjectInfo(
        subjectId: item.subjectId,
        name: item.name,
        control: SubjectControl.fromJson(item.control),
        color: ItemColor.fromJson(item.color),
        seminaryTeacher: item.seminaryTeacher,
        lectureTeacher: item.lectureTeacher,
        commentary: item.commentary,
        homeworks: item.homeworks
    );
  }
}