import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatefulWidget {
  String imageUrl;

  VoidCallback onPress;

  AvatarWidget(this.imageUrl, {this.onPress});

  @override
  _AvatarWidgetState createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
      child: Container(
        width: 40.0,
        height: 40.0,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            placeholder: Image.asset("static/images/default_avatar.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      onPressed: widget.onPress,
    );
  }
}
