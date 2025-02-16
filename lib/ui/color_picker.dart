import 'package:draw_flawless/controller/drawing_controller.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

customColorPicker(
    {
      required final BuildContext context,
      required final ValueChanged<Color> onColorChanged,
      required final Color color}) {
  return ColorPicker(
      color: color,
      onColorChanged: onColorChanged,
    heading: Text('Select a Color'),
  ).showPickerDialog(context);
}
