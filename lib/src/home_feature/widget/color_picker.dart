import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_home/src/core/styles/responsive.dart';
import 'package:google_home/src/home_feature/home_controller.dart';

class ColorPicker extends ConsumerWidget {
  const ColorPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lightState =
        ref.watch(homeValuesProvider.select((value) => value.lightBulbState));

    final isActive = lightState.isOn;

    return Row(
      children: [
        Expanded(
          child: ColorPickerItem(
            color: const Color(0xff709CEE),
            isSelected: isActive && lightState.color == 2,
            onTap: () {
              ref.read(homeValuesProvider.notifier).changeLightColour(2);
            },
          ),
        ),
        Expanded(
          child: ColorPickerItem(
            color: const Color(0xff716EEC),
            isSelected: isActive && lightState.color == 3,
            onTap: () {
              ref.read(homeValuesProvider.notifier).changeLightColour(3);
            },
          ),
        ),
        Expanded(
          child: ColorPickerItem(
            color: const Color(0xffEA4F47),
            isSelected: isActive && lightState.color == 4,
            onTap: () {
              ref.read(homeValuesProvider.notifier).changeLightColour(4);
            },
          ),
        ),
        Expanded(
          child: ColorPickerItem(
            color: const Color(0xffE57656),
            isSelected: isActive && lightState.color == 5,
            onTap: () {
              ref.read(homeValuesProvider.notifier).changeLightColour(5);
            },
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
    this.onTap,
  });

  final Color color;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          margin: isSelected
              ? EdgeInsets.zero
              : EdgeInsets.all(context.colorPickerItemBorder),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: isSelected
                ? Border.all(
                    color: Colors.black45,
                    width: context.colorPickerItemBorder,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
