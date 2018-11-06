import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatefulWidget {
  final String imageUrl;

  final VoidCallback onPress;

  final double width;
  final double height;

  AvatarWidget(
    this.imageUrl, {
    this.onPress,
    this.width = 40.0,
    this.height = 40.0,
  });

  @override
  _AvatarWidgetState createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
      child: Container(
        width: widget.width,
        height: widget.height,
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
