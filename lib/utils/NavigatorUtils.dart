import 'package:flutter/material.dart';
import 'package:v2ex/entity/Member.dart';
import 'package:v2ex/page/NodeInfoPage.dart';
import 'package:v2ex/page/TopicDetailPage.dart';
import 'package:v2ex/page/UserInfoPage.dart';

class NavigatorUtils {
  ///个人中心
  static toUserInfo(BuildContext context, Member member) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new UserInfoPage(member)));
  }

  ///节点页
  static toNodeInfo(BuildContext context, String nodeName, String nodeTitle) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new NodeInfoPage(nodeName, nodeTitle)));
  }

  ///topic
  static toTopicDetail(BuildContext context, int topicId) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new TopicDetailPage(topicId)));
  }
}
