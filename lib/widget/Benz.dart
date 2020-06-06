import 'dart:math';

import 'package:flutter/material.dart';

class Benz extends StatefulWidget {
  Benz({Key key}) : super(key: key);

  @override
  BenzState createState() => BenzState();
}

class BenzState extends State<Benz> {
  bool _isOn = true;
  bool _isAppear = false;

  @override
  void initState() {
    _randomAppear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedPositioned(
          left: _isAppear ? -100 : 500,
          top: 70,
          duration: Duration(milliseconds:_isAppear ? 5000 : 1),
          child: Column(
            children: <Widget>[
              Text("구형벤츠"),
              Image.asset(
                "assets/deploy/benz.webp",
                width: 100,
                fit: BoxFit.cover,
              )
            ],
            mainAxisSize: MainAxisSize.min,
          ),
          onEnd: () => setState(() => _isAppear = false),
        )
      ],
    );
  }

  _randomAppear() async {
    while (true) {
      if(_isOn) {
        await Future.delayed(Duration(seconds: Random().nextInt(30) + 10),
                () => setState(() => _isAppear = true));
      }
    }
  }

  onOffLocation() {
    setState(() {
      _isOn = !_isOn;
      _isAppear = _isOn;
    });
  }
}
