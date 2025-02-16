import 'package:draw_flawless/controller/drawing_controller.dart';
import 'package:draw_flawless/ui/color_picker.dart';
import 'package:draw_flawless/ui/drawing_board.dart';
import 'package:draw_flawless/ui/enter_room_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawingScreen extends ConsumerWidget {
  const DrawingScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final drawingWatch = ref.watch(drawingController);
    return Scaffold(
      appBar: AppBar(title: Text("Lets Draw!!",textAlign: TextAlign.center,),
      actions: [
        InkWell(
          onTap: ()
          {
            showJoinRoomDialog(
              context: context,
              controller: drawingWatch.controller,
              roomId:drawingWatch.sessionId,
                  onPressed: (){
              if(drawingWatch.controller.text.isNotEmpty)
                {
                  print('updating session is controller');
                  drawingWatch.updateSessionId(value: drawingWatch.controller.text);
                }
              drawingWatch.listenForFirestoreUpdates();
              Navigator.of(context).pop();
            },);
          },
          child:Text("JOIN ROOM") ,
        )
      ],),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Card(
                      child: DrawingBoard()),
                ),
                Positioned(
                  top: 0,
                  right: 10,
                    child: IconButton(onPressed: (){
                  ref.watch(drawingController).clearDrawing();
                }, icon:Container(
                      padding: EdgeInsets.all(5),
                        child: Icon(Icons.clear),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black)
                    ),))),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton(
                    child:Container(
                      decoration: BoxDecoration(
                        color: drawingWatch.currentColor,
                        shape: BoxShape.circle
                      ),
                      ),
                    onPressed: (){
                      customColorPicker(
                        context: context,
                        onColorChanged: (Color value) { drawingWatch.changeColor(value); },
                        color:drawingWatch.currentColor ,);
                      },
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: (){
                drawingWatch.changeStroke(4.0);
              }, child: Container(height: 3,width: 30,color: drawingWatch.currentColor,)),
              SizedBox(width: 10,),
              ElevatedButton(
              onPressed: (){
                drawingWatch.changeStroke(10.0);
              }, child: Container(height: 5,width: 30,color: drawingWatch.currentColor,)),
              SizedBox(width: 10,),
              ElevatedButton(onPressed: (){
                drawingWatch.changeStroke(20.0);
              }, child:Container(height:9,width: 34,color: drawingWatch.currentColor,))
            ],
          ),
        ],
      ),
    );
  }
}
