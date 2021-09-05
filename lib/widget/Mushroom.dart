import 'package:flutter/material.dart';
import 'package:kane/widget/DeployAbstract.dart';

class Mushroom extends StatefulWidget{
  Mushroom({Key key}) : super(key: key);

  @override
  MushroomState createState() => MushroomState();
}

class MushroomState extends State<Mushroom>  implements DeployAbstract {
  bool isOn = true;

  @override
  Widget build(BuildContext context) {
    return isOn
        ? Stack(
            children: <Widget>[
              Align(
                alignment: Alignment(-1.0, 1.0),
                child: Image.asset(
                  "assets/deploy/mushroom.webp",
                  width: 70,
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : Container();
  }

  onOffLocation() {
    setState(() {
      isOn = !isOn;
    });
  }
}
