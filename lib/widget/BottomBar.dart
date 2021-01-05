import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:kane/model/KaneType.dart';
import 'package:kane/model/DeployType.dart';
import 'package:kane/model/BottomBarType.dart';
import 'package:kane/model/PlaceType.dart';

class BottomBar extends StatefulWidget {
  final Function changeKane;
  final Function clearKane;
  final Function changeBackground;
  final Function onOffDeploy;

  BottomBar(this.changeKane, this.changeBackground, this.onOffDeploy, this.clearKane);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<String> _menuImgList = [
    "kane/kane/kane0",
    "deploy/tajiri",
    "background/hanwha"
  ];
  List<String> _menuTitleList = ["인물", "배치", "장소"];

  List<String> _personImgList = [
    "kane/kane/kane0",
    "kane/ricardo/ricardo",
    "kane/sexyKane/sexyKane0",
    "kane/hanwha/hanwha000",
    "kane/moemoe/moemoe135",
    "kane/bug/bug00",
    "kane/motorcycle/motorcycle000",
    "kane/bundle/bundle00",
  ];
  List<String> _personTitleList = ["죄송케인", "케카르도", "요염케인", "최강케인", "모에케인", "바퀴퀴", "오도방구", "뭉탱이"];

  List<String> _deployImgList = [
    "deploy/tajiri",
    "deploy/kimsungkeun",
    "deploy/mushroom",
    "deploy/benz",
    "deploy/tgd"
  ];
  List<String> _deployTitleList = ["타지리", "감동님", "버섯섯", "구형벤츠", "사이트"];
  List<bool> _deployBoolList = [
    true,
    true,
    true,
    true,
    true,
  ];

  List<String> _placeImgList = [
    "background/background",
    "background/hanwha",
    "background/hall",
    "background/kof",
    "background/wwe"
  ];
  List<String> _placeTitleList = ["크로마키", "야구장", "노인회관", "킹오파", "WWE"];

  BottomBarType _bottomBarType = BottomBarType.Menu;
  List<BottomBarType> _bottomTypeList = [
    BottomBarType.Person,
    BottomBarType.Deploy,
    BottomBarType.Place
  ];
  List<KaneType> _kaneTypeList = [
    KaneType.Kane,
    KaneType.Ricardo,
    KaneType.SexyKane,
    KaneType.HanwhaKane,
    KaneType.MoemoeKane,
    KaneType.Bug,
    KaneType.Motorcycle,
    KaneType.Bundle
  ];
  List<DeployType> _deployTypeList = [
    DeployType.Tajiri,
    DeployType.Kimsungkeun,
    DeployType.Mushroom,
    DeployType.Benz,
    DeployType.Site
  ];
  List<PlaceType> _placeTypeList = [PlaceType.ChromaKey, PlaceType.BaseBall, PlaceType.Hall, PlaceType.Kof,  PlaceType.Wwe];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    
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
      case BottomBarType.Deploy:
        titleList = _deployTitleList;
        imgList = _deployImgList;
        break;
      default:
        titleList = _placeTitleList;
        imgList = _placeImgList;
    }
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      color: Colors.grey[400],
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            Column(
              children: [
                _bottomBarType != BottomBarType.Menu
                    ? _circleButton(Icons.clear, () =>
                    setState(() => _bottomBarType = BottomBarType.Menu))
                    : Container(),
                _bottomBarType == BottomBarType.Person
                    ? _circleButton(Icons.delete, () => widget.clearKane())
                    : Container(),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
            Row(
                children: List.generate(titleList.length, (index) {
              return InkWell(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(180),
                      width: ScreenUtil().setHeight(180),
                      child: Image.asset(
                        "assets/${imgList[index]}.webp",
                        height: ScreenUtil().setHeight(180),
                        width: ScreenUtil().setHeight(180),
                      ),
                      padding:
                          EdgeInsets.all(titleList[index] == "사이트" ? 16 : 0),
                    ),
                    Container(
                      child: Text(
                        titleList[index],
                        style: TextStyle(fontSize: ScreenUtil().setHeight(29)),
                      ),
                      decoration: BoxDecoration(
                          color: _bottomBarType == BottomBarType.Deploy &&
                                  _deployBoolList[index]
                              ? Colors.green[100]
                              : Colors.white,
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
                      setState(() => _bottomBarType = _bottomTypeList[index]);
                      break;
                    case BottomBarType.Person:
                      widget.changeKane(_kaneTypeList[index]);
                      setState(() => _bottomBarType = BottomBarType.Menu);
                      break;
                    case BottomBarType.Deploy:
                      widget.onOffDeploy(_deployTypeList[index]);
                      setState(() {
                        _deployBoolList[index] = !_deployBoolList[index];
                        _bottomBarType = BottomBarType.Menu;
                      });
                      break;
                    default:
                      widget.changeBackground(_placeTypeList[index]);
                      setState(() => _bottomBarType = BottomBarType.Menu);
                  }
                },
              );
            })),
          ],
        ),
      ),
    );
  }

  Widget _circleButton(IconData iconData, Function onPressed) => Container(
      width: ScreenUtil().setHeight(139),
      height: ScreenUtil().setHeight(102),
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(12, 4, 3, 3),
      child: IconButton(
        icon: Icon(iconData, size: ScreenUtil().setHeight(32),),
        onPressed: onPressed,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32.0)
      ));

}
