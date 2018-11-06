import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v2ex/entity/Reply.dart';
import 'package:v2ex/entity/Topic.dart';
import 'package:v2ex/net/V2EXManager.dart';
import 'package:v2ex/widget/TopicReplyItemWidget.dart';
import 'package:v2ex/widget/TopicitemWidget.dart';
import 'package:v2ex/widget/custom_refresh.dart';
import 'package:v2ex/widget/refresh/smart_refresher.dart';

class TopicDetailPage extends StatefulWidget {
  final int topicId;

  TopicDetailPage(this.topicId);

  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  // 初始opacityLevel为1.0为可见状态，为0.0时不可见
  double opacityLevel = 1.0;

  List<Reply> listData;
  Topic topic;

  RefreshController refreshController;
  ScrollController scrollController;

  Widget floatReplyButton;

  StreamController<bool> floatReplyButtonVisible;

  @override
  void initState() {
    super.initState();
    listData = List();
    refreshController = RefreshController();
    floatReplyButtonVisible = StreamController<bool>();
    floatReplyButton = StreamBuilder<bool>(
      stream: floatReplyButtonVisible.stream,
      initialData: true,
      builder: (context, snapshot) => Opacity(
            opacity: snapshot.data ? 1.0 : 0.0,
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.textsms, color: Colors.black54),
              backgroundColor: Colors.white,
            ),
          ),
    );
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    floatReplyButtonVisible.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("主题详情"),
      ),
      body: _buildBody(),
      floatingActionButton: floatReplyButton,
    );
  }

  _buildBody() {
    if (topic == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return CustomRefresh(
      onRefresh: _onRefresh,
      enablePullUp: false,
      enablePullDown: true,
      controller: refreshController,
      scrollNotification: (ScrollNotification notification) {
        if (notification is UserScrollNotification) {
          print("88888 UserScrollNotification:" +
              notification.direction.toString());
          var state = notification.direction;
//          if (state == ScrollDirection.reverse) {
//            floatReplyButtonVisible.sink.add(false);
//          } else if (state == ScrollDirection.forward) {
//            floatReplyButtonVisible.sink.add(true);
//          }
        }
      },
      child: ListView.builder(
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(index);
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
        //头部
        listData.add(Reply());
        listData.addAll(list);
        //尾部
        listData.add(Reply());
      });
      refreshController.sendBack(true, RefreshStatus.completed);
    }, params: param);
  }

  void _onRefresh(bool up) {
    _getData();
    return null;
  }

  _buildTopicContent() {
    if (topic.contentRendered == null || topic.contentRendered == "") {
      return Container();
    }
    return Html(
      backgroundColor: Colors.white,
      data: topic.contentRendered,
      padding: EdgeInsets.fromLTRB(11.0, 11.0, 11.0, 20.0),
      defaultTextStyle: TextStyle(fontSize: 16.0),
      onLinkTap: (url) {
        _launchURL(url);
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
//      throw 'Could not launch $url';
    }
  }

  _buildItem(int index) {
    if (index == 0) {
      return Column(
        children: <Widget>[
          Divider(height: 1.0),
          TopicItemWidget(
            topic,
            onItemClick: () {},
          ),
          Divider(height: 1.0),
          _buildTopicContent(),
          Divider(height: 1.0),
        ],
      );
    } else if (index == listData.length - 1) {
      return Container(
        padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
        alignment: Alignment.center,
        child: Text(
          "全部加载完成",
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: TopicReplyItemWidget(listData[index], index),
          ),
          Divider(height: 1.0),
        ],
      );
    }
  }
}
