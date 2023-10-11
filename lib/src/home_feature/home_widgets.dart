import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

enum ColorMode { gradient, solid }

class HomeContainer extends StatelessWidget {
  const HomeContainer({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 15,
    this.colorMode = ColorMode.solid,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.child,
  });

  final double? width;
  final double? height;
  final double borderRadius;
  final ColorMode colorMode;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: colorMode == ColorMode.gradient
            ? const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0x7f18181e),
                  Color(0x7f2a2a37),
                ],
              )
            : null,
        color: colorMode == ColorMode.solid ? const Color(0xFF1e1e26) : null,
      ),
      child: child,
    );
  }
}

/// Gap between items in a list.
class Gap extends StatelessWidget {
  const Gap._({
    super.key,
    this.width,
    this.height,
  });

  const Gap.horizontal(
    double width, {
    Key? key,
  }) : this._(key: key, width: width);

  const Gap.vertical(
    double height, {
    Key? key,
  }) : this._(key: key, height: height);

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height);
  }
}

class WetherCard extends StatelessWidget {
  const WetherCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return HomeContainer(
      height: double.infinity,
      colorMode: ColorMode.gradient,
      borderRadius: 20,
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'WEATHER',
            style: theme.textTheme.labelSmall?.copyWith(
              height: 1.2,
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

class LightCard extends StatelessWidget {
  const LightCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return HomeContainer(
      borderRadius: 20,
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            'LIGHT',
            style: theme.textTheme.labelSmall?.copyWith(
              height: 1.2,
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
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
