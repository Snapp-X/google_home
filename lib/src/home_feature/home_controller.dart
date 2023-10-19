import 'package:google_home/src/home_feature/home_repository.dart';
import 'package:google_home/src/home_feature/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeValuesProvider =
    StateNotifierProvider<HomeValuesNotifier, HomeValues>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);

  return HomeValuesNotifier(homeRepository: homeRepository);
});

class HomeValuesNotifier extends StateNotifier<HomeValues> {
  HomeValuesNotifier({required this.homeRepository})
      : super(const HomeValues()) {
    _init();
  }

  final HomeRepository homeRepository;

  void _init() {
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
      tv: true,
      formattedTime: '01:20 AM',
      formattedDate: 'Thu, Oct 9 2023',
      airQuality: 'POOR',
      temperature: '18.2°',
      humidity: '43.3%',
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
