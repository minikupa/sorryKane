import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Kane extends StatefulWidget {
  final bool isRicardo;

  Kane(this.isRicardo);

  @override
  _KaneState createState() => _KaneState();
}

class _KaneState extends State<Kane> {
  int _imageCount = 1;
  int _noseCount = 0;
  bool _isHover = false;
  bool _isStop = false;

  AudioCache cache = AudioCache();
  AudioPlayer player;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return widget.isRicardo ? _ricardo() : _sorryKane();
  }

  Widget _sorryKane() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            child: Image.asset(
              "assets/kane/kane$_imageCount.webp",
              height: ScreenUtil().setHeight(800),
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
            onTap: () async {
              if (_imageCount == 1) {
                player = await cache.play('music/sorry.mp3');
                for (var i = 1; i <= 7; i++) {
                  if (widget.isRicardo ) {
                    player.stop();
                    setState(() => _imageCount = 1);
                    break;
                  }
                  await Future.delayed(const Duration(milliseconds: 50), () {
                    setState(() => _imageCount++);
                  });
                }
                for (var i = 1; i <= 7; i++) {
                  if (widget.isRicardo) {
                    player.stop();
                    setState(() => _imageCount = 1);
                    break;
                  }
                  await Future.delayed(const Duration(milliseconds: 50), () {
                    setState(() => _imageCount--);
                  });
                }
              }
            },
          ),
        ),
        _imageCount == 1
            ? Positioned(
          top: ScreenUtil().setHeight(1066),
          left: ScreenUtil().setWidth(506),
          right: ScreenUtil().setWidth(506),
          child: InkWell(
            child: _isHover
                ? ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.grey[400], BlendMode.modulate),
                child: Image.asset(
                  "assets/kane/nose.webp",
                  width: ScreenUtil().setHeight(40),
                  height: ScreenUtil().setHeight(40),
                  fit: BoxFit.contain,
                ))
                : Image.asset(
              "assets/kane/nose.webp",
              width: ScreenUtil().setHeight(40),
              height: ScreenUtil().setHeight(40),
              fit: BoxFit.contain,
            ),
            onTap: () {
              setState(() => _isHover = false);
              if (++_noseCount >= Random().nextInt(5) + 3) {
                _noseCount = 0;
                cache.play('music/igonan.m4a');
              } else {
                cache.play('music/bbolong.m4a');
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
              "assets/kane/ricardo/ricardo${_imageCount < 11
                  ? "00${_imageCount - 1}"
                  : (_imageCount < 101 ? "0${_imageCount - 1}" : _imageCount -
                  1)}.webp",
              height: ScreenUtil().setHeight(800),
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
            onTap: () async {
              if (_imageCount == 1) {
                player = await cache.play('music/ricardo.mp3');
                for (var i = 0; i <= 112; i++) {
                  if (!widget.isRicardo || _isStop) {
                    player.stop();
                    _isStop = false;
                    break;
                  }
                  await Future.delayed(const Duration(milliseconds: 125), () {
                    setState(() => _imageCount++);
                  });
                }
                setState(() => _imageCount = 1);
              } else {
                player.stop();
                setState(() => _isStop = true);
              }
            },
          ),
        )
      ],
    );
  }
}
