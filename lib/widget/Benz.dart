import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:kane/widget/DeployAbstract.dart';

class Benz extends StatefulWidget {
  Benz({Key key}) : super(key: key);

  @override
  BenzState createState() => BenzState();
}

class BenzState extends State<Benz> implements DeployAbstract{
  bool isOn = true;
  bool _isAppear = false;

  @override
  void initState() {
    _randomAppear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Stack(
      children: <Widget>[
        AnimatedPositioned(
          left: _isAppear ? -100 : ScreenUtil().setWidth(1200),
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
      if(isOn) {
        await Future.delayed(Duration(seconds: Random().nextInt(30) + 10),
                () => setState(() => _isAppear = true));
      }
    }
  }

  onOffLocation() {
    setState(() {
      isOn = !isOn;
      _isAppear = isOn;
    });
  }
}
