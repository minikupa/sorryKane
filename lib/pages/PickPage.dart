import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';

class PickPage extends StatefulWidget {
  @override
  _PickPageState createState() => _PickPageState();
}

class _PickPageState extends State<PickPage> {
  GlobalKey<ImageSequenceAnimatorState> _globalKey = GlobalKey();

  bool _isPlaying = false;

  AudioCache _cache = AudioCache();

  TextEditingController _textEditingController = TextEditingController();

  double _size = 0;
  int _randomNumber;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
                child: Image.asset(
              "assets/background/background.webp",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            )),
            Center(
              child: InkWell(
                child: Container(
                  height: ScreenUtil().setHeight(800),
                  child: ImageSequenceAnimator(
                    "assets/pick/sexy",
                    "pick_sexy",
                    0,
                    2,
                    "webp",
                    29,
                    key: _globalKey,
                    fps: 24,
                    isAutoPlay: false,
                    color: null,
                    onPlaying: (imageSequenceAnimator) {
                      if (imageSequenceAnimator.currentTime >= 250 &&
                          _size == 0.0) {
                        setState(() => _size = 200);
                      }
                    },
                    onFinishPlaying: (animator) async {
                      if (_globalKey.currentState != null) {
                        _globalKey.currentState.restart();
                        _globalKey.currentState.pause();
                      }
                    },
                  ),
                ),
                onTap: () async {
                  if (!_isPlaying && isNumeric(_textEditingController.text)) {
                    _randomNumber = Random()
                            .nextInt(int.parse(_textEditingController.text)) +
                        1;
                    _isPlaying = true;
                    _cache.play('music/pick_sexy.mp3');
                    _globalKey.currentState.play();
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment(0.0, -0.05),
              child: AnimatedContainer(
                width: _size,
                height: _size,
                curve: Curves.easeInCubic,
                duration: Duration(milliseconds: 500),
                child: AnimatedOpacity(
                  opacity: _size == 0.0 ? 0.0 : 1.0,
                  duration: Duration(milliseconds: 400),
                  child: Stack(
                    children: [
                      Image.asset("assets/pick/baseball.webp"),
                      Text(
                        "${_randomNumber ?? ""}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 35.0),
                      )
                    ],
                    alignment: Alignment.center,
                  ),
                ),
                onEnd: () {
                  if (_size == 0.0) {
                    setState(() {
                      _isPlaying = false;
                      _randomNumber = null;
                    });
                  } else {
                    Future.delayed(Duration(seconds: 3),
                        () => setState(() => _size = 0.0));
                  }
                },
              ),
            ),
            Center(
              child: Container(
                width: 300,
                alignment: Alignment(0.0, 0.6),
                child: TextField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.number,
                  maxLength: 7,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: "최대 숫자를 입력하라 맨이야"),
                ),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
}
