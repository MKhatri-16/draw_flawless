import 'dart:convert';

DrawingPoints drawingPointsFromJson(String str) => DrawingPoints.fromJson(json.decode(str));

String drawingPointsToJson(DrawingPoints data) => json.encode(data.toJson());

class DrawingPoints {
  Points? points;

  DrawingPoints({
    this.points,
  });

  factory DrawingPoints.fromJson(Map<String, dynamic> json) => DrawingPoints(
    points: json["points"] == null ? null : Points.fromJson(json["points"]),
  );

  Map<String, dynamic> toJson() => {
    "points": points?.toJson(),
  };
}

class Points {
  int? strokeWidth;
  int? color;
  double? dx;
  double? dy;

  Points({
    this.strokeWidth,
    this.color,
    this.dx,
    this.dy,
  });

  factory Points.fromJson(Map<String, dynamic> json) => Points(
    strokeWidth: json["strokeWidth"],
    color: json["color"],
    dx: json["dx"]?.toDouble(),
    dy: json["dy"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "strokeWidth": strokeWidth,
    "color": color,
    "dx": dx,
    "dy": dy,
  };
}
