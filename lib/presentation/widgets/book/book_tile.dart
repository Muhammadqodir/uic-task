import 'package:audiobook_player/domain/entities/book_entity.dart';
import 'package:audiobook_player/presentation/widgets/book/book_cover.dart';
import 'package:audiobook_player/presentation/widgets/book/download_book.dart';
import 'package:audiobook_player/presentation/widgets/ontapscale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookTileWidget extends StatelessWidget {
  const BookTileWidget({
    super.key,
    required this.book,
    required this.onTap,
  });

  final BookEntity book;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Column(
        children: [
          OnTapScaleAndFade(
            lowerBound: 0.97,
            onTap: () {
              onTap();
            },
            child: Row(
              children: [
                BookCover(
                  id: book.id,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        book.description,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                book.isDownloaded
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
          ),
          Divider(),
        ],
      ),
    );
  }
}
