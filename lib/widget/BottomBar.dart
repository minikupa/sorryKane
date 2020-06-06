import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kane/Model/BottomBarType.dart';
import 'package:kane/Model/KaneType.dart';
import 'package:kane/Model/DeployType.dart';

class BottomBar extends StatefulWidget {
  final Function changeKane;
  final Function onOffLocation;

  BottomBar(this.changeKane, this.onOffLocation);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<String> _menuImgList = [
    "kane/kane/kane1",
    "deploy/tajiri",
    "deploy/pear"
  ];
  List<String> _menuTitleList = ["인물", "배치", "아이템"];

  List<String> _personImgList = [
    "kane/kane/kane1",
    "kane/ricardo/ricardo",
    "kane/sexyKane/sexyKane00",
    "kane/hanwha/hanwha00",
  ];
  List<String> _personTitleList = ["죄송케인", "케카르도", "요염케인", "최강케인"];

  List<String> _deployImgList = [
    "deploy/tajiri",
    "deploy/kimsungkeun",
    "deploy/mushroom",
    "deploy/benz",
    "deploy/tgd"
  ];
  List<String> _deployTitleList = ["타지리", "감동님", "버섯섯", "구형벤츠", "사이트"];

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
        titleList = _deployTitleList;
        imgList = _deployImgList;
    }
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      color: Colors.grey[400],
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            _bottomBarType != BottomBarType.Menu
                ? Container(
                    width: 60,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: RaisedButton(
                      child: Text(
                        "X",
                        style: TextStyle(fontSize: 10.0),
                      ),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      onPressed: () =>
                          setState(() => _bottomBarType = BottomBarType.Menu),
                    ))
                : Container(),
            Row(
                children: List.generate(titleList.length, (index) {
              return InkWell(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 70,
                      width: 70,
                      child: Image.asset(
                        "assets/${imgList[index]}.webp",
                        height: 70,
                        width: 70,
                      ),
                      padding: EdgeInsets.all(titleList[index] == "사이트" ? 16 : 0),
                    ),
                    Container(
                      child: Text(
                        titleList[index],
                        style: TextStyle(fontSize: 12.0),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0)),
                      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    )
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
                onTap: () {
                  switch (_bottomBarType) {
                    case BottomBarType.Menu:
                      switch (index) {
                        case 0:
                          setState(() => _bottomBarType = BottomBarType.Person);
                          break;
                        case 1:
                          setState(
                              () => _bottomBarType = BottomBarType.Location);
                          break;
                      }
                      break;
                    case BottomBarType.Person:
                      switch (index) {
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
                      switch (index) {
                        case 0:
                          widget.onOffLocation(DeployType.Tajiri);
                          break;
                        case 1:
                          widget.onOffLocation(DeployType.Kimsungkeun);
                          break;
                        case 2:
                          widget.onOffLocation(DeployType.Mushroom);
                          break;
                        case 3:
                          widget.onOffLocation(DeployType.Benz);
                          break;
                        case 4:
                          widget.onOffLocation(DeployType.Site);
                          break;
                      }
                      setState(() => _bottomBarType = BottomBarType.Menu);
                      break;
                  }
                },
              );
            })),
          ],
        ),
      ),
    );
  }
}
