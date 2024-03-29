import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';
import 'package:kane/model/KaneType.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class Kane extends StatefulWidget {
  final KaneType kaneType;
  final int index;
  final Function deleteKane;

  Kane(
      {Key key,
      @required this.kaneType,
      @required this.index,
      @required this.deleteKane})
      : super(key: key);

  @override
  KaneState createState() => KaneState();
}

class KaneState extends State<Kane> with WidgetsBindingObserver {
  Matrix4 _matrix = Matrix4.identity();
  int _noseCount = 0, _noseSize = 0;
  bool _isHover = false, _isNoseHover = false, _isPlaying = false;
  KaneType _kaneType;
  GlobalKey<ImageSequenceAnimatorState> _globalKey = GlobalKey();

  AudioCache _cache = AudioCache();
  AudioPlayer _player;

  @override
  void initState() {
    _kaneType = widget.kaneType ?? KaneType.Kane;
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_player != null) {
      _player.stop();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused && _player != null) {
      setState(() {
        _isPlaying = false;

        _player.stop();
        _globalKey.currentState.restart();
        _globalKey.currentState.pause();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    Widget kane;
    switch (_kaneType) {
      case KaneType.Kane:
        kane = _kaneAnimation("kane", 8, 19, true);
        break;
      case KaneType.Ricardo:
        kane = _kaneAnimation("ricardo", 212, 15, false);
        break;
      case KaneType.SexyKane:
        kane = _kaneAnimation("sexyKane", 9, 15, true);
        break;
      case KaneType.MoemoeKane:
        kane = _kaneAnimation("moemoe", 84, 15, false);
        break;
      case KaneType.HanwhaKane:
        kane = _kaneAnimation("hanwha", 115, 15, false);
        break;
      case KaneType.Bug:
        kane = _kaneAnimation("bug", 55, 15, false);
        break;
      case KaneType.Motorcycle:
        kane = _kaneAnimation("motorcycle", 190, 24, false);
        break;
      case KaneType.Bundle:
        kane = _kaneAnimation("bundle", 37, 24, false);
        break;
    }

    if (_kaneType == KaneType.Kane && Random().nextInt(8) == 0) {
      kane = _kaneAnimation("kane", 8, 19, true, "no_sorry");
    }

    return MatrixGestureDetector(
      shouldRotate: false,
      onMatrixUpdate: (m, tm, sm, rm) => setState(() => _matrix = m),
      child: Transform(
        transform: _matrix,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: ScreenUtil().setHeight(700),
                child: Stack(
                  children: [
                    kane,
                    _kaneType == KaneType.Kane && !_isPlaying
                        ? Align(
                            alignment: Alignment(0.0, -0.69),
                            child: InkWell(
                              child: _isNoseHover
                                  ? ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          Colors.grey[400], BlendMode.modulate),
                                      child: _nose())
                                  : _nose(),
                              onTap: () {
                                _noseSize += 3;
                                bool isMax = Random().nextInt(11) == 0;
                                if (!isMax) {
                                  if (++_noseCount >= Random().nextInt(5) + 3) {
                                    _noseCount = 0;
                                    _cache.play(
                                        'music/kane/igonan${Random().nextInt(4) + 1}.mp3', volume: 0.7);
                                  } else {
                                    _cache.play('music/kane/bbolong.mp3', volume: 0.7);
                                  }
                                }
                                setState(() {
                                  _isNoseHover = false;
                                  if (isMax) {
                                    _noseSize = 0;
                                    _cache.play('music/kane/pop.mp3', volume: 0.7);
                                  }
                                });
                              },
                              onTapDown: (_) =>
                                  setState(() => _isNoseHover = true),
                              onTapCancel: () =>
                                  setState(() => _isNoseHover = false),
                            ),
                          )
                        : Container(),
                    _isHover
                        ? Align(
                            alignment: Alignment(0.2, -1.0),
                            child: InkWell(
                                child: Container(
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all()),
                                  child: Icon(Icons.delete),
                                ),
                                onTap: () {
                                  int random = Random().nextInt(8);
                                  if (random == 0) {
                                    _cache.play('music/kane/dont_run.mp3', volume: 0.7);
                                  } else if (random == 1) {
                                    _cache.play('music/kane/ac_badman.mp3', volume: 0.7);
                                  }
                                  widget.deleteKane(widget.index);
                                }),
                          )
                        : Container(),
                  ],
                  alignment: Alignment.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nose() => Image.asset(
        "assets/kane/kane/nose.webp",
        width: ScreenUtil().setHeight(40 + _noseSize),
        height: ScreenUtil().setHeight(40 + _noseSize),
        fit: BoxFit.contain,
      );

  Widget _kaneAnimation(String name, double frameCount, double fps, bool rewind,
      [String mp3Name]) {
    bool first = true;
    return Container(
      height: ScreenUtil().setHeight(700),
      child: InkWell(
        child: ImageSequenceAnimator(
          "assets/kane/$name",
          "$name",
          0,
          frameCount.toInt().toString().length,
          "webp",
          frameCount,
          key: _globalKey,
          fps: fps,
          isAutoPlay: false,
          color: null,
          onFinishPlaying: (animator) async {
            if (_globalKey.currentState != null) {
              if (rewind && first) {
                _globalKey.currentState.rewind();
                first = false;
              } else {
                setState(() {
                  _isPlaying = false;
                  first = true;
                });
                _globalKey.currentState.restart();
                _globalKey.currentState.pause();
              }
            }
          },
        ),
        onTap: () async {
          if (!_isPlaying) {
            setState(() => _isPlaying = true);
            _player = await _cache.play('music/kane/${mp3Name ?? name}.mp3', volume: 0.7);
            _globalKey.currentState.play();
            if (mp3Name != null) {
              for (int i = 0; i < 11; i++) {
                if (_isPlaying) {
                  await Future.delayed(Duration(milliseconds: 50),
                      () => _globalKey.currentState.pause());
                  await Future.delayed(Duration(milliseconds: 15),
                      () => _globalKey.currentState.play());
                } else {
                  break;
                }
              }
            }
          } else {
            setState(() {
              _isPlaying = false;
              first = true;

              _player.stop();
              _globalKey.currentState.restart();
              _globalKey.currentState.pause();
            });
          }
        },
        onLongPress: () {
          setState(() => _isHover = true);
          Future.delayed(Duration(milliseconds: 1500), () {
            if (mounted) {
              setState(() => _isHover = false);
            }
          });
        },
      ),
    );
  }
}
