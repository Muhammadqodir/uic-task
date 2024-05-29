import 'package:audio_service/audio_service.dart';
import 'package:audiobook/api/api.dart';
import 'package:audiobook/models/audiotrack.dart';
import 'package:audiobook/models/book.dart';
import 'package:audiobook/services/audio_handler.dart';
import 'package:audiobook/widgets/audio_book_cover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudiotrackWidget extends StatelessWidget {
  const AudiotrackWidget({
    super.key,
    required this.track,
    required this.audioHandler,
  });

  final MediaItem track;
  final MyAudioHandler audioHandler;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
      stream: audioHandler.mediaItem,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: Row(
              children: [
                Icon(
                  snapshot.data! == track ? CupertinoIcons.pause : CupertinoIcons.play,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        track.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        track.duration.toString(),
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
        return const SizedBox.shrink();
      },
    );
  }
}
