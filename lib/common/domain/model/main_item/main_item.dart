import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_item.freezed.dart';
part 'main_item.g.dart';

enum MainItemColor {
  white('white'),
  brown('brown'),
  green('green'),
  sea('sea'),
  blue('blue'),
  black('black'),
  yellow('yellow'),
  red('red'),
  pink('pink'),
  purple('purple'),
  unknown('');

  final String color;
  const MainItemColor(this.color);

  static MainItemColor fromJson(String? value) {
    return MainItemColor.values.firstWhere(
            (element) => element.color == value,
      orElse: () => MainItemColor.unknown
    );
  }

  static String toJson(MainItemColor value) {
    return value.color;
  }
}

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
    @JsonKey(fromJson: MainItemColor.fromJson, toJson: MainItemColor.toJson)
    required MainItemColor color,
}) = _MainItem;
  factory MainItem.fromJson(Map<String, dynamic> json) =>
      _$MainItemFromJson(json);
}