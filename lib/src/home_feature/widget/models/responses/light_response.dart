import 'package:google_home/src/home_feature/widget/models/light.dart';
import 'package:json_annotation/json_annotation.dart';

part 'light_response.g.dart';

@JsonSerializable()
class LightResponse {
  LightResponse({
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

  factory LightResponse.fromJson(Map<String, dynamic> json) =>
      _$LightResponseFromJson(json);

  bool ison;
  String source;
  @JsonKey(name: 'has_timer')
  bool hasTimer;
  @JsonKey(name: 'timer_started')
  int timerStarted;
  @JsonKey(name: 'timer_duration')
  int timerDuration;
  @JsonKey(name: 'timer_remaining')
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

  Light toLight() {
    return Light(
      ison: ison,
      source: source,
      hasTimer: hasTimer,
      timerStarted: timerStarted,
      timerDuration: timerDuration,
      timerRemaining: timerRemaining,
      mode: mode,
      red: red,
      green: green,
      blue: blue,
      white: white,
      gain: gain,
      temp: temp,
      brightness: brightness,
      effect: effect,
    );
  }
}
