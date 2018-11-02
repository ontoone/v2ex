import 'package:flutter/material.dart';
import 'package:v2ex/entity/Node.dart';
import 'package:v2ex/entity/Topic.dart';
import 'package:v2ex/net/V2EXManager.dart';
import 'package:v2ex/utils/HtmlParseUtil.dart';
import 'package:v2ex/utils/LogUtil.dart';
import 'package:v2ex/widget/NodeItemWidget.dart';
import 'package:v2ex/widget/custom_refresh.dart';
import 'package:v2ex/widget/refresh/smart_refresher.dart';

class NodeInfoPage extends StatefulWidget {
  final String nodeName;
  final String nodeTitle;

  NodeInfoPage(this.nodeName, this.nodeTitle);

  @override
  _NodeInfoPageState createState() => _NodeInfoPageState();
}

class _NodeInfoPageState extends State<NodeInfoPage> {
  final String TAG = "NodeInfoPage";
  RefreshController refreshController;
  List<Topic> mData;
  Node node;

  bool isFirst = true;
  int currentPage = 1;
  bool isLoadMore = false;

  @override
  void initState() {
    super.initState();
    mData = List();
    refreshController = RefreshController();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nodeTitle),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    if (mData.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return CustomRefresh(
      enablePullUp: true,
      enablePullDown: true,
      onRefresh: _onRefresh,
      controller: refreshController,
      child: ListView.builder(
        itemCount: mData.length,
        itemBuilder: (BuildContext context, int index) {
          return _itemBuilder(context, index);
        },
      ),
    );
  }

  //构造列表条目
  _itemBuilder(BuildContext context, int index) {
    return new Column(
      children: <Widget>[
        NodeItemWidget(mData[index]),
        Divider(height: 1.0),
      ],
    );
  }

  void _getData() {
    Map<String, String> param = Map();
    param["name"] = widget.nodeName;
    V2EXManager.getNodeInfo(
      (data) {
        node = Node.fromJson(data);
        _loadNodeList();
      },
      params: param,
      errorCallBack: () {},
    );
  }

  void _loadNodeList() {
    Map<String, String> param = Map();
    param["p"] = currentPage.toString();
    V2EXManager.getNodeList(
      widget.nodeName,
      (data) {
        HtmlParseUtil htmlParseUtil = HtmlParseUtil();
        List<Topic> topics = htmlParseUtil.parseNodeTopics(data);
        LogUtil.printMsg(TAG, topics.length.toString());
        currentPage++;
        setState(() {
          mData.addAll(topics);
        });
        if (isFirst) {
          isFirst = false;
        } else {
          _loadFinish();
        }
      },
      params: param,
      errorCallBack: () {},
    );
  }

  void _onRefresh(bool up) {
    LogUtil.printMsg("_onRefresh", up.toString());
    if (up) {
      currentPage = 1;
      mData.clear();
    } else {
      isLoadMore = true;
    }
    _loadNodeList();
  }

  void _loadFinish() {
    if (isLoadMore) {
      isLoadMore = false;
      refreshController.sendBack(false, RefreshStatus.idle);
    } else {
      refreshController.sendBack(true, RefreshStatus.completed);
    }
  }
}
