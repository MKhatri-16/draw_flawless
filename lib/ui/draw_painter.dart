import 'package:draw_flawless/model/drawingPoint.dart';
import 'package:flutter/material.dart';

class DrawPainter extends CustomPainter{
    List<DrawingPoint> points;
    double strokeSize;

    DrawPainter({required this.points,required this.strokeSize});

  @override
  void paint(Canvas canvas, Size size) {
        for (var point in points) {
          canvas.drawCircle(point.offset,strokeSize, point.paint);
        }
  }

    @override
  bool shouldRepaint(DrawPainter oldDelegate) => true;
}