
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draw_flawless/model/drawingPoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

final drawingController = ChangeNotifierProvider<DrawingController>((ref)=>DrawingController());

class DrawingController extends ChangeNotifier{

  /// Instance of the firebase store
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController controller = TextEditingController();

  /// Generate the unique session id
  String sessionId ='';

  updateSessionId({String? value})
  {
    sessionId = value??(Random().nextInt(9000) + 1000).toString();
    notifyListeners();
  }
  /// List of the points
  List<DrawingPoint> points=[];


  /// Stores the currently selected color
  Color currentColor = Colors.black;

  /// Store the current stroke size
  double strokeSize = 5.0;

  /// Change the size of the stroke
  changeStroke(double value)
  {
    strokeSize= value;
    notifyListeners();
  }


  /// Function will change the current color
   changeColor(Color value)
  {
    currentColor = value;
    notifyListeners();
  }

  /// Drawing Poing Model

  void listenForFirestoreUpdates() {
    _firestore.collection("drawings").doc(sessionId).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        final Map<String, dynamic> pointsData = snapshot["points"];
        print('pointsData $pointsData');
            // print('pointsData.elementAt(i)["points"] ${pointsData.elementAt(i)["points"]}');
        points.add(DrawingPoint.fromMap(
                dx: pointsData["dx"],
                dy: pointsData["dy"],
                color: pointsData["color"],
                strokeWidth: pointsData["strokeWidth"]));

        print("points $points");

      }
      else
        {
          print("snapshot data is empty");
        }
      notifyListeners();
    });
  }
/*
  void listenForFirestoreUpdates() {
    _firestore.collection("drawings").snapshots().listen((snapshot) {
      print('snapshot  $snapshot');
      print('snapshot  ${snapshot.runtimeType}');

      if (snapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> doc = snapshot.docs
            .map((doc) => doc.data()) // ✅ Extract data safely
            .toList();
        // final doc = snapshot.docs.first as Map<String,dynamic>;
         print('docdoc  ${doc}');
         final List<Map<String, dynamic>> pointsData = doc;
         print('pointData $pointsData');
         for(int i=0;i<pointsData.length;i++)
           {
             final element = pointsData.elementAt(i)["points"];
             print('pointsData.elementAt(i)["points"] ${pointsData.elementAt(i)["points"]}');
             points.add(DrawingPoint.fromMap(
                 dx: element["dx"],
                 dy: element["dy"],
                 color: element["color"],
                 strokeWidth: element["strokeWidth"]));
           }
         // points = pointsData.map((p) => DrawingPoint.fromMap(p)).toList();
         print('point $points');
      }
      else{
        print("snapshot data is empty");
      }
    });
    notifyListeners();
  }
*/


  /// Function to add the data points
  void addPoint(DrawingPoint point) {
    print("add session id $sessionId");
    points.add(point);
    notifyListeners();
    _firestore.collection("drawings").doc(sessionId).set({
      "points": point.toMap()
    }, SetOptions(merge: true));
  }

  /// Function for clearing the data
  void clearDrawing() {
    points.clear();
    notifyListeners();
    _firestore.collection("drawings").doc(sessionId).delete();
  }

}