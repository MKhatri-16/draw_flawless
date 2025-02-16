import 'package:flutter/material.dart';

 showJoinRoomDialog(
    {required BuildContext context,
      required String? roomId,
      required VoidCallback? onPressed,
      required TextEditingController controller
    })  {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Join Room"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Your Room ID $roomId"),
            SizedBox(height: 5),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              maxLength: 5,
              decoration: InputDecoration(hintText: "Enter Friends Room Id"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed:onPressed,
            child: Text("Join"),
          ),
        ],
      );
    },
  );
}
