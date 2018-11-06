import 'package:flutter/material.dart';

import 'package:v2ex/widget/AvatarWidget.dart';

//import 'package:flutter_uikit/ui/widgets/about_tile.dart';
//import 'package:flutter_uikit/utils/uidata.dart';

class CommonDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _header(context),
//          Divider(),
          new ListTile(
            title: Text(
              "节点",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              Icons.person,
              color: Colors.blue,
            ),
          ),
          new ListTile(
            title: Text(
              "收藏",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              Icons.favorite,
              color: Colors.green,
            ),
          ),
          new ListTile(
            title: Text(
              "关注",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              Icons.dashboard,
              color: Colors.red,
            ),
          ),
          new ListTile(
            title: Text(
              "消息",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              Icons.message,
              color: Colors.cyan,
            ),
          ),
          Divider(),
          new ListTile(
            title: Text(
              "设置",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              Icons.settings,
              color: Colors.brown,
            ),
          ),
          Divider(),
//          MyAboutTile()
        ],
      ),
    );
  }

  _header(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: 170.0,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AvatarWidget("", width: 65.0, height: 65.0),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Text(
                    "mansoul",
                    style: TextStyle(color: Colors.black87, fontSize: 15.0),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Text("签到")
            ],
          ),
        ),
      ),
    );
  }
}
