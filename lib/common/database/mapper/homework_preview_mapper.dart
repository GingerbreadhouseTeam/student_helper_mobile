import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/domain/model/homework_preview/homework_preview.dart';
import 'package:student_helper/common/utils/color_types.dart';

class HomeworkPreviewMapper {
  HomeworkPreviewDbData toDb(HomeworkPreview item) {
    return HomeworkPreviewDbData(
        id: item.id,
        subjectName: item.subjectName,
        homeworkText: item.text,
        color: ItemColor.toJson(item.color)
    );
  }

  HomeworkPreview fromDb(HomeworkPreviewDbData item) {
    return HomeworkPreview(
        id: item.id,
        subjectName: item.subjectName,
        text: item.homeworkText,
        color: ItemColor.fromJson(item.color)
    );
  }
}