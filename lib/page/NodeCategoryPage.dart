import 'package:flutter/material.dart';
import 'package:v2ex/entity/Node.dart';
import 'package:v2ex/widget/NodeTagWidget.dart';
import 'package:v2ex/net/V2EXManager.dart';
import 'package:v2ex/utils/HtmlParseUtil.dart';
import 'package:v2ex/entity/NodeCategory.dart';

class NodeCategoryPage extends StatefulWidget {
  @override
  _NodeCategoryPageState createState() => _NodeCategoryPageState();
}

class _NodeCategoryPageState extends State<NodeCategoryPage> {
  List<NodeCategory> nodeCategorys = List();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    V2EXManager.getNodeCategory((data) {
      HtmlParseUtil parseUtil = HtmlParseUtil();
      nodeCategorys = parseUtil.parseNodeCategory(data);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("节点"),
      ),
//      body: _buildNodeTags(),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return _buildNodeTags();
        },
      ),
    );
  }

  _buildNodeTags() {
    List<Widget> nodeTags = List();
    for (NodeCategory nodeCategory in nodeCategorys) {
      if (nodeCategory.title != null) {
//        nodeTags.add(Text(
//            nodeCategory.title + "                                       "));
      } else {
        for (Node node in nodeCategory.nodes) {
          nodeTags.add(NodeTagWidget(node.name, node.title));
        }
      }
    }

//    for (Node node in nodeCategory.nodes) {
//      nodeTags.add(NodeTagWidget(node.name, node.title));
//    }

    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Wrap(
//      delegate: NodeFlowDelegate(margin: EdgeInsets.only(left: 8.0, top: 8.0)),
        spacing: 8.0,
        runSpacing: 8.0,
        children: nodeTags,
      ),
    );
  }
}

class NodeFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  NodeFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
