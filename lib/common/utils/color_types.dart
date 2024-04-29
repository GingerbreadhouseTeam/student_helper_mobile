import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

enum ItemColor {
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
  const ItemColor(this.color);

  static ItemColor fromJson(String? value) {
    return ItemColor.values.firstWhere(
            (element) => element.color == value,
        orElse: () => ItemColor.unknown
    );
  }

  static String toJson(ItemColor value) {
    return value.color;
  }
}

Color getColor(
    ItemColor color,
    BuildContext context
    ) {
  switch (color){
    case ItemColor.white:
      return context.colors.shared.white;
    case ItemColor.brown:
      return context.colors.shared.brown;
    case ItemColor.green:
      return context.colors.shared.green;
    case ItemColor.sea:
      return context.colors.shared.sea;
    case ItemColor.blue:
      return context.colors.shared.blue;
    case ItemColor.black:
      return context.colors.shared.black;
    case ItemColor.yellow:
      return context.colors.shared.yellow;
    case ItemColor.red:
      return context.colors.shared.red;
    case ItemColor.pink:
      return context.colors.shared.pink;
    case ItemColor.purple:
      return context.colors.shared.purple;
    default:
      return context.colors.shared.white;
  }
}