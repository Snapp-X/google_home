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
  cloudy,
  rainy,
  snowy,
}

@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState({
    @Default('0°') String temperature,
    @Default(WeatherType.sunny) WeatherType weatherType,
    @Default('London') String city,
  }) = _WeatherState;
}
