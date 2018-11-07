import 'NetUtil.dart';
import 'Api.dart';

class V2EXManager {
  ///获取分类节点
  static void getNodeCategory(
    Function callBack, {
    Map<String, String> params,
    Function errorCallBack,
  }) async {
    NetUtil.get(
      Api.BaseUrl,
      callBack,
      params: params,
      errorCallBack: errorCallBack,
    );
  }

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

  ///获取节点信息
  static void getNodeInfo(
    Function callBack, {
    Map<String, String> params,
    Function errorCallBack,
  }) async {
    NetUtil.get(
      Api.BaseApiUrl + Api.nodeUrl,
      callBack,
      params: params,
      errorCallBack: errorCallBack,
    );
  }

  ///获取主题详情
  ///参数 id=xxx
  static void getTopicDetail(
    Function callBack, {
    Map<String, String> params,
    Function errorCallBack,
  }) async {
    NetUtil.get(
      Api.BaseApiUrl + Api.topicShow,
      callBack,
      params: params,
      errorCallBack: errorCallBack,
    );
  }

  ///获取主题回复
  ///参数 topic_id=xxx page page_size
  static void getTopicReplies(
    Function callBack, {
    Map<String, String> params,
    Function errorCallBack,
  }) async {
    NetUtil.get(
      Api.BaseApiUrl + Api.topicReplies,
      callBack,
      params: params,
      errorCallBack: errorCallBack,
    );
  }

  ///分割线----------------------html解析--------------------------

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

  ///获取tab标签对应列表
  static void getTabTopics(
    String tabPath,
    Function callBack, {
    Map<String, String> params,
    Function errorCallBack,
  }) async {
    NetUtil.get(
      Api.BaseUrl + "/?tab=$tabPath",
      callBack,
      params: params,
      errorCallBack: errorCallBack,
    );
  }

  ///获取节点对应主题列表
  static void getNodeList(
    String nodeName,
    Function callBack, {
    Map<String, String> params,
    Function errorCallBack,
  }) async {
    NetUtil.get(
      Api.BaseUrl + "/go/$nodeName",
      callBack,
      params: params,
      errorCallBack: errorCallBack,
    );
  }
}
