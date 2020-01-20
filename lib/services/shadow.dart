import 'package:flutter/widgets.dart';

calculateShadowColor(color) {
  return HSLColor.fromColor(color)
      .withLightness(HSLColor.fromColor(color).lightness - 0.5 > 0.0
          ? HSLColor.fromColor(color).lightness - 0.1
          : 0.3)
      // .withValue(color.value - 0.5 > 0.0 ? color.value - 0.1 : 0.3)
      .toColor();
}
