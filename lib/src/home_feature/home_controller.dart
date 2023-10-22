import 'dart:async';
import 'dart:io';

import 'package:dbus/dbus.dart';
import 'package:google_home/src/core/constants.dart';
import 'package:google_home/src/core/services/extensions.dart';
import 'package:google_home/src/home_feature/home_repository.dart';
import 'package:google_home/src/home_feature/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// refresh interval in milliseconds
const int _refreshInterval = 1000;

final homeValuesProvider =
    StateNotifierProvider<HomeValuesNotifier, HomeValues>((ref) {
  final homeRepository = ref.read(homeRepositoryProvider);

  return HomeValuesNotifier(homeRepository: homeRepository);
});

class HomeValuesNotifier extends StateNotifier<HomeValues> {
  HomeValuesNotifier({required this.homeRepository})
      : super(const HomeValues()) {
    Timer.periodic(const Duration(milliseconds: _refreshInterval), (timer) {
      _updateCO2Sensor();
      _updateDateTime();
      _getShellyDeviceStatus();
    });
    _init();
  }

  @override
  void dispose() {
    if (Platform.isLinux) dbusClient.close();
    super.dispose();
  }

  final HomeRepository homeRepository;
  late final DBusClient dbusClient;
  late final DBusRemoteObject dBusRemoteObject;

  void _init() {
    _initDbus();
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

  Future<void> _getShellyDeviceStatus() async {
    final bulbStatus = await homeRepository.getBulbStatus();
    bulbStatus.fold(
      (exception) => null,
      (bulbStatus) {
        state = state.copyWith(
            lightBulbState: (LightBulbState(
          isOn: bulbStatus.lights.first.ison,
          intensity: bulbStatus.lights.first.gain,
          colorIndex: bulbStatus.lights.first.colorIndex,
        )));
      },
    );
  }

  void _initDbus() {
    if (!Platform.isLinux) return;
    //init the dbus client and remote object
    dbusClient = DBusClient.session();
    dBusRemoteObject = DBusRemoteObject(dbusClient,
        name: 'de.snapp.CoSensorService', path: DBusObjectPath('/Sensor'));
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
    if (!Platform.isLinux) return;
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

  Future<void> toggleLightBulb() async {
    final light = await homeRepository.setBulb(!state.lightBulbState.isOn);
    light.fold(
      (exception) => null,
      (light) {
        state = state.copyWith(
            lightBulbState: state.lightBulbState.copyWith(
          isOn: light.ison,
        ));
      },
    );
  }

  void updateSliderPosition(double position) {
    state = state.copyWith(
        lightBulbState: state.lightBulbState.copyWith(
      intensity: position.toInt(),
    ));
  }

  Future<void> setLightBrightness(int brightness) async {
    final light = await homeRepository.setBulbBrightness(brightness);
    light.fold(
      (exception) => null,
      (light) {
        state = state.copyWith(
            lightBulbState: state.lightBulbState.copyWith(
          isOn: light.ison,
          intensity: light.gain,
        ));
      },
    );
  }

  Future<void> setLightColour(int colorIndex) async {
    if (colorIndex > 5) {
      return;
    }

    var effectiveColor = colorIndex;

    if (colorIndex == state.lightBulbState.colorIndex) {
      effectiveColor = 1;
    }

    // TODO: Redo this whole thin, it's a mess
    final color = switch (effectiveColor) {
      2 => colorPick1,
      3 => colorPick2,
      4 => colorPick3,
      5 => colorPick4,
      int() => null,
    };

    if (color == null) {
      return;
    }
    final light = await homeRepository.setBulbColor(color);
    light.fold(
      (exception) => null,
      (light) {
        state = state.copyWith(
          lightBulbState: state.lightBulbState.copyWith(
            colorIndex: effectiveColor,
          ),
        );
      },
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
