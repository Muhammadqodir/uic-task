import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audiobook_player/core/audio_service.dart';
import 'package:audiobook_player/core/constants/colors.dart';
import 'package:audiobook_player/data/datasources/offline_datasource.dart';
import 'package:audiobook_player/di/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressBarWidget extends StatelessWidget {
  ProgressBarWidget({
    super.key,
    required this.audioHandler,
    required this.mediaItem,
  });
  final MyAudioHandler audioHandler;
  final MediaItem mediaItem;
  int lastPos = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: AudioService.position,
      builder: (context, snapshot) {
        if (lastPos != snapshot.data!.inSeconds) {
          lastPos = snapshot.data!.inSeconds;
          getIt<OfflineDataSource>().saveLastPlayedPosition(
            lastPos,
            audioHandler.queue.value.indexOf(mediaItem),
          );
        }
        if (snapshot.data != null) {
          return ProgressBar(
            progress: snapshot.data!,
            total: mediaItem.duration!,
            thumbColor: primaryColor,
            progressBarColor: primaryColor,
            thumbGlowColor: primaryColor.withAlpha(100),
            baseBarColor: primaryColor.withAlpha(100),
            onSeek: (value) async {
              await audioHandler.seek(value);
            },
          );
        }
        return const CupertinoActivityIndicator();
      },
    );
  }
}
