import 'package:audiobook_player/data/datasources/online_datasource.dart';
import 'package:audiobook_player/di/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookCover extends StatefulWidget {
  const BookCover({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<BookCover> createState() => _BookCoverState();
}

class _BookCoverState extends State<BookCover> {
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
    coverUrl = await getIt<OnlineDataSource>().getBookCover(widget.id);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
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
