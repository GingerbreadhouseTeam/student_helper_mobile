
import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic_selection_element.g.dart';
part 'topic_selection_element.freezed.dart';

@freezed
class Topic with _$Topic {
  factory Topic({
    @JsonKey(name: "topic_id")
    required String topicId,
    required List<TopicSelectionElement> topics,
}) = _Topic;
  factory Topic.fromJson(Map<String, dynamic> json)
    => _$TopicFromJson(json);
}

@freezed
class TopicSelectionElement with _$TopicSelectionElement {
  factory TopicSelectionElement({
    required String id,
    required int index,
    @JsonKey(name: "topic_name")
    required String topicName,
    @JsonKey(name: "user_id")
    required String? userId,
    @JsonKey(name: "user_name")
    required String? userName
}) = _TopicSelectionElement;

  factory TopicSelectionElement.fromJson(Map<String, dynamic> json)
    => _$TopicSelectionElementFromJson(json);
}