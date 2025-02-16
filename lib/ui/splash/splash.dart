import 'dart:async';

import 'package:draw_flawless/ui/drawing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}


class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp){
      /// After 10 seconf push to next screen
      Timer(Duration(seconds: 5),(){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                DrawingScreen()
            )
        );
      });
    });
  }

  Widget build(BuildContext context) {
    return Container(
    color: Colors.white,
    alignment: Alignment.center,
    child:Image.asset('assets/images/drawflawless.png',height: 100,width: 100,)
    );
  }
}
