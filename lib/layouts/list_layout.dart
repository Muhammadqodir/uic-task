import 'package:audiobook/widgets/audioplayer/audio_player.dart';
import 'package:audiobook/widgets/ontap_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListLayout extends StatefulWidget {
  const ListLayout({
    super.key,
    required this.body,
    required this.title,
    this.back = false,
  });

  final String title;
  final Widget body;
  final bool back;

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
        leading: widget.back
            ? OnTapScaleAndFade(
                child: Icon(
                  CupertinoIcons.back,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            : null,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            NotificationListener<ScrollUpdateNotification>(
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AudioPlayerWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
