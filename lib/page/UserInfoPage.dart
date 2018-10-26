import 'package:flutter/material.dart';

import 'package:v2ex/utils/HtmlParseUtil.dart';
import 'package:v2ex/entity/Member.dart';
import 'package:v2ex/net/V2EXManager.dart';
import 'package:v2ex/entity/UserInfo.dart';
import 'package:v2ex/entity/Topic.dart';
import 'package:v2ex/widget/UserInfoItemWidget.dart';

class UserInfoPage extends StatefulWidget {
  Member member;
  UserInfo userInfo;

  UserInfoPage(this.member);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class _UserInfoPageState extends State<UserInfoPage> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  final double _appBarHeight = 256.0;

  ///顶部tabbar
  _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: _appBarHeight,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
//          color: Colors.red,
            ),
        centerTitle: false,
        background: _buildUserInfo(),
      ),
    );
  }

  _buildUserInfo() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          height: _appBarHeight,
          color: Colors.green,
        ),
        // This gradient ensures that the toolbar icons are distinct
        // against the background image.
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.0, -1.0),
              end: Alignment(0.0, -0.4),
              colors: <Color>[Color(0x60000000), Color(0x00000000)],
            ),
          ),
        ),
      ],
    );
  }

  _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              UserInfoItemWidget(widget.userInfo.topics[index], widget.member),
              Divider(height: 1.0),
            ],
          );
        },
        childCount: widget.userInfo.topics.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(),
          _buildSliverList(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    ///初始化用户信息
    widget.userInfo = UserInfo();
    widget.userInfo.topics = List();
    widget.userInfo.member = widget.member;
    getData();
  }

  void getData() {
    V2EXManager.getUserInfo(
      widget.member.username,
      (data) {
        var htmlParseUtil = HtmlParseUtil();
        //解析用户信息也
        UserInfo tempUserInfo =
            htmlParseUtil.parseUserInfo(data, userInfo: widget.userInfo);
        print(widget.member.joinDes);
        setState(() {
          widget.userInfo = tempUserInfo;
        });
      },
    );
  }
}
