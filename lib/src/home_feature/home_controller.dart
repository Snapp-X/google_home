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

  void toggleTv() {}

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
