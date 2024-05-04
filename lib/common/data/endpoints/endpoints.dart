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