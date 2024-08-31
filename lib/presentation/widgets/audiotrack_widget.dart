import 'package:audio_service/audio_service.dart';
import 'package:audiobook_player/core/audio_service.dart';
import 'package:audiobook_player/core/constants/colors.dart';
import 'package:audiobook_player/domain/entities/audiotrack_entity.dart';
import 'package:audiobook_player/domain/entities/book_entity.dart';
import 'package:audiobook_player/presentation/bloc/audio_player_bloc.dart';
import 'package:audiobook_player/presentation/widgets/ontapscale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudiotrackWidget extends StatelessWidget {
  const AudiotrackWidget({
    super.key,
    required this.book,
    required this.track,
    required this.onTap,
  });

  final BookEntity book;
  final AudiotrackEntity track;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    MyAudioHandler audioHandler =
        context.read<AudioPlayerBloc>().getAudioHandler();
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(builder: (
      context,
      state,
    ) {
      if (state is AudioPlayerLoaded) {
        if (state.book == book) {
          return StreamBuilder<MediaItem?>(
            stream: audioHandler.mediaItem,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return getView(context, snapshot.data!.title == track.title);
              }
              return const SizedBox.shrink();
            },
          );
        }
      }
      return getView(context, false);
    });
  }

  Widget getView(BuildContext context, bool isActive) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: isActive ? primaryColor.withAlpha(50) : Colors.transparent,
          ),
          child: OnTapScaleAndFade(
            lowerBound: 0.95,
            child: Column(
              children: [
                Row(
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
                            track
                                .toMediaItem()
                                .duration
                                .toString()
                                .replaceAll(".000000", ""),
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (track.isDownloaded)
                      const Icon(
                        CupertinoIcons.arrow_down_circle_fill,
                        size: 20,
                        color: Colors.green,
                      )
                  ],
                ),
              ],
            ),
            onTap: () {
              onTap();
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Divider(height: 0),
        ),
      ],
    );
  }
}
