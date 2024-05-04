import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/domain/model/schedule_element/schedule_element.dart';
import 'package:student_helper/common/utils/color_types.dart';

class ScheduleElementMapper {
  ScheduleElementDbData toDb(ScheduleElement item) {
    return ScheduleElementDbData(
        id: item.id,
        subjectName: item.subjectName,
        homework: item.homework,
        start: item.start,
        end: item.end,
        type: ScheduleElementType.toJson(item.type),
        indexNumber: item.indexNumber,
        color: ItemColor.toJson(item.color)
    );
  }

  ScheduleElement fromDb(ScheduleElementDbData item) {
    return ScheduleElement(
        id: item.id,
        subjectName: item.subjectName,
        homework: item.homework,
        start: item.start,
        end: item.end,
        type: ScheduleElementType.fromJson(item.type),
        indexNumber: item.indexNumber,
        color: ItemColor.fromJson(item.color)
    );
  }
}