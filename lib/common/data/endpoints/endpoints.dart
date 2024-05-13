import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'endpoints.g.dart';

@riverpod
Endpoints endpoints(EndpointsRef ref) {
  return Endpoints();
}

class Endpoints {
  final mainItems = _MainItems();
  final subjectPreview = _SubjectPreview();
  final homeworkPreview = _HomeworkPreview();
  final scheduleElement = _ScheduleElement();
  final auth = _Auth();
  final profile = _Profile();
  final topic = _Topic();
}

class _MainItems {
  final main = 'group/main';
}

class _SubjectPreview {
  final subjects = 'group/subjects_preview';
}

class _HomeworkPreview {
  final homeworks = 'group/homework_preview';
}

class _ScheduleElement {
  final schedule = 'group/schedule';
}

class _Auth {
  final signIn = 'users/sign_in';
}

class _Profile {
  final profileInfo = 'users/profile_info';
}

class _Topic {
  final topicElement = 'group/topic_elements';
}