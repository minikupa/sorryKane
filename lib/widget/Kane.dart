import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';
import 'package:kane/model/KaneType.dart';

class Kane extends StatefulWidget {
  Kane({Key key}) : super(key: key);

  @override
  KaneState createState() => KaneState();
}

class KaneState extends State<Kane> {
  int _noseCount = 0;
  bool _isHover = false;
  bool _isPlaying = false;
  KaneType _kaneType = KaneType.Kane;
  List<GlobalKey<ImageSequenceAnimatorState>> animatorKeyList = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey()
  ];

  AudioCache _cache = AudioCache();
  AudioPlayer _player;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    Widget kane;
    switch (_kaneType) {
      case KaneType.Kane:
        kane = _kaneAnimation("kane", 8, 15, animatorKeyList[0], true);
        break;
      case KaneType.Ricardo:
        kane = _kaneAnimation("ricardo", 212, 15, animatorKeyList[1], false);
        break;
      case KaneType.SexyKane:
        kane = _kaneAnimation("sexyKane", 9, 15, animatorKeyList[2], true);
        break;
      case KaneType.MoemoeKane:
        kane = _kaneAnimation("moemoe", 137, 24, animatorKeyList[3], false);
        break;
      default:
        kane = _kaneAnimation("hanwha", 203, 24, animatorKeyList[4], false);
    }

    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: ScreenUtil().setHeight(800),
            child: kane,
          ),
        ),
        _kaneType == KaneType.Kane && !_isPlaying
            ? Positioned(
                top: ScreenUtil().setHeight(918),
                left: ScreenUtil().setWidth(506),
                right: ScreenUtil().setWidth(506),
                child: InkWell(
                  child: _isHover
                      ? ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.grey[400], BlendMode.modulate),
                          child: Image.asset(
                            "assets/kane/kane/nose.webp",
                            width: ScreenUtil().setHeight(40),
                            height: ScreenUtil().setHeight(40),
                            fit: BoxFit.contain,
                          ))
                      : Image.asset(
                          "assets/kane/kane/nose.webp",
                          width: ScreenUtil().setHeight(40),
                          height: ScreenUtil().setHeight(40),
                          fit: BoxFit.contain,
                        ),
                  onTap: () {
                    setState(() => _isHover = false);
                    if (++_noseCount >= Random().nextInt(5) + 3) {
                      _noseCount = 0;
                      _cache.play('music/igonan.m4a');
                    } else {
                      _cache.play('music/bbolong.mp3');
                    }
                  },
                  onTapDown: (_) => setState(() => _isHover = true),
                  onTapCancel: () => setState(() => _isHover = false),
                ),
              )
            : Container()
      ],
    );
  }

  Widget _kaneAnimation(String name, double frameCount, double fps,
      GlobalKey<ImageSequenceAnimatorState> key, bool rewind) {
    bool first = true;
    return InkWell(
      child: ImageSequenceAnimator(
        "assets/kane/$name",
        "$name",
        0,
        frameCount.toString().length - 2,
        "webp",
        frameCount,
        key: key,
        fps: fps,
        isAutoPlay: false,
        color: null,
        onFinishPlaying: (animator) {
          if (rewind && first) {
            key.currentState.rewind();
            first = false;
          } else {
            setState(() {
              _isPlaying = false;
              first = true;
            });
            key.currentState.reset();
          }
        },
      ),
      onTap: () async {
        if (!_isPlaying) {
          setState(() {
            _isPlaying = true;
          });
          _player = await _cache.play('music/$name.mp3');
          key.currentState.play();
        } else {
          setState(() {
            _isPlaying = false;
            first = true;
          });
          _player.stop();
          key.currentState.reset();
        }
      },
    );
  }

  changeKane(KaneType kaneType) {
    setState(() => _kaneType = kaneType);
  }
}