import 'package:flutter/material.dart';
import 'package:kane/Model/BottomBarType.dart';
import 'package:kane/Model/KaneType.dart';

class BottomBar extends StatefulWidget {
  final Function changeKane;

  BottomBar(this.changeKane);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<String> _imgList = ["kane/kane1", "tajiri", "pear"];
  List<String> _titleList = ["인물", "배치", "아이템"];

  List<String> _personImgList = ["kane/kane1", "kane/ricardo/ricardo000", "kane/sexyKane/sexyKane00"];
  List<String> _personTitleList = ["죄송케인", "케카르도", "요염케인"];

  BottomBarType _bottomBarType = BottomBarType.Menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
              3,
              (index) => Container(
                    width: 140,
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            "assets/${_bottomBarType == BottomBarType.Person ? _personImgList[index] : _imgList[index]}.webp",
                            height: 30,
                            width: 30,
                            fit: BoxFit.contain,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(_bottomBarType == BottomBarType.Person
                                ? _personTitleList[index]
                                : _titleList[index]),
                          )
                        ],
                        mainAxisSize: MainAxisSize.min,
                      ),
                      color: Colors.white,
                      onPressed: () {
                        if (index == 0) {
                          if (_bottomBarType == BottomBarType.Person) {
                            widget.changeKane(KaneType.Kane);
                            setState(() => _bottomBarType = BottomBarType.Menu);
                          } else {
                            setState(() => _bottomBarType = BottomBarType.Person);
                          }
                        } else if (index == 1) {
                          if (_bottomBarType == BottomBarType.Person) {
                            widget.changeKane(KaneType.Ricardo);
                            setState(() => _bottomBarType = BottomBarType.Menu);
                          }
                        } else if (index == 2){
                          if (_bottomBarType == BottomBarType.Person) {
                            widget.changeKane(KaneType.SexyKane);
                            setState(() => _bottomBarType = BottomBarType.Menu);
                          }
                        }
                      },
                    ),
                  )),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ),
    );
  }
}
