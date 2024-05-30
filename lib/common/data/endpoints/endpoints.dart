import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'endpoints.g.dart';

@riverpod
Endpoints endpoints(EndpointsRef ref) {
  return Endpoints();
}

class Endpoints {
  final group = _Group();
  final auth = _Auth();
  final profile = _Profile();
}

class _Group {
  final main = 'group/main';
  final subjectsPreview = 'group/subjects_preview';
  final homeworkPreview = 'group/homework_preview';
  final schedule = 'group/schedule';
  final topicElement = 'group/topic_elements';
  final queueList = 'group/queue_list';
  final participantsList = 'group/participants_list';
  final code = 'group/code';
  final subjectInfo = 'group/subject_info';
}


class _Auth {
  final signIn = 'users/sign_in';
}

class _Profile {
  final profileInfo = 'users/profile_info';
}


