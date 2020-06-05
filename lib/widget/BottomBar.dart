import 'package:flutter/material.dart';
import 'package:kane/Model/BottomBarType.dart';
import 'package:kane/Model/KaneType.dart';
import 'package:kane/Model/LocationType.dart';

class BottomBar extends StatefulWidget {
  final Function changeKane;
  final Function onOffLocation;

  BottomBar(this.changeKane, this.onOffLocation);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<String> _menuImgList = ["kane/kane1", "tajiri", "pear"];
  List<String> _menuTitleList = ["인물", "배치", "아이템"];

  List<String> _personImgList = [
    "kane/kane1",
    "kane/ricardo/ricardo000",
    "kane/sexyKane/sexyKane00",
    "kane/hanwha/hanwha00",
  ];
  List<String> _personTitleList = ["죄송케인", "케카르도", "요염케인", "최강케인"];

  List<String> _locationImgList = ["tajiri", "kimsungkeun"];
  List<String> _locationTitleList = ["타지리", "감동님"];

  BottomBarType _bottomBarType = BottomBarType.Menu;

  @override
  Widget build(BuildContext context) {
    List titleList, imgList;
    switch (_bottomBarType) {
      case BottomBarType.Menu:
        titleList = _menuTitleList;
        imgList = _menuImgList;
        break;
      case BottomBarType.Person:
        titleList = _personTitleList;
        imgList = _personImgList;
        break;
      default:
        titleList = _locationTitleList;
        imgList = _locationImgList;
    }
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      color: Colors.grey[400],
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(titleList.length + 1, (index) {
            if (index == 0) {
              return _bottomBarType != BottomBarType.Menu ? Container(
                  width: 60,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text("X"),
                    color: Colors.white,
                    onPressed: () => setState(() => _bottomBarType = BottomBarType.Menu),
                  )) : Container();
            } else {
              return Container(
                width: 140,
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/${imgList[index - 1]}.webp",
                        height: 30,
                        width: 30,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(titleList[index - 1]),
                      )
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    switch (_bottomBarType) {
                      case BottomBarType.Menu:
                        switch (index - 1) {
                          case 0:
                            setState(
                                () => _bottomBarType = BottomBarType.Person);
                            break;
                          case 1:
                            setState(
                                () => _bottomBarType = BottomBarType.Location);
                            break;
                        }
                        break;
                      case BottomBarType.Person:
                        switch (index - 1) {
                          case 0:
                            widget.changeKane(KaneType.Kane);
                            break;
                          case 1:
                            widget.changeKane(KaneType.Ricardo);
                            break;
                          case 2:
                            widget.changeKane(KaneType.SexyKane);
                            break;
                          case 3:
                            widget.changeKane(KaneType.HanwhaKane);
                            break;
                        }
                        setState(() => _bottomBarType = BottomBarType.Menu);
                        break;
                      case BottomBarType.Location:
                        switch (index - 1) {
                          case 0:
                            widget.onOffLocation(LocationType.Tajiri);
                            break;
                          case 1:
                            widget.onOffLocation(LocationType.Kimsungkeun);
                            break;
                        }
                        setState(() => _bottomBarType = BottomBarType.Menu);
                        break;
                    }
                  },
                ),
              );
            }
          }),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ),
    );
  }
}
