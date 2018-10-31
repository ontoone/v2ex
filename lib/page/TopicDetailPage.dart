import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:v2ex/entity/Reply.dart';
import 'package:v2ex/entity/Topic.dart';
import 'package:v2ex/net/V2EXManager.dart';
import 'package:v2ex/widget/TopicReplyItemWidget.dart';
import 'package:v2ex/widget/TopicitemWidget.dart';

class TopicDetailPage extends StatefulWidget {
  final int topicId;

  TopicDetailPage(this.topicId);

  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  var _pageSize = 20;
  var _currentPage = 1;

  List<Reply> listData;
  Topic topic;

  RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    listData = List();
    refreshController = RefreshController();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("主题详情"),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    if (topic == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return SmartRefresher(
      onRefresh: _onRefresh,
      enablePullUp: false,
      enablePullDown: true,
      controller: refreshController,
      child: ListView.builder(
        itemCount: listData.length + 1,
        itemBuilder: (BuildContext context, int index) {
          return _itemBuilder(context, index);
        },
      ),
    );
  }

  void _getData() {
    Map<String, String> param = Map();
    param["id"] = widget.topicId.toString();
    V2EXManager.getTopicDetail((data) {
      Topic topic = Topic.fromJson(data[0]);
      print(topic.content);
      this.topic = topic;
      print("topic:" + topic.title);
      _getReplies();
    }, params: param);
  }

  void _getReplies() {
    print("_getReplies");
    Map<String, String> param = Map();
    param["topic_id"] = widget.topicId.toString();
    V2EXManager.getTopicReplies((data) {
      List<Reply> list = new List();
      for (int i = 0; i < data.length; i++) {
        list.add(Reply.fromJson(data[i]));
      }
      setState(() {
        listData.clear();
        listData.addAll(list);
      });
      refreshController.sendBack(true, RefreshStatus.completed);
    }, params: param);
  }

  void _onRefresh(bool up) {
    _getData();
    return null;
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        index == 0
            ? TopicItemWidget(
                topic,
                onItemClick: () {},
              )
            : TopicReplyItemWidget(listData[index - 1], index),
        Divider(height: 1.0),
      ],
    );
  }
}
