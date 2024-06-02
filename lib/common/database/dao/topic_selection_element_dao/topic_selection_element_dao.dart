import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/database/mapper/topic_selection_element_mapper.dart';

import '../../../domain/model/topic_selection_element/topic_selection_element.dart';
import '../../model/topic_selection_element_db.dart';

part 'topic_selection_element_dao.g.dart';

@riverpod
TopicSelectionElementDao topicSelectionElementDao(TopicSelectionElementDaoRef ref) {
  return TopicSelectionElementDao(ref.watch(databaseProvider));
}

@DriftAccessor(tables: [TopicSelectionElementDb])
class TopicSelectionElementDao extends DatabaseAccessor<AppDatabase> with _$TopicSelectionElementDaoMixin {
  final TopicSelectionElementMapper mapper = TopicSelectionElementMapper();

  TopicSelectionElementDao(AppDatabase db) : super(db);

  Future<void> upsert(Topic item) async {
    await into(topicSelectionElementDb).insert(
      mapper.toDb(item),
      mode: InsertMode.insertOrReplace
    );
  }

  Future<void> addTopicElement({
    required String topicId,
    required TopicSelectionElement toAdd
}) async {
    final topic = await getById(topicId);
    if (topic != null) {
      List<TopicSelectionElement> newTopics = [];
      if (topic.topics.isNotEmpty) {
        newTopics = [...topic.topics, toAdd];
      } else {
        newTopics = [toAdd];
      }
      final newTopic = Topic(
          topicId: topicId,
          color: topic.color,
          topics: newTopics
      );

      upsert(newTopic);
    }
  }

  Future<void> changeContent({
    required String topicId,
    required String topicElementId,
    required String newContent
  }) async {
    final topic = await getById(topicId);
    if (topic != null) {
      final newTopic = Topic(
          topicId: topicId,
          color: topic.color,
          topics: topic.topics.map((e) {
            if (e.id == topicElementId) {
              return TopicSelectionElement(
                  id: e.id,
                  index: e.index,
                  topicName: newContent,
                  userId: e.userId,
                  userName: e.userName
              );
            } else {
              return e;
            }
          }).toList()
      );

      upsert(newTopic);
    }
  }

  Future<void> addUser({
    required String topicId,
    required String userId,
    required String userName,
    required String topicElementId
}) async {
    final topic = await getById(topicId);
    if (topic != null) {
      final newTopic = Topic(
          topicId: topicId,
          color: topic.color,
          topics: topic.topics.map((element) {
            if (element.id == topicElementId) {
              return TopicSelectionElement(
                  id: element.id,
                  index: element.index,
                  topicName: element.topicName,
                  userId: userId,
                  userName: userName
              );
            } else {
                return element;
            }

          }).toList()
      );
      upsert(newTopic);
    }


}

  Future<void> removeUser({
    required String topicId,
    required String userId,
    required String topicElementId
  }) async {
    final topic = await getById(topicId);
    if (topic != null) {
      final newTopic = Topic(
          topicId: topicId,
          color: topic.color,
          topics: topic.topics.map((element) {
            if (element.id == topicElementId) {
              return TopicSelectionElement(
                  id: element.id,
                  index: element.index,
                  topicName: element.topicName,
                  userId: null,
                  userName: null
              );
            } else {
              return element;
            }

          }).toList()
      );
      upsert(newTopic);
    }


  }

  Future<Topic?> getById(String id) async {
    final topic = await (select(topicSelectionElementDb)..where((tbl) => tbl.topicId.equals(id))).getSingleOrNull();
    if (topic == null) return null;
    return mapper.fromDb(topic);
  }

  Stream<Topic> watchById(String id) {
    return (select(topicSelectionElementDb)
      ..where((tbl) => tbl.topicId.equals(id)))
        .watchSingle().map((event) => mapper.fromDb(event));
  }


}