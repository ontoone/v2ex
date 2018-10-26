import 'package:flutter/material.dart';

import 'package:v2ex/page/UserInfoPage.dart';
import 'package:v2ex/entity/Member.dart';

class NavigatorUtils {
  ///个人中心
  static toUserInfo(BuildContext context, Member member) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new UserInfoPage(member)));
  }
}
