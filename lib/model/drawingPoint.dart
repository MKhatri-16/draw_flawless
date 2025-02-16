import 'package:flutter/material.dart';

class DrawingPoint {
  final Offset offset;
  final Paint paint;

  DrawingPoint({required this.offset, required this.paint});

  Map<String, dynamic> toMap() {
    return {
      "dx": offset.dx,
      "dy": offset.dy,
      "color": paint.color.value,
      "strokeWidth": paint.strokeWidth,
    };
  }

  static DrawingPoint fromMap(
      {required double dx,
        required double dy,
        required int color,
        required double strokeWidth}) {
    return DrawingPoint(
      offset: Offset(dx??0,dy??0),
      paint: Paint()
        ..color = Color(color??4278190080)
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }
}
