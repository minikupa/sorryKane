import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'widget/Hanwha.dart';
import 'widget/Tajiri.dart';

import 'widget/Kane.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned.fill(child: Image.asset(
              "assets/background.webp",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            )),
            Kane(),
            Hanwha(),
            Tajiri(),
            Align(
              alignment: Alignment(-1.0, 1.05),
              child: Image.asset(
                "assets/mushroom.webp",
                width: 70,
                fit: BoxFit.cover,
              ),
            )
          ],
        ));
  }
}
