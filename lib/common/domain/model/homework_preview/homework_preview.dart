import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:student_helper/common/utils/color_types.dart';

part 'homework_preview.freezed.dart';
part 'homework_preview.g.dart';

@freezed
class HomeworkPreview with _$HomeworkPreview {
  factory HomeworkPreview({
    required String id,
    @JsonKey(name: 'subject_name')
    required String subjectName,
    required String text,
    @JsonKey(fromJson: ItemColor.fromJson, toJson: ItemColor.toJson)
    required ItemColor color,
}) = _HomeworkPreview;

  factory HomeworkPreview.fromJson(Map<String, dynamic> json) =>
      _$HomeworkPreviewFromJson(json);
}