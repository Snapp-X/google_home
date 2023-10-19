import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_home/src/core/styles/responsive.dart';
import 'package:google_home/src/home_feature/home_controller.dart';
import 'package:google_home/src/home_feature/home_state.dart';
import 'package:google_home/src/home_feature/widget/color_picker.dart';
import 'package:google_home/src/home_feature/widget/common.dart';
import 'package:google_home/src/home_feature/widget/lamp.dart';
import 'package:google_home/src/home_feature/widget/weather_animation.dart';

class WeatherCard extends ConsumerWidget {
  const WeatherCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState =
        ref.watch(homeValuesProvider.select((value) => value.todayWeather));
    final weekWeather =
        ref.watch(homeValuesProvider.select((value) => value.weekWeather));

    final time =
        ref.watch(homeValuesProvider.select((value) => value.formattedTime));

    final date =
        ref.watch(homeValuesProvider.select((value) => value.formattedDate));

    return GestureDetector(
      onTap: ref.read(homeValuesProvider.notifier).rotateWeatherType,
      child: HomeContainer(
        height: double.infinity,
        colorMode: ColorMode.gradient,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        borderRadius: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap.vertical(2),
            Text(
              'WEATHER',
              style: context.titleTextStyle,
            ),
            const Gap.vertical(8),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: ref.read(homeValuesProvider.notifier).rotateWeatherType,
                child: const WeatherAnimation(),
              ),
            ),
            const Gap.vertical(8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    weatherState?.temperature ?? '',
                    style: context.headerTextStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    '${weatherState?.weatherType.name ?? ''}\n${weatherState?.city ?? ''}',
                    style: context.subtitleTextStyle,
                  ),
                ),
              ],
            ),
            if (weatherState != null) ...[
              const Gap.vertical(12),
              DayWeatherDetail(
                dayTemperature: weatherState.dayTemperature,
                weatherType: weatherState.weatherType,
              ),
              if (weekWeather.isNotEmpty)
                ...weekWeather
                    .map(
                      (day) => DayWeatherDetail(
                        dayTemperature: day.dayTemperature,
                        weatherType: day.weatherType,
                      ),
                    )
                    .toList()
            ],
            const Spacer(),
            Text(
              time,
              style: context.headerTextStyle,
            ),
            Text(
              date,
              style: context.subHeaderTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class DayWeatherDetail extends StatelessWidget {
  const DayWeatherDetail({
    super.key,
    required this.weatherType,
    required this.dayTemperature,
  });

  final WeatherType weatherType;
  final DayTemperature dayTemperature;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Today',
              style: context.subtitleTextStyle,
            ),
          ),
          Icon(
            switch (weatherType) {
              WeatherType.sunny => Icons.sunny,
              WeatherType.partiallySunny => Icons.sunny_snowing,
              WeatherType.cloudy => Icons.wb_cloudy,
              WeatherType.rainy => Icons.cloudy_snowing,
            },
            size: 14,
          ),
          const Gap.horizontal(20),
          Text(
            '${dayTemperature.min}°',
            style: context.subtitleTextStyle,
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: 5,
              margin: const EdgeInsets.only(left: 12, right: 8),
              child: LayoutBuilder(builder: (context, constraints) {
                final left = convertRange(
                  dayTemperature.min,
                  dayTemperature.max,
                  0,
                  constraints.maxWidth,
                  dayTemperature.possibleMin,
                );

                final right = convertRange(
                  dayTemperature.min,
                  dayTemperature.max,
                  0,
                  constraints.maxWidth,
                  dayTemperature.possibleMax,
                );

                return Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: ShapeDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      left: left,
                      right: constraints.maxWidth - right,
                      child: Container(
                        height: 5,
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              Color(0xFFD4CE55),
                              Color(0xFFE99F4A),
                              Color(0xFFE57753)
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          Text(
            '${dayTemperature.max}°',
            style: context.subtitleTextStyle,
          ),
        ],
      ),
    );
  }

  double convertRange(
    double originalStart,
    double originalEnd,
    double newStart,
    double newEnd,
    double value,
  ) {
    double scale = (newEnd - newStart) / (originalEnd - originalStart);
    return (newStart + ((value - originalStart) * scale));
  }
}

class LightCard extends ConsumerWidget {
  const LightCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lightState =
        ref.watch(homeValuesProvider.select((value) => value.lightBulbState));

