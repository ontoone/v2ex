import 'package:flutter/material.dart';
import 'package:v2ex/widget/TabBarWidget.dart';
import 'QAPage.dart';
import 'MessagePage.dart';
import 'NodePage.dart';

class HomePage extends StatelessWidget {
  _renderTab(text) {
    return Tab(
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _renderTab("问与答"),
      _renderTab("消息"),
      _renderTab("节点"),
    ];

    return TabBarWidget(
      elevation: 0.0,
      title: Text(
        "V2EX",
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w900,
        ),
      ),
      type: TabBarWidget.TOP_TAB,
      indicatorColor: Colors.black,
      tabItems: tabs,
      tabViews: [
        QAPage(),
        MessagePage(),
        NodePage(),
      ],
    );
  }
}
