import 'package:flutter/material.dart';
import 'package:v2ex/entity/Topic.dart';
import 'package:v2ex/utils/NavigatorUtils.dart';
import 'package:v2ex/utils/UrlHelper.dart';
import 'package:v2ex/widget/AvatarWidget.dart';

class NodeItemWidget extends StatefulWidget {
  final Topic topic;

  NodeItemWidget(this.topic);

  @override
  _NodeItemWidgetState createState() => _NodeItemWidgetState();
}

class _NodeItemWidgetState extends State<NodeItemWidget> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(11.0),
      color: Colors.white,
      onPressed: () {
        NavigatorUtils.toTopicDetail(context, widget.topic.id);
      },
      child: _buildItem(),
    );
  }

  _buildItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AvatarWidget(
              UrlHelper.getImageUrl(widget.topic.member.avatarNormal),
              onPress: () {
                NavigatorUtils.toUserInfo(context, widget.topic.member);
              },
            ),
            _buildNameAndTime(),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 8.0)),
        _buildContent(),
        Padding(padding: EdgeInsets.only(top: 4.0)),
        _buildReplyNum(),
      ],
    );
  }

  ///名称和时间
  _buildNameAndTime() {
    return Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Text(
        widget.topic.member.username,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black87,
        ),
      ),
    );
  }

  _buildContent() {
    return Text(
      widget.topic.title,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  _buildReplyNum() {
    int reply = widget.topic.replies;
    if (reply == null || reply == 0) {
      return Container();
    }

    return Align(
      alignment: Alignment.topRight,
      child: Text(
        widget.topic.lastReplyTimeName +
            " 评论" +
            widget.topic.replies.toString(),
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.grey,
        ),
      ),
    );
  }
}
