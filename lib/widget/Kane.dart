import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Kane extends StatefulWidget {
  @override
  _KaneState createState() => _KaneState();
}

class _KaneState extends State<Kane> {
  int _imageCount = 1;
  int _noseCount = 0;
  bool _isHover = false;

  AudioCache player = AudioCache();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            child: Image.asset(
              "assets/kane/kane$_imageCount.webp",
              height: ScreenUtil().setHeight(1000),
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
            onTap: () async {
              if (_imageCount == 1) {
                for (var i = 1; i <= 7; i++) {
                  await Future.delayed(const Duration(milliseconds: 50), () {
                    setState(() => _imageCount++);
                  });
                }
                for (var i = 1; i <= 7; i++) {
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
                top: ScreenUtil().setHeight(1065),
                left: ScreenUtil().setWidth(506),
                right: ScreenUtil().setWidth(506),
                child: InkWell(
                  child: _isHover
                      ? ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.grey[400], BlendMode.modulate),
                          child: Image.asset(
                            "assets/kane/nose.webp",
                            width: ScreenUtil().setHeight(50),
                            height: ScreenUtil().setHeight(50),
                            fit: BoxFit.contain,
                          ))
                      : Image.asset(
                          "assets/kane/nose.webp",
                          width: ScreenUtil().setHeight(50),
                          height: ScreenUtil().setHeight(50),
                          fit: BoxFit.contain,
                        ),
                  onTap: () {
                    setState(() => _isHover = false);
                    if (++_noseCount >= Random().nextInt(5) + 3) {
                      _noseCount = 0;
                      player.play('music/igonan.m4a');
                    } else {
                      player.play('music/bbolong.m4a');
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
}