    return HomeContainer(
      borderRadius: 20,
      child: Row(
        children: [
          const Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Lamp(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'LIGHT',
                        style: context.titleTextStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Transform.scale(
                          scale: context.switchScale,
                          child: Switch(
                            value: lightState.isOn,
                            onChanged: (value) {
                              ref
                                  .read(homeValuesProvider.notifier)
                                  .toggleLightBulb();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(flex: 2),

                  /// Row with 4 equal square container
                  const ColorPicker(),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: SliderTheme(
                      data: Theme.of(context).sliderTheme.copyWith(
                            trackHeight: context.sliderTrackerHeight,
                          ),
                      child: Slider(
                        value: lightState.intensity,
                        min: 0,
                        max: 100,
                        onChanged: (newValue) {},
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PowerCard extends StatelessWidget {
  const PowerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return HomeContainer(
      borderRadius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'POWER CONSUMPTION KWH',
              style: context.titleTextStyle,
            ),
          ),
          Expanded(
            child: PowerChart(
              selectedColor: theme.colorScheme.secondary,
              unselectedColor: theme.colorScheme.primaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

class SwitchesRow extends ConsumerWidget {
  const SwitchesRow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tv = ref.watch(homeValuesProvider.select((value) => value.tv));
    final stereo =
        ref.watch(homeValuesProvider.select((value) => value.stereo));
    final thermostat =
        ref.watch(homeValuesProvider.select((value) => value.thermostat));
    final fan = ref.watch(homeValuesProvider.select((value) => value.fan));

    return Row(
      children: [
        Expanded(
          child: SwitchCard(
            enabled: tv,
            onChanged: (value) {},
            title: "LIVING ROOM",
            value: "TV",
          ),
        ),
        Gap.horizontal(context.homeItemsGap),
        Expanded(
          child: SwitchCard(
            enabled: stereo,
            onChanged: (value) {},
            title: "LIVING ROOM",
            value: "STEREO",
          ),
        ),
        Gap.horizontal(context.homeItemsGap),
        Expanded(
          child: SwitchCard(
            enabled: thermostat,
            onChanged: (value) {},
            title: "LIVING ROOM",
            value: "THERMOSTAT",
          ),
        ),
        Gap.horizontal(context.homeItemsGap),
        Expanded(
          child: SwitchCard(
            enabled: fan,
            onChanged: (value) {},
            title: "LIVING ROOM",
            value: "FAN",
          ),
        ),
      ],
    );
  }
}

class SwitchCard extends StatelessWidget {
  const SwitchCard({
    super.key,
    required this.enabled,
    this.onChanged,
    required this.title,
    required this.value,
  });

  final bool enabled;
  final ValueChanged<bool>? onChanged;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return HomeContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 16),
              child: Transform.scale(
                scale: context.switchScale,
                child: Switch(
                  value: enabled,
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              title,
              style: context.subtitleTextStyle,
            ),
          ),
          const Gap.vertical(2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              value,
              style: context.biggerTitleTextStyle,
            ),
          ),
          const Gap.vertical(16),
        ],
      ),
    );
  }
}

class AirRelatedRow extends ConsumerWidget {
  const AirRelatedRow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final airQuality =
        ref.watch(homeValuesProvider.select((value) => value.airQuality));
    final temperature =
        ref.watch(homeValuesProvider.select((value) => value.temperature));
    final humidity =
        ref.watch(homeValuesProvider.select((value) => value.humidity));

    return Row(
      children: [
        Expanded(
          child: AirRelatedCard(
            title: "AIR QUALITY",
            value: airQuality.toUpperCase(),
          ),
        ),
        Gap.horizontal(context.homeItemsGap),
        Expanded(
          child: AirRelatedCard(
            title: "TEMPERATURE",
            value: temperature.toUpperCase(),
          ),
        ),
        Gap.horizontal(context.homeItemsGap),
        Expanded(
          child: AirRelatedCard(
            title: "HUMIDITY",
            value: humidity.toUpperCase(),
          ),
        ),
      ],
    );
  }
}

class AirRelatedCard extends StatelessWidget {
  const AirRelatedCard({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return HomeContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.subtitleTextStyle,
          ),
          const Gap.vertical(2),
          Text(
            value,
            style: context.biggerTitleTextStyle,
          ),
        ],
      ),
    );
  }
}

class PowerChart extends StatefulWidget {
  const PowerChart({
    super.key,
    required this.selectedColor,
    required this.unselectedColor,
  });

  final Color selectedColor;
  final Color unselectedColor;

  @override
  State<StatefulWidget> createState() => PowerChartState();
}

class PowerChartState extends State<PowerChart> {
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 150);
    final barGroup2 = makeGroupData(1, 140);
    final barGroup3 = makeGroupData(2, 160);
    final barGroup4 = makeGroupData(3, 200);
    final barGroup5 = makeGroupData(4, 90);
    final barGroup6 = makeGroupData(5, 100);
    final barGroup7 = makeGroupData(6, 100);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: 250,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.red,
            getTooltipItem: (a, b, c, d) => null,
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: bottomTitles,
              reservedSize: 42,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              interval: 1,
              getTitlesWidget: leftTitles,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: showingBarGroups,
        gridData: const FlGridData(show: false),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    final style = context.chartTextStyle;

    String text;

    if (value % 50 == 0) {
      text = value.toInt().toString();
    } else {
      return const SizedBox.shrink();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

    final Widget text = Text(
      titles[value.toInt()],
      style: context.chartTextStyle,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1) {
    final selected = DateTime.now().weekday == (x + 1);
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: selected ? widget.selectedColor : widget.unselectedColor,
          width: 15,
        ),
      ],
    );
  }
}
