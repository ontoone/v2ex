import 'NetUtil.dart';
import 'Api.dart';

class V2EXManager {
  ///获取最新主题
  static void getLatestTopics(
    Function callBack, {
    Map<String, String> params,
    Function errorCallBack,
  }) async {
    NetUtil.get(
      Api.BaseApiUrl + Api.lastUrl,
      callBack,
      params: params,
      errorCallBack: errorCallBack,
    );
  }

  ///获取最热主题
  static void getHotTopics(
    Function callBack, {
    Map<String, String> params,
    Function errorCallBack,
  }) async {
    NetUtil.get(
      Api.BaseApiUrl + Api.hotUrl,
      callBack,
      params: params,
      errorCallBack: errorCallBack,
    );
  }

  ///获取用户信息
  static void getUserInfo(
    String userName,
    Function callBack, {
    Map<String, String> params,
    Function errorCallBack,
  }) async {
    NetUtil.get(
      Api.BaseUrl + "/member/$userName",
      callBack,
      params: params,
      errorCallBack: errorCallBack,
    );
  }
}
