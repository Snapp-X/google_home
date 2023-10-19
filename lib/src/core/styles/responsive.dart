import 'package:flutter/material.dart';

enum ScreenBreakpoints { small, medium }

extension ResponsiveContext on BuildContext {
  ScreenBreakpoints get screenBreakpoint {
    final width = MediaQuery.of(this).size.width;
    if (width <= 200) {
      return ScreenBreakpoints.small;
    } else {
      return ScreenBreakpoints.medium;
    }
  }

  double get homeItemsGap =>
      screenBreakpoint == ScreenBreakpoints.small ? 11 : 19;

  EdgeInsets get viewPadding => screenBreakpoint == ScreenBreakpoints.small
      ? const EdgeInsets.symmetric(horizontal: 24, vertical: 32)
      : const EdgeInsets.symmetric(horizontal: 42, vertical: 52);

  double get sliderTrackerHeight =>
      screenBreakpoint == ScreenBreakpoints.small ? 14 : 20;

  double get switchScale =>
      screenBreakpoint == ScreenBreakpoints.small ? .6 : .7;

  TextStyle? get headerTextStyle =>
      Theme.of(this).textTheme.labelSmall?.copyWith(
            height: 1.2,
            fontSize: screenBreakpoint == ScreenBreakpoints.small ? 26 : 32,
            fontWeight: FontWeight.w500,
            color: Theme.of(this).colorScheme.onSurface,
          );

  TextStyle? get subHeaderTextStyle =>
      Theme.of(this).textTheme.labelSmall?.copyWith(
            height: 1.2,
            fontSize: screenBreakpoint == ScreenBreakpoints.small ? 18 : 20,
            fontWeight: FontWeight.w300,
            color: Theme.of(this).colorScheme.onSurface.withOpacity(.5),
          );

  TextStyle? get titleTextStyle =>
      Theme.of(this).textTheme.labelSmall?.copyWith(
            height: 1.2,
            fontSize: screenBreakpoint == ScreenBreakpoints.small ? 10 : 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(this).colorScheme.onSurface,
          );

  TextStyle? get subtitleTextStyle =>
      Theme.of(this).textTheme.labelSmall?.copyWith(
            height: 1.2,
            fontSize: screenBreakpoint == ScreenBreakpoints.small ? 8 : 12,
            fontWeight: FontWeight.w300,
            color: Theme.of(this).colorScheme.onSurface.withOpacity(.5),
          );

  TextStyle? get chartTextStyle =>
      Theme.of(this).textTheme.labelSmall?.copyWith(
            height: 1.2,
            fontSize: screenBreakpoint == ScreenBreakpoints.small ? 7 : 10,
            fontWeight: FontWeight.w300,
            color: Theme.of(this).colorScheme.onSurface.withOpacity(.5),
          );

  double get chartBarWidth =>
      screenBreakpoint == ScreenBreakpoints.small ? 10 : 18;

  double get colorPickerItemBorder =>
      screenBreakpoint == ScreenBreakpoints.small ? 4 : 6;
}
