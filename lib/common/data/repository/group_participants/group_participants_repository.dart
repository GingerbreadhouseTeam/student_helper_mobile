import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/endpoints/endpoints.dart';
import 'package:student_helper/common/database/dao/group_participant_dao/group_participant_dao.dart';
import 'package:student_helper/common/domain/model/group_participant/group_participant.dart';
import 'package:student_helper/common/network/api_client.dart';
import 'package:student_helper/common/network/impl/api_client_provider.dart';

part 'group_participants_repository.g.dart';

@riverpod
GroupParticipantsRepository groupParticipantsRepository(GroupParticipantsRepositoryRef ref) {
  return GroupParticipantsRepository(ref);
}

class GroupParticipantsRepository {
  final Ref _ref;

  ApiClient get _api => _ref.read(apiClientProvider);

  GroupParticipantDao get _dao => _ref.read(groupParticipantDaoProvider);

  Endpoints get _ep => _ref.read(endpointsProvider);

  GroupParticipantsRepository(this._ref);

  Future<void> get(String groupId) async {
    final items = await _api.post(
        path: _ep.group.participantsList,
        body: {
          'group_id': groupId
        },
      map: (data) async {
          if (data?['list'] == null) return <GroupParticipant>[];
          return (data?['list'] as Iterable).map(
                  (e) => GroupParticipant.fromJson(e)
          ).toList();
      }
    );

    await _dao.cleanUpsert(items!);
  }

  Stream<List<GroupParticipant>> watch(String groupId) async* {
    final cache = await _dao.get();
    if (cache.isEmpty) {
      await get(groupId);
    } else {
      get(groupId);
    }

    yield* _dao.watch();
  }
}