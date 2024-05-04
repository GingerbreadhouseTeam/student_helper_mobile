import 'package:dart_date/dart_date.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/data/repository/schedule_element_repository/schedule_element_repository.dart';
import 'package:student_helper/common/domain/model/schedule_element/schedule_element.dart';

part 'schedule_element_controller.g.dart';

@riverpod
class ScheduleElementController extends _$ScheduleElementController {

  ScheduleElementRepository get _repository => ref.read(scheduleElementRepositoryProvider);

  DateTime selectedDate = DateTime.now();
  List<ScheduleElement> fullSchedule = [];

  @override
  Future<List<ScheduleElement>> build() async {
    final stream = _repository.watch().asBroadcastStream();

    final sub = stream.listen((event) {
      fullSchedule = event;
      filterSchedule(selectedDate);
    }, onError: (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    });

    ref.onDispose(() {
      sub.cancel();
    });


    return [];
  }

  Future<void> filterSchedule(DateTime date) async {
    selectedDate = date;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return fullSchedule.where((element) => element.start.isSameDay(date)).toList();
    });

  }


}