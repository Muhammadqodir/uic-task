import 'package:audiobook/api/api.dart';
import 'package:audiobook/models/book.dart';
import 'package:audiobook/widgets/audio_book_cover.dart';
import 'package:audiobook/widgets/download_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioBookWidget extends StatelessWidget {
  const AudioBookWidget({
    super.key,
    required this.book,
    this.isDownloaded = false,
  });
  final AudioBook book;
  final bool isDownloaded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Row(
        children: [
          AudioBookCover(
            id: book.id ?? "0",
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title ?? "undefined",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  book.description ?? "undefined",
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          isDownloaded
              ? const SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(CupertinoIcons.check_mark_circled),
                )
              : DownloadBookBtn(
                  book: book,
                )
        ],
      ),
    );
  }
}
