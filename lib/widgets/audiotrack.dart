import 'package:audio_service/audio_service.dart';
import 'package:audiobook/api/api.dart';
import 'package:audiobook/cubit/audioplayer_cubit.dart';
import 'package:audiobook/models/audiotrack.dart';
import 'package:audiobook/models/book.dart';
import 'package:audiobook/services/audio_handler.dart';
import 'package:audiobook/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudiotrackWidget extends StatelessWidget {
  const AudiotrackWidget({
    super.key,
    required this.book,
    required this.track,
  });

  final AudioBook book;
  final MediaItem track;

  @override
  Widget build(BuildContext context) {
    MyAudioHandler audioHandler =
        context.read<AudioplayerCubit>().state.audioHandler;
    return audioHandler.bookId == (book.id ?? "undefined")
        ? StreamBuilder<MediaItem?>(
            stream: audioHandler.mediaItem,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return getView(context, snapshot.data! == track);
              }
              return const SizedBox.shrink();
            },
          )
        : getView(context, false);
  }

  Widget getView(BuildContext context, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: isActive ? primaryColor.withAlpha(50) : Colors.transparent,
      ),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.bookmark,
            color: primaryColor,
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
                  track.duration.toString().replaceAll(".000000", ""),
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
