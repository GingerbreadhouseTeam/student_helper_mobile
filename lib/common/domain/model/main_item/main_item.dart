import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/color_types.dart';

part 'main_item.freezed.dart';
part 'main_item.g.dart';



enum MainItemType {
  order('order'),
  theme('theme'),
  unknown('');

  final String type;
  const MainItemType(this.type);

  static MainItemType fromJson(String? value) {
    return MainItemType.values.firstWhere(
            (element) => element.type == value,
      orElse: () => MainItemType.unknown
    );
  }

  static String toJson(MainItemType value) {
    return value.type;
  }

}

@freezed
class MainItem with _$MainItem {
  factory MainItem({
    required String id,
    @JsonKey(fromJson: MainItemType.fromJson, toJson: MainItemType.toJson)
    required MainItemType type,
    required String title,
    @JsonKey(fromJson: ItemColor.fromJson, toJson: ItemColor.toJson)
    required ItemColor color,
}) = _MainItem;
  factory MainItem.fromJson(Map<String, dynamic> json) =>
      _$MainItemFromJson(json);
}