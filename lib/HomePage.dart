import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kane/widget/Hanwha.dart';
import 'package:kane/widget/Tajiri.dart';

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
              "assets/background.jpg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            )),
            Kane(),
            Hanwha(),
            Tajiri()
          ],
        ));
  }
}
