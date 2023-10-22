import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.init() = _HomeStateInit;
  const factory HomeState.loading() = _HomeStateLoading;
  const factory HomeState.loaded() = _HomeStateLoaded;
  const factory HomeState.error(String message) = _HomeStateError;
}

@freezed
class HomeValues with _$HomeValues {
  const factory HomeValues({
    WeatherState? todayWeather,
    @Default([]) List<WeatherState> weekWeather,
    @Default(LightBulbState()) LightBulbState lightBulbState,
    @Default('') String formattedTime,
    @Default('') String formattedDate,
    @Default('') String airQuality,
    @Default('') String temperature,
    @Default('') String humidity,
    @Default(false) bool tv,
    @Default(false) bool stereo,
    @Default(false) bool thermostat,
    @Default(false) bool fan,
  }) = _HomeValues;
}

enum WeatherType {
  sunny,
  partiallySunny,
  cloudy,
  rainy,
}

@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState({
    @Default('0°') String temperature,
    @Default(WeatherType.sunny) WeatherType weatherType,
    @Default(DayTemperature()) DayTemperature dayTemperature,
    @Default('London') String city,
  }) = _WeatherState;
}

@freezed
class DayTemperature with _$DayTemperature {
  const factory DayTemperature({
    @Default(0.0) double min,
    @Default(25.0) double max,
    @Default(7.0) double current,
    @Default(5.0) double possibleMin,
    @Default(10.0) double possibleMax,
  }) = _DayTemperatur;
}

@freezed
class LightBulbState with _$LightBulbState {
  const factory LightBulbState({
    @Default(false) bool isOn,
    @Default(0) int colorIndex,
    @Default(10) int intensity,
  }) = _LightBulbState;
}
