import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

enum ColorMode { gradient, solid }

class HomeContainer extends StatelessWidget {
  const HomeContainer({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 15,
    this.colorMode = ColorMode.solid,
    this.child,
    this.color,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  });

  final double? width;
  final double? height;
  final double borderRadius;
  final ColorMode colorMode;
  final Color? color;
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
        color: colorMode == ColorMode.solid
            ? color ?? const Color(0xFF1e1e26)
            : null,
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
                  '18.2°',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Moderate rain\nLondon',
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
          Spacer(),
          Text(
            '01:20 AM',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Text(
            'Thu, Oct 9 2023',
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

class LightCard extends StatelessWidget {
  const LightCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                          value: true,
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
                        value: .5,
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

class RoundedDeepSliderTrackShape extends SliderTrackShape {
  const RoundedDeepSliderTrackShape();

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    // If the slider [SliderThemeData.trackHeight] is less than or equal to 0,
    // then it makes no difference whether the track is painted or not,
    // therefore the painting can be a no-op.
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }

    final thumbSize = sliderTheme.thumbShape!.getPreferredSize(true, false);

    // Assign the track segment paints, which are leading: active and
    // trailing: inactive.
    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: sliderTheme.inactiveTrackColor);
    final Paint activePaint = Paint()
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    final Paint leftTrackPaint;
    final Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Radius activeTrackRadius =
        Radius.circular((trackRect.height + additionalActiveTrackHeight) / 2);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left - (additionalActiveTrackHeight / 2),
        trackRect.top - (additionalActiveTrackHeight / 2),
        trackRect.right + (additionalActiveTrackHeight / 2),
        trackRect.bottom + (additionalActiveTrackHeight / 2),
        topRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        topLeft: (textDirection == TextDirection.rtl)
            ? trackRadius
            : activeTrackRadius,
        bottomLeft: (textDirection == TextDirection.rtl)
            ? trackRadius
            : activeTrackRadius,
      ),
      rightTrackPaint,
    );

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        trackRect.top,
        thumbCenter.dx +
            (thumbSize.longestSide / 2) +
            additionalActiveTrackHeight,
        trackRect.bottom,
        topLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        topRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
      ),
      leftTrackPaint,
    );

    final bool showSecondaryTrack = (secondaryOffset != null) &&
        ((textDirection == TextDirection.ltr)
            ? (secondaryOffset.dx > thumbCenter.dx)
            : (secondaryOffset.dx < thumbCenter.dx));

    if (showSecondaryTrack) {
      final ColorTween secondaryTrackColorTween = ColorTween(
          begin: sliderTheme.disabledSecondaryActiveTrackColor,
          end: sliderTheme.secondaryActiveTrackColor);
      final Paint secondaryTrackPaint = Paint()
        ..color = secondaryTrackColorTween.evaluate(enableAnimation)!;
      if (textDirection == TextDirection.ltr) {
        context.canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            thumbCenter.dx,
            trackRect.top,
            secondaryOffset.dx,
            trackRect.bottom,
            topRight: trackRadius,
            bottomRight: trackRadius,
          ),
          secondaryTrackPaint,
        );
      } else {
        context.canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            secondaryOffset.dx,
            trackRect.top,
            thumbCenter.dx,
            trackRect.bottom,
            topLeft: trackRadius,
            bottomLeft: trackRadius,
          ),
          secondaryTrackPaint,
        );
      }
    }
  }

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double overlayWidth =
        sliderTheme.overlayShape!.getPreferredSize(isEnabled, isDiscrete).width;
    final double trackHeight = sliderTheme.trackHeight!;
    assert(overlayWidth >= 0);
    assert(trackHeight >= 0);

    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackRight = parentBox.size.width;
    final double trackBottom = trackTop + trackHeight;
    // If the parentBox'size less than slider's size the trackRight will be less than trackLeft, so switch them.
    return Rect.fromLTRB(math.min(trackLeft, trackRight), trackTop,
        math.max(trackLeft, trackRight), trackBottom);
  }
}

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    super.key,
    this.selectedColor,
    this.onChange,
  });

  final Color? selectedColor;
  final ValueChanged<Color>? onChange;

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: ColorPickerItem(
            color: Color(0xff709CEE),
          ),
        ),
        Expanded(
          child: ColorPickerItem(
            color: Color(0xff716EEC),
          ),
        ),
        Expanded(
          child: ColorPickerItem(
            color: Color(0xffEA4F47),
            isSelected: true,
          ),
        ),
        Expanded(
          child: ColorPickerItem(
            color: Color(0xffE57656),
          ),
        ),
      ],
    );
  }
}

class ColorPickerItem extends StatelessWidget {
  const ColorPickerItem({
    super.key,
    required this.color,
    this.isSelected = false,
  });

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: isSelected ? EdgeInsets.zero : const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(
                  color: Colors.black45,
                  width: 4,
                )
              : null,
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
