import 'package:flutter/material.dart';

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