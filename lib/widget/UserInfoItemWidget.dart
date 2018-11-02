import 'package:flutter/material.dart';

import 'package:v2ex/entity/Topic.dart';
import 'package:v2ex/entity/Member.dart';
import 'package:v2ex/utils/NavigatorUtils.dart';

class UserInfoItemWidget extends StatefulWidget {
  final Topic topic;
  final Member member;

  UserInfoItemWidget(this.topic, this.member);

  @override
  _UserInfoItemWidgetState createState() => _UserInfoItemWidgetState();
}

class _UserInfoItemWidgetState extends State<UserInfoItemWidget> {
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
    if (widget.topic.isTopic) {
      return _buildUserTopicItem();
    } else {
      return _buildUserReplyItem();
    }
  }

  _buildUserTopicItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ///名称
            Text(
              widget.member.username,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),

            ///评论数量
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.topic.replies != 0
                      ? "评论" + widget.topic.replies.toString()
                      : "",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            ///节点标签
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Text(
                "程序员",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 2.0)),

        ///标题
        Text(
          widget.topic.title,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Padding(padding: EdgeInsets.only(top: 4.0)),

        ///最后回复人和时间
        Align(
          alignment: Alignment.topRight,
          child: Text(
            widget.topic.lastReplyTimeName.replaceAll(" ", ""),
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  //回复item
  _buildUserReplyItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.topic.replyTitle,
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.grey,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 4.0)),
        Container(
          padding: EdgeInsets.all(10.0),
          width: double.infinity,
          child: Text(widget.topic.replyContent,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              )),
          color: Color(0xFFF5F5F5),
        ),
        Padding(padding: EdgeInsets.only(top: 4.0)),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            widget.topic.replyTime,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
//    return Text(widget.topic.replyTitle);
  }
}
