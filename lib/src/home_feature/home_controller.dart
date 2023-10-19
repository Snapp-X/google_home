import 'dart:async';

import 'package:dbus/dbus.dart';
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
      _updateCO2Sensor();
      _updateDateTime();
    });
    _init();
  }

  @override
  void dispose() {
    dbusClient.close();
    super.dispose();
  }

  final HomeRepository homeRepository;
  late final DBusClient dbusClient;
  late final DBusRemoteObject dBusRemoteObject;

  void _init() {
    //init the dbus client and remote object
    dbusClient = DBusClient.session();
    dBusRemoteObject = DBusRemoteObject(dbusClient,
        name: 'de.snapp.CoSensorService', path: DBusObjectPath('/Sensor'));

    state = state.copyWith(
      todayWeather: const WeatherState(
        temperature: '18.2°',
        weatherType: WeatherType.rainy,
        city: 'London',
      ),
      tv: true,
    );
  }

  void _updateDateTime() {
    state = state.copyWith(
      todayWeather: const WeatherState(
        temperature: '18.2°',
        weatherType: WeatherType.rainy,
        city: 'London',
      ),
      tv: true,
      formattedTime: '01:20 AM',
      formattedDate: 'Thu, Oct 9 2023',
    );
  }

  Future<void> _updateCO2Sensor() async {
    final response = await dBusRemoteObject.callMethod(
        'de.snapp.SensorInterface', 'GetSensorValue', [],
        replySignature: DBusSignature('sa'));

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
}
