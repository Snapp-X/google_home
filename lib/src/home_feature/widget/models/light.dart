import 'dart:ui';

import 'package:google_home/src/core/constants.dart';

class Light {
  bool ison;
  String source;
  bool hasTimer;
  int timerStarted;
  int timerDuration;
  int timerRemaining;
  String mode;
  int red;
  int green;
  int blue;
  int white;
  int gain;
  int temp;
  int brightness;
  int effect;

  Light({
    required this.ison,
    required this.source,
    required this.hasTimer,
    required this.timerStarted,
    required this.timerDuration,
    required this.timerRemaining,
    required this.mode,
    required this.red,
    required this.green,
    required this.blue,
    required this.white,
    required this.gain,
    required this.temp,
    required this.brightness,
    required this.effect,
  });

  int get colorIndex {
    final color = Color.fromARGB(255, red, green, blue);

    switch (color) {
      case colorPick1:
        return 2;
      case colorPick2:
        return 3;
      case colorPick3:
        return 4;
      case colorPick4:
        return 5;
      default:
        return 1;
    }
  }
}
