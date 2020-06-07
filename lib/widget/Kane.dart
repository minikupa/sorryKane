import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kane/Model/KaneType.dart';

class Kane extends StatefulWidget {

  Kane({Key key}) : super(key : key);

  @override
  KaneState createState() => KaneState();
}

class KaneState extends State<Kane> {
  int _imageCount = 1;
  int _noseCount = 0;
  bool _isHover = false;
  bool _isStop = false;
  KaneType _kaneType = KaneType.Kane;

  AudioCache _cache = AudioCache();
  AudioPlayer _player;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    switch (_kaneType) {
      case KaneType.Kane:
        return _sorryKane();
      case KaneType.Ricardo:
        return _ricardo();
      case KaneType.SexyKane:
        return _sexyKane();
      default:
        return _hanwhaKane();
    }
  }

  Widget _sorryKane() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            child: Image.asset(
              "assets/kane/kane/kane$_imageCount.webp",
              height: ScreenUtil().setHeight(800),
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
            onTap: () async {
              if (_imageCount == 1) {
                _player = await _cache.play('music/sorry.mp3', volume: 3.0);
                for (int i = 0; i < 2; i++) {
                  for (int j = 1; j <= 7; j++) {
                    if (_kaneType != KaneType.Kane) {
                      _player.stop();
                      setState(() => _imageCount = 1);
                      break;
                    }
                    await Future.delayed(const Duration(milliseconds: 50), () {
                      setState(() {
                        if (i == 0) {
                          _imageCount++;
                        } else {
                          _imageCount--;
                        }
                      });
                    });
                  }
                }
              }
            },
          ),
        ),
        _imageCount == 1
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

  Widget _ricardo() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            child: Image.asset(
              "assets/kane/ricardo/ricardo${_imageCount < 11 ? "00${_imageCount - 1}" : (_imageCount < 101 ? "0${_imageCount - 1}" : _imageCount - 1)}.webp",
              height: ScreenUtil().setHeight(800),
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
            onTap: () async {
              if (_imageCount == 1) {
                _player = await _cache.play('music/ricardo.mp3');
                for (int i = 0; i <= 211; i++) {
                  if (_kaneType != KaneType.Ricardo || _isStop) {
                    _player.stop();
                    _isStop = false;
                    break;
                  }
                  await Future.delayed(const Duration(milliseconds: 66), () {
                    setState(() => _imageCount++);
                  });
                }
                setState(() => _imageCount = 1);
              } else {
                _player.stop();
                setState(() => _isStop = true);
              }
            },
          ),
        )
      ],
    );
  }

  Widget _sexyKane() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            child: Image.asset(
              "assets/kane/sexyKane/sexyKane0${_imageCount - 1}.webp",
              height: ScreenUtil().setHeight(800),
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
            onTap: () async {
              if (_imageCount == 1) {
                _player = await _cache.play('music/sexyKane.mp3');
                for (int i = 0; i < 2; i++) {
                  for (int j = 1; j <= 7; j++) {
                    if (_kaneType != KaneType.SexyKane) {
                      setState(() => _imageCount = 1);
                      _player.stop();
                      break;
                    }
                    await Future.delayed(const Duration(milliseconds: 66), () {
                      setState(() {
                        if (i == 0) {
                          _imageCount++;
                        } else {
                          _imageCount--;
                        }
                      });
                    });
                  }
                }
              }
            },
          ),
        )
      ],
    );
  }

  Widget _hanwhaKane() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            child: Image.asset(
              "assets/kane/hanwha/hanwha${_imageCount > 10 ? _imageCount - 1 : "0${_imageCount - 1}"}.webp",
              height: ScreenUtil().setHeight(800),
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
            onTap: () async {
              if (_imageCount == 1) {
                _player = await _cache.play('music/hanwha.mp3');
                for (int j = 1; j <= 61; j++) {
                  if (_kaneType != KaneType.HanwhaKane || _isStop) {
                    _isStop = false;
                    _player.stop();
                    break;
                  }
                  await Future.delayed(const Duration(milliseconds: 125), () {
                    setState(() => _imageCount++);
                  });
                }
                setState(() => _imageCount = 1);
              } else {
                _player.stop();
                setState(() => _isStop = true);
              }
            },
          ),
        )
      ],
    );
  }

  changeKane(KaneType kaneType) {
    setState(() => _kaneType = kaneType);
  }

}
