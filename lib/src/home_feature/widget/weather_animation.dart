import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_home/src/home_feature/home_controller.dart';
import 'package:google_home/src/home_feature/home_state.dart';
import 'package:rive/rive.dart';

final weatherRiveProvider = FutureProvider<RiveFile>((ref) async {
  final data = await rootBundle.load('assets/rive/weather.riv');

  final riveFile = RiveFile.import(data);

  return riveFile;
});

class WeatherAnimation extends ConsumerWidget {
  const WeatherAnimation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherFile = ref.watch(weatherRiveProvider);

    final weather = ref.watch(
      homeValuesProvider.select((value) => value.todayWeather),
    );

    return weatherFile.maybeWhen(
      data: (data) {
        return RiveAnimation.direct(
          data,
          artboard: 'weather',
          animations: [
            weatherTypeToAnimationName(
                weather?.weatherType ?? WeatherType.sunny),
          ],
          fit: BoxFit.cover,
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }

  String weatherTypeToAnimationName(WeatherType type) {
    return switch (type) {
      WeatherType.sunny => 'Sunny',
      WeatherType.partiallySunny => 'Partially Cloudy',
      WeatherType.cloudy => 'Cloudy',
      WeatherType.rainy => 'Rainy',
    };
  }
}
