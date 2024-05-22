import 'package:student_helper/common/database/app_database.dart';

import '../../domain/model/queue_element/queue_element.dart';

class QueueMapper {
  QueueDbData toDb(Queue item) {
    return QueueDbData(
        queueId: item.queueId,
        queueList: item.queueList
    );
  }

  Queue fromDb(QueueDbData item) {
    return Queue(
        queueId: item.queueId,
        queueList: item.queueList
    );
  }
}