import 'package:audiobook_player/core/constants/colors.dart';
import 'package:audiobook_player/data/repositories/book_repository_impl.dart';
import 'package:audiobook_player/di/injection.dart';
import 'package:audiobook_player/domain/entities/book_entity.dart';
import 'package:audiobook_player/domain/repositories/book_repository.dart';
import 'package:audiobook_player/presentation/widgets/ontapscale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DownloadBookBtn extends StatefulWidget {
  const DownloadBookBtn({
    super.key,
    required this.book,
  });
  final BookEntity book;

  @override
  State<DownloadBookBtn> createState() => _DownloadBookBtnState();
}

class _DownloadBookBtnState extends State<DownloadBookBtn> {
  bool isLoading = false;
  bool isDownloaded = false;
  double progress = 0;

  Future<void> _downloadBook() async {
    setState(() {
      isLoading = true;
    });
    await getIt<BookRepository>().saveBook(widget.book, (progress) {
      setState(() {
        this.progress = progress;
      });
    });
    setState(() {
      isLoading = false;
      isDownloaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OnTapScaleAndFade(
      child: SizedBox(
        width: 40,
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            isDownloaded
                ? const Icon(
                    CupertinoIcons.check_mark_circled,
                  )
                : isLoading
                    ? CircularProgressIndicator(
                        value: progress == 0 ? null : progress,
                        color: primaryColor,
                      )
                    : const Icon(
                        CupertinoIcons.down_arrow,
                      ),
          ],
        ),
      ),
      onTap: () async {
        await _downloadBook();
      },
    );
  }
}
