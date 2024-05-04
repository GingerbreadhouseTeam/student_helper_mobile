import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:student_helper/common/utils/color_types.dart';

part 'schedule_element.g.dart';
part 'schedule_element.freezed.dart';

enum ScheduleElementType {
  lecture('lecture'),
  seminar('seminar'),
  unknown('');

  final String type;
  const ScheduleElementType(this.type);

  static ScheduleElementType fromJson(String? value) {
    return ScheduleElementType.values.firstWhere(
            (element) => element.type == value,
      orElse: () => ScheduleElementType.unknown
    );
  }

  static String toJson(ScheduleElementType value) {
    return value.type;
  }
}

@freezed
class ScheduleElement with _$ScheduleElement {
  factory ScheduleElement({
    required String id,
    @JsonKey(name: 'subject_name')
    required String subjectName,
    required String? homework,
    required DateTime start,
    required DateTime end,
    @JsonKey(fromJson: ScheduleElementType.fromJson, toJson: ScheduleElementType.toJson)
    required ScheduleElementType type,
    @JsonKey(name: 'index')
    required int indexNumber,
    @JsonKey(fromJson: ItemColor.fromJson, toJson: ItemColor.toJson)
    required ItemColor color,
}) = _ScheduleElement;
  factory ScheduleElement.fromJson(Map<String, dynamic> json) =>
      _$ScheduleElementFromJson(json);
}