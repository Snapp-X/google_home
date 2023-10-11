import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    return const HomeContainer(
      height: double.infinity,
      colorMode: ColorMode.gradient,
      borderRadius: 20,
    );
  }
}

class LightCard extends StatelessWidget {
  const LightCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const HomeContainer(
      borderRadius: 20,
    );
  }
}

class PowerCard extends StatelessWidget {
  const PowerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const HomeContainer(
      borderRadius: 20,
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
