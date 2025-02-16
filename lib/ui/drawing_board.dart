import 'package:draw_flawless/controller/drawing_controller.dart';
import 'package:draw_flawless/model/drawingPoint.dart';
import 'package:draw_flawless/ui/draw_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawingBoard extends ConsumerStatefulWidget{
  const DrawingBoard({super.key});

  @override
  ConsumerState<DrawingBoard> createState() => _DrawingBoardState();
}
class _DrawingBoardState extends ConsumerState<DrawingBoard> {

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp){
      final drawingRead = ref.read(drawingController);
       drawingRead.updateSessionId();
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final drawingWWatch = ref.watch(drawingController);
    return GestureDetector(
      onPanUpdate: (details) {
        drawingWWatch.addPoint(DrawingPoint(
          offset: details.localPosition,
          paint: Paint()
            ..color = drawingWWatch.currentColor
            ..strokeWidth = drawingWWatch.strokeSize
            ..strokeCap = StrokeCap.butt
          ..strokeJoin = StrokeJoin.round,
        ));
      },
      child: CustomPaint(
        size: Size.infinite,
        painter: DrawPainter( points: drawingWWatch.points, strokeSize: drawingWWatch.strokeSize),
      ),
    );
  }
}
