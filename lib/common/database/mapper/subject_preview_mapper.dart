import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/domain/model/subject_preview/subject_preview.dart';
import 'package:student_helper/common/utils/color_types.dart';

class SubjectPreviewMapper {
  SubjectPreviewDbData toDb(SubjectPreview item) {
    return SubjectPreviewDbData(
        id: item.id,
        control: SubjectControl.toJson(item.control),
        color: ItemColor.toJson(item.color),
        title: item.title
    );
  }

  SubjectPreview fromDb(SubjectPreviewDbData item) {
    return SubjectPreview(
        id: item.id,
        control: SubjectControl.fromJson(item.control),
        color: ItemColor.fromJson(item.color),
        title: item.title
    );
  }
}