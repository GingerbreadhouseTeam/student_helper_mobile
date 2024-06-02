import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:student_helper/common/domain/model/profile_info/profile_info.dart';
import 'package:student_helper/common/utils/color_types.dart';

part 'queue_element.g.dart';
part 'queue_element.freezed.dart';

enum QueueType {
  cyclic("cyclic"),
  sequential("sequential"),
  unknown("");

  final String type;
  const QueueType(this.type);

  static QueueType fromJson(String? value) {
    return QueueType.values.firstWhere(
            (element) => element.type == value,
      orElse: () => QueueType.unknown
    );
  }

  static String toJson(QueueType value) {
    return value.type;
  }
}


@freezed
class QueueElement with _$QueueElement {
  factory QueueElement({
    @JsonKey(name: 'user_id')
    required String userId,
    required int index,
    @JsonKey(name: 'user_name')
    required String userName
}) = _QueueElement;

  factory QueueElement.fromJson(Map<String, dynamic> json) => _$QueueElementFromJson(json);
}

@freezed
class Queue with _$Queue {
  factory Queue({
    @JsonKey(name: 'queue_id')
    required String queueId,
    @JsonKey(name: "queue_type", fromJson: QueueType.fromJson, toJson: QueueType.toJson)
    required QueueType queueType,
    @JsonKey(name: "queue_color", fromJson: ItemColor.fromJson, toJson: ItemColor.toJson)
    required ItemColor queueColor,
    @JsonKey(name: 'list')
    required List<QueueElement> queueList
}) = _Queue;
  factory Queue.fromJson(Map<String, dynamic> json) => _$QueueFromJson(json);
}