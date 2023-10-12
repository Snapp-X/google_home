import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_home/src/home_feature/home_controller.dart';
import 'package:google_home/src/home_feature/home_view.dart';
import 'package:google_home/src/home_feature/widget/color_picker.dart';
import 'package:google_home/src/home_feature/widget/common.dart';
import 'package:google_home/src/home_feature/widget/slider.dart';

class WetherCard extends ConsumerWidget {
  const WetherCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final weatherState =
        ref.watch(homeValuesProvider.select((value) => value.todayWeather));

    final time =
        ref.watch(homeValuesProvider.select((value) => value.formattedTime));

    final date =
        ref.watch(homeValuesProvider.select((value) => value.formattedDate));

    return HomeContainer(
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
            style: theme.textTheme.labelSmall?.copyWith(
              height: 1.2,
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const Gap.vertical(8),
          const HomeContainer(
            height: 150,
            width: double.infinity,
            color: Colors.white12,
          ),
          const Gap.vertical(8),
          Row(
            children: [
              Expanded(
                child: Text(
                  weatherState?.temperature ?? '',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '${weatherState?.weatherType.name ?? ''}\n${weatherState?.city ?? ''}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    color:
                        Theme.of(context).colorScheme.onSurface.withOpacity(.5),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            time,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Text(
            date,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
            ),
          ),
        ],
      ),
    );
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

    final theme = Theme.of(context);
    return HomeContainer(
      borderRadius: 20,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset('assets/images/lamp.png'),
                ),
                // TODO(payam): add animation for light
              ],
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
                        style: theme.textTheme.labelSmall?.copyWith(
                          height: 1.2,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Transform.scale(
                        scale: .6,
                        child: Switch(
                          value: lightState.isOn,
                          onChanged: (value) {},
                          activeColor: const Color(0xFF381E72),
                          activeTrackColor: const Color(0xFF5771C1),
                          inactiveThumbColor: const Color(0xFF18181E),
                          inactiveTrackColor: const Color(0xFF2F2F3E),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(flex: 2),

                  /// Row with 4 equal square container
                  const ColorPicker(),
                  const Spacer(),
                  SliderTheme(
                    data: const SliderThemeData(
                      trackHeight: 14,
                      inactiveTrackColor: Color(0xff2F2F3E),
                      activeTrackColor: Color(0xff5771C1),
                      trackShape: RoundedDeepSliderTrackShape(),
                      thumbColor: Color(0xff393760),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 6,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Slider(
                        value: lightState.intensity,
                        min: 0,
                        max: 100,
                        onChanged: (newValue) {},
                      ),
                    ),
                  ),
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
              style: theme.textTheme.labelSmall?.copyWith(
                height: 1.2,
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          const Expanded(child: PowerChart()),
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
        const Gap.horizontal(homeItemsGap),
        Expanded(
          child: SwitchCard(
            enabled: stereo,
            onChanged: (value) {},
            title: "LIVING ROOM",
            value: "STEREO",
          ),
        ),
        const Gap.horizontal(homeItemsGap),
        Expanded(
          child: SwitchCard(
            enabled: thermostat,
            onChanged: (value) {},
            title: "LIVING ROOM",
            value: "THERMOSTAT",
          ),
        ),
        const Gap.horizontal(homeItemsGap),
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
    final theme = Theme.of(context);

    return HomeContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Transform.scale(
              scale: .6,
              child: Switch(
                value: enabled,
                onChanged: onChanged,
                activeColor: const Color(0xFF381E72),
                activeTrackColor: const Color(0xFF5771C1),
                inactiveThumbColor: const Color(0xFF18181E),
                inactiveTrackColor: const Color(0xFF2F2F3E),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.2,
                fontSize: 8,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
              ),
            ),
          ),
          const Gap.vertical(2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              value,
              style: theme.textTheme.labelSmall?.copyWith(
                height: 1.2,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
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
        const Gap.horizontal(homeItemsGap),
        Expanded(
          child: AirRelatedCard(
            title: "TEMPERATURE",
            value: temperature.toUpperCase(),
          ),
        ),
        const Gap.horizontal(homeItemsGap),
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
    final theme = Theme.of(context);

    return HomeContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.2,
              fontSize: 8,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
            ),
          ),
          const Gap.vertical(2),
          Text(
            value,
            style: theme.textTheme.labelSmall?.copyWith(
              height: 1.2,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class PowerChart extends StatefulWidget {
  const PowerChart({super.key});

  @override
  State<StatefulWidget> createState() => PowerChartState();
}

class PowerChartState extends State<PowerChart> {
  final double width = 10;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  final selectedColor = const Color(0xff5771C1);
  final defaultColor = const Color(0xff2F2F3E);

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
              reservedSize: 28,
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
    const style = TextStyle(
      color: Color(0x7fFFFFFF),
      fontWeight: FontWeight.w400,
      fontSize: 7,
    );
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
      style: const TextStyle(
        color: Color(0x7fFFFFFF),
        fontWeight: FontWeight.w400,
        fontSize: 7,
      ),
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
          color: selected ? selectedColor : defaultColor,
          width: width,
        ),
      ],
    );
  }
}
