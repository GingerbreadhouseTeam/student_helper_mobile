import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/domain/model/main_item/main_item.dart';

import '../../utils/color_types.dart';

class MainItemMapper {
  MainItem fromDb(MainItemDbData item) {
    return MainItem(
        id: item.id,
        type: MainItemType.fromJson(item.type),
        title: item.title,
        color: ItemColor.fromJson(item.color)
    );
  }

  MainItemDbData toDb(MainItem item) {
    return MainItemDbData(
        id: item.id,
        type: MainItemType.toJson(item.type),
        title: item.title,
        color: ItemColor.toJson(item.color)
    );
  }
}