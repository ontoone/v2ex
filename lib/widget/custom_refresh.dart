import 'package:flutter/material.dart';
import 'package:v2ex/widget/refresh/smart_refresher.dart';
import 'package:v2ex/widget/refresh/internals/default_constants.dart';

class CustomRefresh extends StatefulWidget {
  final Widget child;
  final OnRefresh onRefresh;
  final RefreshCallback indicatorRefresh;
  final RefreshController controller;
  OnScrollNotification scrollNotification;

  // This bool will affect whether or not to have the function of drop-up load.
  final bool enablePullUp;

  //This bool will affect whether or not to have the function of drop-down refresh.
  final bool enablePullDown;

  // if open OverScroll if you use RefreshIndicator and LoadFooter
  final bool enableOverScroll;

  CustomRefresh({
    this.child,
    this.onRefresh,
    this.controller,
    this.scrollNotification,
    this.enableOverScroll: default_enableOverScroll,
    this.enablePullDown: default_enablePullDown,
    this.enablePullUp: default_enablePullUp,
    this.indicatorRefresh,
  });

  @override
  _CustomRefreshState createState() => _CustomRefreshState();
}

class _CustomRefreshState extends State<CustomRefresh> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enableOverScroll) {
      return SmartRefresher(
        onRefresh: widget.onRefresh,
        enablePullUp: widget.enablePullUp,
        enablePullDown: widget.enablePullDown,
        enableOverScroll: widget.enableOverScroll,
        controller: widget.controller,
        onScrollNotification: widget.scrollNotification,
        child: widget.child,
      );
    }

    return RefreshIndicator(
        child: SmartRefresher(
          onRefresh: widget.onRefresh,
          enablePullUp: widget.enablePullUp,
          enablePullDown: false,
          enableOverScroll: widget.enableOverScroll,
          controller: widget.controller,
          onScrollNotification: widget.scrollNotification,
          child: widget.child,
        ),
        onRefresh: widget.indicatorRefresh);
  }
}
