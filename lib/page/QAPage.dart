import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:v2ex/net/V2EXManager.dart';
import 'package:v2ex/entity/Topic.dart';
import 'package:v2ex/widget/TopicitemWidget.dart';

class QAPage extends StatefulWidget {
  @override
  _QAPageState createState() => _QAPageState();
}

class _QAPageState extends State<QAPage> with AutomaticKeepAliveClientMixin {
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
      enablePullDown: true,
      enablePullUp: true,
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
    return new Column(
      children: <Widget>[
        TopicItemWidget(mData[index]),
        Divider(height: 1.0),
      ],
    );
  }

  _loadData() {
    V2EXManager.getHotTopics((data) {
      if (data != null && data.length != 0) {
        List<Topic> list = new List();
        for (int i = 0; i < data.length; i++) {
          list.add(Topic.fromJson(data[i]));
        }
        print("88888 success resultsize:" + list.length.toString());
        if (first) {
          first = false;
        }
        setState(() {
          mData = list;
        });
        refreshController.sendBack(true, RefreshStatus.completed);
      }
    }, errorCallBack: (errorMsg) {
      print("88888 error:" + errorMsg);
    });
  }

  Future _onRefresh(bool up) async {
    _loadData();
    return null;
  }
}
