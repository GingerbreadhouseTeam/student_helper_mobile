import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/repository/group_participants/group_participants_repository.dart';

import '../../model/group_participant/group_participant.dart';

part 'group_participant_controller.g.dart';

@riverpod
class GroupParticipantController extends _$GroupParticipantController {
  GroupParticipantsRepository get _repository => ref.read(groupParticipantsRepositoryProvider);

  List<GroupParticipant> fullList = [];

  Future<List<GroupParticipant>> build(String groupId) async {
    final stream = _repository.watch(groupId).asBroadcastStream();

    final sub = stream.listen((event) {
      state = AsyncData(event);
      fullList = event;
    }, onError: (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    });

    ref.onDispose(() {
      sub.cancel();
    });

    return stream.first;
  }
  
  Future<void> searchFilter(String searchValue) async {
    final toSearch = fullList;

    if (toSearch.isNotEmpty && searchValue.isNotEmpty){
      state = AsyncData(toSearch.where(
              (element) => element.name.toLowerCase().contains(searchValue.toLowerCase())

      ).toList());
    } else {
      state = AsyncData(fullList);
    }


  }
}
