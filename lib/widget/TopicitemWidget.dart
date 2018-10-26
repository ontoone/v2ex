import 'package:flutter/material.dart';
import 'package:v2ex/entity/Topic.dart';
import 'package:v2ex/utils/UrlHelper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:v2ex/utils/NavigatorUtils.dart';

class TopicItemWidget extends StatefulWidget {
  Topic mTopic;

  TopicItemWidget(this.mTopic);

  @override
  _TopicItemWidgetState createState() => _TopicItemWidgetState();
}

class _TopicItemWidgetState extends State<TopicItemWidget> {
  _buildItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildAvatar(),
            _buildNameAndTime(),
            _buildNodeTag(),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 8.0)),
        _buildContent(),
      ],
    );
  }

  ///头像
  _buildAvatar() {
    return RawMaterialButton(
        shape: CircleBorder(),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
        child: Container(
          width: 40.0,
          height: 40.0,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: UrlHelper.getImageUrl(widget.mTopic.member.avatarLarge),
              placeholder: CircularProgressIndicator(),
              fit: BoxFit.cover,
            ),
          ),
        ),
        onPressed: () {
          NavigatorUtils.toUserInfo(context, widget.mTopic.member);
        });
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
              widget.mTopic.member.username,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
            Text(
              "14分钟前",
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

  ///节点标签
  _buildNodeTag() {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Text(
        widget.mTopic.node.title,
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.black54,
        ),
      ),
    );
  }

  _buildContent() {
    return Text(
      widget.mTopic.title,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(11.0),
      color: Colors.white,
      onPressed: () {
        print("88888 FlatButton");
      },
      child: _buildItem(),
    );
  }
}
