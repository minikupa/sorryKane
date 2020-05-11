import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

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
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            child: Image.asset(
              "assets/kane$_imageCount.webp",
              height: 400,
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
            ? Align(
                alignment: Alignment(0.020, 0.134),
                child: InkWell(
                  child: _isHover
                      ? ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.grey[400], BlendMode.modulate),
                          child: Image.asset(
                            "assets/nose.webp",
                            width: 27,
                          ))
                      : Image.asset(
                          "assets/nose.webp",
                          width: 27,
                        ),
                  onTap: () {
                    setState(() => _isHover = false);
                    if (++_noseCount >= Random().nextInt(5) + 3) {
                      _noseCount = 0;
                      player.play('igonan.m4a');
                    } else {
                      player.play('bbolong.m4a');
                    }
                  },
                  onTapDown: (_) => setState(() => _isHover = true),
                  onTapCancel: () => setState(() => _isHover = false),
                ))
            : Container()
      ],
    );
  }
}
