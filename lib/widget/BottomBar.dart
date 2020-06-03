import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final Function changeKane;

  BottomBar(this.changeKane);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<String> _imgList = ["kane/kane1", "tajiri", "pear"];
  List<String> _titleList = ["인물", "배치", "아이템"];

  List<String> _personImgList = ["kane/kane1", "kane/ricardo/ricardo000"];
  List<String> _personTitleList = ["죄송케인", "케카르도"];

  bool _isPerson = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      child: Row(
        children: List.generate(
            _isPerson ? 2 : 3,
            (index) => Container(
                  width: _isPerson ? 130 : 110,
                  child: RaisedButton(
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/${_isPerson ? _personImgList[index] : _imgList[index]}.webp",
                          height: 30,
                          width: 30,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(_isPerson
                              ? _personTitleList[index]
                              : _titleList[index]),
                        )
                      ],
                      mainAxisSize: MainAxisSize.min,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      if (index == 0) {
                        if (_isPerson) {
                          widget.changeKane(false);
                          setState(() {
                            _isPerson = false;
                          });
                        } else {
                          setState(() {
                            _isPerson = true;
                          });
                        }
                      } else if (index == 1) {
                        if (_isPerson) {
                          widget.changeKane(true);
                          setState(() {
                            _isPerson = false;
                          });
                        }
                      }
                    },
                  ),
                )),
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}
