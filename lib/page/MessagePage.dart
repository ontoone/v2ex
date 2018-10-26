import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    print("88888 initState messgae");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("消息"),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
