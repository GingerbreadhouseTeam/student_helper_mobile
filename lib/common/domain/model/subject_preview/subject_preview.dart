import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/color_types.dart';

part 'subject_preview.freezed.dart';
part 'subject_preview.g.dart';

enum SubjectControl {
  exam('exam'),
  test('test'),
  unknown('');

  final String control;
  const SubjectControl(this.control);

  static SubjectControl fromJson(String? value) {
    return SubjectControl.values.firstWhere(
            (element) => element.control == value,
      orElse: () => SubjectControl.unknown
    );
  }
  static String toJson(SubjectControl value) {
    return value.control;
  }
}

@freezed
class SubjectPreview with _$SubjectPreview {
  factory SubjectPreview({
    required String id,
    @JsonKey(fromJson: SubjectControl.fromJson, toJson: SubjectControl.toJson)
    required SubjectControl control,
    @JsonKey(fromJson: ItemColor.fromJson, toJson: ItemColor.toJson)
    required ItemColor color,
    required String title

}) = _SubjectPreview;
  factory SubjectPreview.fromJson(Map<String, dynamic> json) =>
      _$SubjectPreviewFromJson(json);
}