import 'dart:async';

import 'package:dbus/dbus.dart';
import 'package:google_home/src/core/services/extensions.dart';
import 'package:google_home/src/home_feature/home_repository.dart';
import 'package:google_home/src/home_feature/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeValuesProvider =
    StateNotifierProvider<HomeValuesNotifier, HomeValues>((ref) {
  final homeRepository = ref.read(homeRepositoryProvider);

  return HomeValuesNotifier(homeRepository: homeRepository);
});

class HomeValuesNotifier extends StateNotifier<HomeValues> {
  HomeValuesNotifier({required this.homeRepository})
      : super(const HomeValues()) {
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      // _updateCO2Sensor();
      _updateDateTime();
    });
    _init();
  }

  @override
  void dispose() {
    // dbusClient.close();
    super.dispose();
  }

  final HomeRepository homeRepository;
  late final DBusClient dbusClient;
  late final DBusRemoteObject dBusRemoteObject;

  void _init() {
    //init the dbus client and remote object
    // dbusClient = DBusClient.session();
    // dBusRemoteObject = DBusRemoteObject(dbusClient,
    //     name: 'de.snapp.CoSensorService', path: DBusObjectPath('/Sensor'));
    _initWeather();
    state = state.copyWith(
      todayWeather: const WeatherState(
        temperature: '18.2°',
        weatherType: WeatherType.rainy,
        city: 'London',
      ),
      tv: true,
    );
  }

  void _initWeather() {
    state = state.copyWith(
      todayWeather: const WeatherState(
        temperature: '18.2°',
        weatherType: WeatherType.sunny,
        dayTemperature: DayTemperature(
          min: 12,
          max: 23,
          current: 19,
          possibleMin: 17,
          possibleMax: 22,
        ),
        city: 'London',
      ),
      weekWeather: [
        const WeatherState(
          temperature: '18.2°',
          weatherType: WeatherType.rainy,
          dayTemperature: DayTemperature(
            min: 13,
            max: 24,
            current: 17,
            possibleMin: 15,
            possibleMax: 18,
          ),
          city: 'London',
        ),
        const WeatherState(
          temperature: '18.2°',
          weatherType: WeatherType.cloudy,
          dayTemperature: DayTemperature(
            min: 12,
            max: 25,
            current: 17,
            possibleMin: 16,
            possibleMax: 23,
          ),
          city: 'London',
        ),
        const WeatherState(
          temperature: '18.2°',
          weatherType: WeatherType.partiallySunny,
          dayTemperature: DayTemperature(
            min: 11,
            max: 22,
            current: 17,
            possibleMin: 16,
            possibleMax: 21,
          ),
          city: 'London',
        ),
      ],
    );
  }

  void _updateDateTime() {
    state = state.copyWith(
      formattedDate: DateTime.now().toDateString(),
      formattedTime: DateTime.now().toTimeString(),
    );
  }

  Future<void> _updateCO2Sensor() async {
    final response = await dBusRemoteObject.callMethod(
        'de.snapp.SensorInterface', 'GetSensorValue', [],
        replySignature: DBusSignature('as'));

    /// convert DBusArray to List
    final result = List<String>.from(response.values[0].asStringArray());

    final temp = result[0];
    final hum = result[1];
    final co2 = result[2];

    state = state.copyWith(
      airQuality: co2,
      temperature: temp,
      humidity: hum,
    );
  }

  void toggleTv() {
    // TODO(moritz): toggle the tv switch and change the tv state
    //something like below example

    // homeRepository.httpService.get('endpoint');

    // state = state.copyWith(
    //   tv: !state.tv,
    // );
  }

  void toggleLightBulb() {
    state = state.copyWith(
      lightBulbState: state.lightBulbState.copyWith(
        isOn: !state.lightBulbState.isOn,
      ),
    );
  }

  void changeLightColour(int color) {
    if (color > 5) {
      return;
    }

    var effectiveColor = color;

    if (color == state.lightBulbState.color) {
      effectiveColor = 1;
    }

    state = state.copyWith(
      lightBulbState: state.lightBulbState.copyWith(
        color: effectiveColor,
      ),
    );
  }

  rotateWeatherType() {
    final currentType = state.todayWeather?.weatherType ?? WeatherType.sunny;

    switch (currentType) {
      case WeatherType.sunny:
        state = state.copyWith(
          todayWeather: state.todayWeather?.copyWith(
            weatherType: WeatherType.partiallySunny,
          ),
        );
      case WeatherType.partiallySunny:
        state = state.copyWith(
          todayWeather: state.todayWeather?.copyWith(
            weatherType: WeatherType.cloudy,
          ),
        );
      case WeatherType.cloudy:
        state = state.copyWith(
          todayWeather: state.todayWeather?.copyWith(
            weatherType: WeatherType.rainy,
          ),
        );
      case WeatherType.rainy:
        state = state.copyWith(
          todayWeather: state.todayWeather?.copyWith(
            weatherType: WeatherType.sunny,
          ),
        );
    }
    ;
  }
}
