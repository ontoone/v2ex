import 'package:flutter/material.dart';
import 'package:v2ex/utils/NavigatorUtils.dart';

class UrlHelper {
  ///获取图片url
  static getImageUrl(String cdn) {
    return "https:$cdn";
  }

  static canLaunchInApp(BuildContext context, String url) {
    if (url.contains("https://www.v2ex.com/t/")) {
      NavigatorUtils.toTopicDetail(
          context, int.parse(url.replaceAll("https://www.v2ex.com/t/", "")));
      return true;
    }

    return false;
  }
}
