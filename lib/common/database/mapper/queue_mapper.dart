import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/utils/color_types.dart';

import '../../domain/model/queue_element/queue_element.dart';

class QueueMapper {
  QueueDbData toDb(Queue item) {
    return QueueDbData(
        queueId: item.queueId,
        queueType: QueueType.toJson(item.queueType),
        queueColor: ItemColor.toJson(item.queueColor),
        queueList: item.queueList
    );
  }

  Queue fromDb(QueueDbData item) {
    return Queue(
        queueId: item.queueId,
        queueType: QueueType.fromJson(item.queueType),
        queueColor: ItemColor.fromJson(item.queueColor),
        queueList: item.queueList
    );
  }
}