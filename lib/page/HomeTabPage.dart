import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:v2ex/entity/LocalNode.dart';
import 'package:v2ex/entity/Topic.dart';
import 'package:v2ex/net/V2EXManager.dart';
import 'package:v2ex/utils/HtmlParseUtil.dart';
import 'package:v2ex/widget/TopicitemWidget.dart';

class HomeTabPage extends StatefulWidget {
  final LocalNode localNode;

  HomeTabPage(this.localNode);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage>
    with AutomaticKeepAliveClientMixin {
  List<Topic> mData;
  RefreshController refreshController;
  bool first = true;

  @override
  void initState() {
    super.initState();
    mData = List();
    refreshController = RefreshController();
    print("88888 initState qa");
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      print("88888 build firist");
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    print("88888 build normal");
    return SmartRefresher(
      onRefresh: _onRefresh,
      enablePullUp: false,
      enablePullDown: true,
      controller: refreshController,
      child: ListView.builder(
        itemCount: mData.length,
        itemBuilder: (BuildContext context, int index) {
          return _itemBuilder(context, index);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  //构造列表条目
  _itemBuilder(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        TopicItemWidget(mData[index]),
        Divider(height: 1.0),
      ],
    );
  }

  _loadData() {
    if (widget.localNode.node == "热议") {
      _loadHotData();
    } else if (widget.localNode.node == "最新") {
      _loadLastData();
    } else {
      _loadTabData();
    }
  }

  Future _onRefresh(bool up) async {
    _loadData();
    return null;
  }

  void _loadLastData() {
    V2EXManager.getLatestTopics((data) {
      _setJsonData(data);
    }, errorCallBack: (errorMsg) {
      print("88888 _loadLastData error:" + errorMsg);
    });
  }

  void _loadHotData() {
    V2EXManager.getHotTopics((data) {
      _setJsonData(data);
    }, errorCallBack: (errorMsg) {
      print("88888 _loadHotData error:" + errorMsg);
    });
  }

  void _setJsonData(data) {
    if (data != null && data.length != 0) {
      List<Topic> list = new List();
      for (int i = 0; i < data.length; i++) {
        list.add(Topic.fromJson(data[i]));
      }
      print("88888 success resultsize:" + list.length.toString());
      _setData(list);
    }
  }

  void _loadTabData() {
    V2EXManager.getTabTopics(
      widget.localNode.path,
      (data) {
        var htmlParseUtil = HtmlParseUtil();
        List<Topic> topics = htmlParseUtil.parseTabTopics(data);
        _setData(topics);
      },
      errorCallBack: (errorMsg) {
        print("88888 _loadHotData error:" + errorMsg);
      },
    );
  }

  void _setData(list) {
    if (first) {
      first = false;
    }
    setState(() {
      mData = list;
    });
    refreshController.sendBack(true, RefreshStatus.completed);
  }
}
