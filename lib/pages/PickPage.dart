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
  TextEditingController _textEditingController = TextEditingController();

  bool _isSexy = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
            child: Image.asset(
          "assets/background/background.webp",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        )),
        _isSexy
            ? PickSexy(
                isNumeric: _isNumeric,
                textEditingController: _textEditingController,
              )
            : PickCannon(
                isNumeric: _isNumeric,
                textEditingController: _textEditingController,
              ),
        Align(
          alignment: Alignment(0.0, _isSexy ? 0.7 : 0.9),
          child: Column(
            children: [
              Container(
                width: 300,
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
              Container(
                height: ScreenUtil().setHeight(100),
                child: Row(
                  children: [
                    InkWell(
                      child: Image.asset("assets/pick/sexy/pick_sexy00.webp"),
                      onTap: () => setState(() => _isSexy = true),
                    ),
                    InkWell(
                        child: Image.asset("assets/pick/pick_cannon.webp"),
                        onTap: () => setState(() => _isSexy = false)),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              )
            ],
            mainAxisSize: MainAxisSize.min,
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        )
      ],
    ));
  }

  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
}

class PickSexy extends StatefulWidget {
  final Function isNumeric;
  final TextEditingController textEditingController;

  PickSexy(
      {Key key, @required this.isNumeric, @required this.textEditingController})
      : super(key: key);

  @override
  _PickSexyState createState() => _PickSexyState();
}

class _PickSexyState extends State<PickSexy> {
  GlobalKey<ImageSequenceAnimatorState> _globalKey = GlobalKey();

  bool _isPlaying = false;
  AudioCache _cache = AudioCache();

  double _size = 0, _opacity = 0;
  int _randomNumber;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Stack(
      children: [
        InkWell(
          child: Container(
            height: ScreenUtil().setHeight(800),
            child: ImageSequenceAnimator(
              "assets/pick/sexy",
              "pick_sexy",
              0,
              2,
              "webp",
              11,
              key: _globalKey,
              fps: 15,
              isAutoPlay: false,
              color: null,
              onPlaying: (imageSequenceAnimator) {
                if (imageSequenceAnimator.currentTime >= 190 && _size == 0.0) {
                  setState(() => _size = ScreenUtil().setHeight(500));
                  Future.delayed(const Duration(milliseconds: 300), () {
                    if (mounted) {
                      setState(() => _opacity = 1);
                    }
                  });
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
            if (!_isPlaying &&
                widget.isNumeric(widget.textEditingController.text)) {
              _randomNumber = Random()
                      .nextInt(int.parse(widget.textEditingController.text)) +
                  1;
              _isPlaying = true;
              _cache.play('music/pick/spit.mp3', volume: 0.7);
              _globalKey.currentState.play();
            }
          },
        ),
        Align(
          alignment: const Alignment(0.0, -0.05),
          child: InkWell(
            onTap: () => setState(() {
              _size = 0;
              _opacity = 0;
            }),
            child: AnimatedContainer(
              width: _size,
              height: _size,
              curve: Curves.easeInCubic,
              duration: const Duration(milliseconds: 500),
              child: Stack(
                children: [
                  AnimatedOpacity(
                    opacity: _size == 0.0 ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 400),
                    child: Image.asset("assets/pick/baseball.webp"),
                  ),
                  AnimatedOpacity(
                    opacity: _opacity,
                    duration: const Duration(milliseconds: 400),
                    child: Text(
                      "${_randomNumber ?? ""}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 35.0),
                    ),
                  ),
                ],
                alignment: Alignment.center,
              ),
              onEnd: () {
                if (_size == 0.0) {
                  setState(() {
                    _isPlaying = false;
                    _randomNumber = null;
                  });
                } else if (_size == ScreenUtil().setHeight(500)) {
                  Future.delayed(const Duration(seconds: 3), () {
                    if (mounted) {
                      setState(() {
                        _size = 0;
                        _opacity = 0;
                      });
                    }
                  });
                }
              },
            ),
          ),
        ),
      ],
      alignment: Alignment.center,
    );
  }
}

class PickCannon extends StatefulWidget {
  final Function isNumeric;
  final TextEditingController textEditingController;

  PickCannon(
      {Key key, @required this.isNumeric, @required this.textEditingController})
      : super(key: key);

  @override
  _PickCannonState createState() => _PickCannonState();
}

class _PickCannonState extends State<PickCannon> {
  double _size = ScreenUtil().setHeight(250),
      _position = ScreenUtil().setHeight(600),
      _opacity = 0;
  int _randomNumber;
  bool _isNoseHover = false, _isPlaying = false;
  AudioCache _cache = AudioCache();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: _size != 250 ? 300 : 1800),
          bottom: _position,
          child: AnimatedContainer(
            width: _size,
            height: _size,
            duration: Duration(milliseconds: _size != 250 ? 300 : 1800),
            child: Stack(
              children: [
                Image.asset("assets/pick/baseball.webp"),
                AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    "${_randomNumber ?? ""}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 35.0),
                  ),
                )
              ],
              alignment: Alignment.center,
            ),
            onEnd: () {
              if (_isPlaying) {
                if (_size == ScreenUtil().setHeight(70)) {
                  setState(() {
                    _size = 250;
                    _position = ScreenUtil().setHeight(1100);
                  });
                } else {
                  Future.delayed(const Duration(seconds: 2), () {
                    if (mounted) {
                      setState(() {
                        _size = ScreenUtil().setHeight(250);
                        _position = ScreenUtil().setHeight(600);
                        _opacity = 0;
                        _isPlaying = false;
                        _isNoseHover = false;
                      });
                    }
                  });
                }
              }
            },
          ),
        ),
        Align(
          alignment: Alignment(0.0, 0.5),
          child: Stack(
            children: [
              Image.asset(
                "assets/pick/pick_cannon.webp",
                height: ScreenUtil().setHeight(400),
              ),
              InkWell(
                child: _isPlaying || _isNoseHover
                    ? ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            Colors.grey[400], BlendMode.modulate),
                        child: _nose())
                    : _nose(),
                onTap: () {
                  if (!_isPlaying &&
                      widget.isNumeric(widget.textEditingController.text)) {
                    _cache.play('music/pick/bbolong2.mp3', volume: 0.7);
                    _isPlaying = true;
                    _randomNumber = Random().nextInt(
                            int.parse(widget.textEditingController.text)) +
                        1;

                    setState(() {
                      _size = ScreenUtil().setHeight(70);
                      _position = ScreenUtil().setHeight(1500);
                    });

                    Future.delayed(
                        Duration(
                            milliseconds:
                                widget.textEditingController.text.length * 190),
                        () => setState(() => _opacity = 1));
                    Future.delayed(Duration(milliseconds: 750), () {
                      List effectSound = ["heuhehe", "nice", "reul", "see", "hanna", "ja"];
                      _cache.play(
                          'music/${effectSound[Random().nextInt(effectSound.length)]}.mp3', volume: 0.7);
                    });
                  } else {
                    setState(() => _isNoseHover = false);
                  }
                },
                onTapDown: (_) => setState(() => _isNoseHover = true),
                onTapCancel: () => setState(() => _isNoseHover = false),
              ),
            ],
            alignment: Alignment.center,
          ),
        ),
      ],
      alignment: Alignment.center,
    );
  }

  Widget _nose() => Image.asset("assets/kane/kane/nose.webp",
      height: ScreenUtil().setHeight(80), fit: BoxFit.cover);
}
