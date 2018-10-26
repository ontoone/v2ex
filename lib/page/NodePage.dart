import 'package:flutter/material.dart';

class NodePage extends StatefulWidget {
  @override
  _NodePageState createState() => _NodePageState();
}

class _NodePageState extends State<NodePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    print("88888 initState node");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("节点"),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
