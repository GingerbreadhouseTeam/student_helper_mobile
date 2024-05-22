import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue_element.g.dart';
part 'queue_element.freezed.dart';

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
    @JsonKey(name: 'list')
    required List<QueueElement> queueList
}) = _Queue;
  factory Queue.fromJson(Map<String, dynamic> json) => _$QueueFromJson(json);
}