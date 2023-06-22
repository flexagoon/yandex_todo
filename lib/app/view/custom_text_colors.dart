import 'package:flutter/material.dart';

@immutable
class CustomTextColors extends ThemeExtension<CustomTextColors> {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color disable;

  const CustomTextColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.disable,
  });

  static CustomTextColors of(BuildContext context) =>
      Theme.of(context).extension<CustomTextColors>()!;

  @override
  CustomTextColors copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? disable,
  }) {
    return CustomTextColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      disable: disable ?? this.disable,
    );
  }

  @override
  CustomTextColors lerp(CustomTextColors? other, double t) {
    if (other is! CustomTextColors) return this;

    return CustomTextColors(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      disable: Color.lerp(disable, other.disable, t)!,
    );
  }
}
