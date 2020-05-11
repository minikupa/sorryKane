import 'dart:math';

import 'package:flutter/material.dart';

class Tajiri extends StatefulWidget {
  @override
  _TajiriState createState() => _TajiriState();
}

class _TajiriState extends State<Tajiri> with TickerProviderStateMixin {

  double _leftPositioned = -120;
  AnimationController rotationController;

  @override
  void initState() {
    rotationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          top: 240,
          left: _leftPositioned,
          child: RotationTransition(
            turns: Tween(begin: 0.1, end: 0.0).animate(rotationController),
            child: InkWell(
              child: Image.asset(
                "assets/tajiri.webp",
                width: 200,
              ),
              onTap: () {
                setState(() {
                  _leftPositioned = 0;
                  rotationController.forward();
                });
              },
            ),
          ),
        )
      ],
    );
  }
}
