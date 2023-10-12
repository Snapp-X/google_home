import 'package:google_home/src/home_feature/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeValuesProvider =
    StateNotifierProvider<HomeValuesNotifier, HomeValues>((ref) {
  return HomeValuesNotifier();
});

class HomeValuesNotifier extends StateNotifier<HomeValues> {
  HomeValuesNotifier() : super(const HomeValues()) {
    _init();
  }

  void _init() {
    state = state.copyWith(
      todayWeather: const WeatherState(
        temperature: '18°',
        weatherType: WeatherType.rainy,
        city: 'London',
      ),
      tv: true,
      formattedTime: '01:20 AM',
      formattedDate: 'Thu, Oct 9 2023',
      airQuality: 'POOR',
      temperature: '18.2°',
      humidity: '43.3%',
    );
  }
}
