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
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff18181e), Color(0xff2e2e3d)],
              )
            : null,
        color: colorMode == ColorMode.solid ? const Color(0xFF1e1e26) : null,
      ),
      child: child,
    );
  }
}
