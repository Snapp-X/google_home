import 'package:flutter/material.dart';
import 'package:google_home/src/home_feature/widget/slider.dart';

const _primary = Color(0xFF381E72);
const _onPrimary = Color(0xFFFFFFFF);
const _primaryContainer = Color(0xFF2F2F3E);
const _onPrimaryContainer = Color(0x7fFFFFFF);
const _secondary = Color(0xFF5771C1);
const _onSecondary = Color(0x7fFFFFFF);
const _background = Color(0xFF18181E);
const _onBackground = Color(0xFFFFFFFF);
const _surface = Color(0xFF1e1e26);
const _onSurface = Color(0xFFFFFFFF);

final darkTheme = _buildDarkTheme();

ThemeData _buildDarkTheme() {
  const scheme = ColorScheme.dark(
    primary: _primary,
    onPrimary: _onPrimary,
    primaryContainer: _primaryContainer,
    onPrimaryContainer: _onPrimaryContainer,
    secondary: _secondary,
    onSecondary: _onSecondary,
    background: _background,
    onBackground: _onBackground,
    surface: _surface,
    onSurface: _onSurface,
  );

  final base = ThemeData.from(
    colorScheme: scheme,
    useMaterial3: true,
  );

  return base.copyWith(
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return scheme.primary;
          }
          return scheme.onPrimaryContainer;
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return scheme.secondary;
          }
          return scheme.primaryContainer;
        },
      ),
      trackOutlineColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return scheme.secondary;
          }
          return scheme.primaryContainer;
        },
      ),
    ),
    sliderTheme: SliderThemeData(
      trackHeight: 14,
      inactiveTrackColor: scheme.primaryContainer,
      activeTrackColor: scheme.secondary,
      trackShape: const RoundedDeepSliderTrackShape(),
      thumbColor: scheme.primary,
      thumbShape: const RoundSliderThumbShape(
        enabledThumbRadius: 6,
      ),
    ),
  );
}
