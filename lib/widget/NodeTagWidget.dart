import 'package:flutter/material.dart';
import 'package:v2ex/utils/NavigatorUtils.dart';

class NodeTagWidget extends StatelessWidget {
  final String nodeName;
  final String nodeTitle;

  NodeTagWidget(this.nodeName, this.nodeTitle);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
        child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: Text(
            nodeTitle,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
        ),
        onPressed: () {
          NavigatorUtils.toNodeInfo(context, nodeName, nodeTitle);
        });
  }
}
