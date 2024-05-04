import 'package:easy_localization/easy_localization.dart';

import '../../generated/locale_keys.g.dart';

extension DateFormatters on DateTime {
  String getMonthNameYear({String locale = 'ru_RU'}) {
    return DateFormat('${_getFullMonthName(month)} y', locale).format(this);
  }

  String _getFullMonthName(int month) {
    switch (month) {
      case 1:
        return LocaleKeys.month_names_january.tr();
      case 2:
        return LocaleKeys.month_names_february.tr();
      case 3:
        return LocaleKeys.month_names_march.tr();
      case 4:
        return LocaleKeys.month_names_april.tr();
      case 5:
        return LocaleKeys.month_names_may.tr();
      case 6:
        return LocaleKeys.month_names_june.tr();
      case 7:
        return LocaleKeys.month_names_july.tr();
      case 8:
        return LocaleKeys.month_names_august.tr();
      case 9:
        return LocaleKeys.month_names_september.tr();
      case 10:
        return LocaleKeys.month_names_october.tr();
      case 11:
        return LocaleKeys.month_names_november.tr();
      case 12:
        return LocaleKeys.month_names_december.tr();
      default:
        return LocaleKeys.month_names_december.tr();
    }
  }
}