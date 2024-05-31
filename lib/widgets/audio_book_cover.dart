import 'package:audiobook/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioBookCover extends StatefulWidget {
  const AudioBookCover({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<AudioBookCover> createState() => _AudioBookCoverState();
}

class _AudioBookCoverState extends State<AudioBookCover> {
  bool isLoading = true;
  String coverUrl = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCover();
  }

  void getCover() async {
    setState(() {
      isLoading = true;
    });
    coverUrl = await Api().getBookCover(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      child: isLoading
          ? const CupertinoActivityIndicator(
              radius: 12,
            )
          : Image.network(
              coverUrl,
              errorBuilder: (c, e, s) => const Icon(
                CupertinoIcons.book,
              ),
            ),
    );
  }
}
