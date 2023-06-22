import 'package:flutter/material.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  final Color red;
  final Color green;
  final Color blue;
  final Color gray;
  final Color lightGray;

  const CustomColors({
    required this.red,
    required this.green,
    required this.blue,
    required this.gray,
    required this.lightGray,
  });

  static CustomColors of(BuildContext context) =>
      Theme.of(context).extension<CustomColors>()!;

  @override
  CustomColors copyWith({
    Color? red,
    Color? green,
    Color? blue,
    Color? gray,
    Color? lightGray,
  }) {
    return CustomColors(
      red: red ?? this.red,
      green: green ?? this.green,
      blue: blue ?? this.blue,
      gray: gray ?? this.gray,
      lightGray: lightGray ?? this.lightGray,
    );
  }

  @override
  CustomColors lerp(CustomColors? other, double t) {
    if (other is! CustomColors) return this;

    return CustomColors(
      red: Color.lerp(red, other.red, t)!,
      green: Color.lerp(green, other.green, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      gray: Color.lerp(gray, other.gray, t)!,
      lightGray: Color.lerp(lightGray, other.lightGray, t)!,
    );
  }
}
