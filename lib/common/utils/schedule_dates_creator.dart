import 'package:dart_date/dart_date.dart';

class ScheduleDateCreator {

  List<DateTime> createWeek(DateTime date) {
    final startOfWeek = date.startOfISOWeek;
    final result = [startOfWeek];
    for (int i = 1; i < 6; i++) {
      result.add(startOfWeek.addDays(i));
    }

    return result;
  }

  Map<int, List<DateTime>> createSchedule(DateTime start) {
    final Map<int, List<DateTime>> result = {};
    DateTime currentWeekDay = start;
    for (int i = 0; i < 18; i++){
      result[i + 1] = createWeek(currentWeekDay);
      currentWeekDay = currentWeekDay.nextWeek;
    }
    return result;
  }

}