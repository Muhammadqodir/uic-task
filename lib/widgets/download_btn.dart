import 'package:audiobook/api/api.dart';
import 'package:audiobook/models/book.dart';
import 'package:audiobook/utils/colors.dart';
import 'package:audiobook/widgets/ontap_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class DownloadBookBtn extends StatefulWidget {
  const DownloadBookBtn({
    super.key,
    required this.book,
  });
  final AudioBook book;

  @override
  State<DownloadBookBtn> createState() => _DownloadBookBtnState();
}

class _DownloadBookBtnState extends State<DownloadBookBtn> {
  bool isLoading = false;
  bool isDownloaded = false;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return OnTapScaleAndFade(
      child: Container(
        width: 40,
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            isDownloaded
                ? Icon(
                    CupertinoIcons.check_mark_circled,
                  )
                : isLoading
                    ? CircularProgressIndicator(
                        value: progress,
                        color: primaryColor,
                      )
                    : Icon(
                        CupertinoIcons.down_arrow,
                      ),
          ],
        ),
      ),
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        await Api().downloadBook(widget.book, (p) {
          setState(() {
            progress = p;
          });
        });
        setState(() {
          isDownloaded = true;
        });
      },
    );
  }
}
