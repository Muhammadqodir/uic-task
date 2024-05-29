import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListLayout extends StatefulWidget {
  const ListLayout({
    super.key,
    required this.body,
    required this.title,
  });

  final String title;
  final Widget body;

  @override
  State<ListLayout> createState() => _ListLayoutState();
}

class _ListLayoutState extends State<ListLayout> {
  bool showShadow = false;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: showShadow ? 0.5 : 0,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: NotificationListener<ScrollUpdateNotification>(
          onNotification: (notification) {
            if (notification.metrics.pixels > 0 && !showShadow) {
              setState(() {
                showShadow = true;
              });
            }
            if (notification.metrics.pixels <= 0 && showShadow) {
              setState(() {
                showShadow = false;
              });
            }
            return true;
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            children: [
              widget.body,
            ],
          ),
        ),
      ),
    );
  }
}
