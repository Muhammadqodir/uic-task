import 'package:audiobook/api/api.dart';
import 'package:audiobook/models/audiotrack.dart';
import 'package:audiobook/models/book.dart';
import 'package:audiobook/widgets/audio_book_cover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudiotrackWidget extends StatelessWidget {
  const AudiotrackWidget({
    super.key,
    required this.track,
  });
  final Audiotrack track;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Row(
        children: [
          Icon(CupertinoIcons.play),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.title ?? "undefined",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  track.playtime ?? "undefined",
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
