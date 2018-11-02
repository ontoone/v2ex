import 'package:flutter/material.dart';
import 'package:v2ex/entity/Reply.dart';
import 'package:v2ex/utils/NavigatorUtils.dart';
import 'package:v2ex/utils/UrlHelper.dart';
import 'package:v2ex/utils/timeline_util.dart';

import 'AvatarWidget.dart';

class TopicReplyItemWidget extends StatefulWidget {
  final Reply reply;
  final int index;

  TopicReplyItemWidget(this.reply, this.index);

  @override
  _TopicReplyItemWidgetState createState() => _TopicReplyItemWidgetState();
}

class _TopicReplyItemWidgetState extends State<TopicReplyItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(11.0, 11.0, 11.0, 8.0),
      child: _buildItem(),
    );
  }

  _buildItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildUser(),
        Padding(padding: EdgeInsets.only(top: 7.0)),
        Padding(
          padding: EdgeInsets.only(left: 43.0),
          child: _buildContent(),
        ),
        Padding(padding: EdgeInsets.only(top: 7.0)),
        Padding(
          padding: EdgeInsets.only(left: 43.0),
          child: Text(
            widget.index.toString() + "楼",
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  _buildUser() {
    return Row(
      children: <Widget>[
        AvatarWidget(
          UrlHelper.getImageUrl(widget.reply.member.avatarNormal),
          () {
            NavigatorUtils.toUserInfo(context, widget.reply.member);
          },
          width: 35.0,
          height: 35.0,
        ),
        _buildNameAndTime(),
        Icon(
          Icons.favorite_border,
          color: Colors.black54,
        ),
      ],
    );
  }

  ///名称和时间
  _buildNameAndTime() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.reply.member.username,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black87,
              ),
            ),
            Text(
              TimelineUtil.format(widget.reply.lastModified * 1000,
                  dayFormat: DayFormat.Full),
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildContent() {
    return Text(
      widget.reply.content,
      style: TextStyle(
        fontSize: 17.0,
        color: Colors.black,
      ),
    );
  }
}
