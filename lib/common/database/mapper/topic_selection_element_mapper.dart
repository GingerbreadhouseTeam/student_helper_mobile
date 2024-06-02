import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/domain/model/topic_selection_element/topic_selection_element.dart';
import 'package:student_helper/common/utils/color_types.dart';

class TopicSelectionElementMapper {
  Topic fromDb(TopicSelectionElementDbData item) {
    return Topic(
        topicId: item.topicId,
        color: ItemColor.fromJson(item.topicColor),
        topics: item.topicSelectionElements
    );
  }

  TopicSelectionElementDbData toDb(Topic item) {
    return TopicSelectionElementDbData(
        topicId: item.topicId,
        topicColor: ItemColor.toJson(item.color),
        topicSelectionElements: item.topics
    );
  }
}