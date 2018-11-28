import 'package:flutter/material.dart';
import 'package:v2ex/utils/NavigatorUtils.dart';
import 'package:v2ex/widget/AvatarWidget.dart';

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
              Icons.apps,
              color: Colors.blue,
            ),
            onTap: () {
              NavigatorUtils.toNodeCategory(context);
            },
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
              Icons.people,
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
                  AvatarWidget(
                    "",
                    onPress: () {
                      NavigatorUtils.toLogin(context);
                    },
                    width: 65.0,
                    height: 65.0,
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Text(
                    "",
                    style: TextStyle(color: Colors.black87, fontSize: 15.0),
                  ),
                ],
              ),
              Expanded(child: Container()),
//              Text("签到")
            ],
          ),
        ),
      ),
    );
  }
}
