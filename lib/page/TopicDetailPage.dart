import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v2ex/entity/Reply.dart';
import 'package:v2ex/entity/Topic.dart';
import 'package:v2ex/net/V2EXManager.dart';
import 'package:v2ex/widget/TopicReplyItemWidget.dart';
import 'package:v2ex/widget/TopicitemWidget.dart';
import 'package:v2ex/widget/refresh/smart_refresher.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  @override
  void initState() {
    super.initState();
    listData = List();
    refreshController = RefreshController();
//    scrollController = refreshController.scrollController;
    floatReplyButton = Opacity(
      opacity: opacityLevel,
//      duration: new Duration(milliseconds: 5000),
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.textsms, color: Colors.black54),
        backgroundColor: Colors.white,
      ),
    );
//    scrollController.addListener(() {
//      print("88888 scrollController");
//      print("88888 scroll:" +
//          scrollController.position.isScrollingNotifier.toString());
//    });
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
    return SmartRefresher(
      onRefresh: _onRefresh,
      enablePullUp: false,
      enablePullDown: true,
      controller: refreshController,
      onScrollNotification: (ScrollNotification notification) {
        if (notification is UserScrollNotification) {
          String state = notification.direction.toString();
          if (state == "ScrollDirection.idle") {
            setState(() {
              opacityLevel = 1.0;
            });
          } else {
            setState(() {
              opacityLevel = 0.0;
            });
          }
          print("88888 opacityLevel:" + opacityLevel.toString());
        }
      },
      child: ListView.builder(
        itemCount: listData.length,
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

  Widget _itemBuilder(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        _buildItem(index),
        Divider(height: 1.0),
      ],
    );
  }

  _buildTopicContent() {
    return Html(
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
          TopicItemWidget(
            topic,
            onItemClick: () {},
          ),
          _buildTopicContent(),
        ],
      );
    } else if (index == listData.length - 1) {
      return Container(
        padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
        child: Text(
          "全部加载完成",
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      );
    } else {
      return TopicReplyItemWidget(listData[index], index);
    }
  }
}
