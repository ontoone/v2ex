import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:v2ex/entity/Topic.dart';
import 'package:v2ex/utils/UrlHelper.dart';
import 'package:v2ex/utils/NavigatorUtils.dart';

class NodeItemWidget extends StatefulWidget {
  Topic topic;

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
        print("88888 FlatButton");
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
            _buildAvatar(),
            _buildNameAndTime(),
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
              imageUrl: UrlHelper.getImageUrl(widget.topic.member.avatarLarge),
              placeholder: CircularProgressIndicator(),
              fit: BoxFit.cover,
            ),
          ),
        ),
        onPressed: () {
          NavigatorUtils.toUserInfo(context, widget.topic.member);
        });
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
}
