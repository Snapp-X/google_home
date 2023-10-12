import 'package:flutter/material.dart';

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
