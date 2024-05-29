import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audiobook/cubit/playlist_cubit.dart';
import 'package:audiobook/services/audio_handler.dart';
import 'package:audiobook/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({
    super.key,
    required this.audioHandler,
    required this.mediaItem,
  });
  final MyAudioHandler audioHandler;
  final MediaItem mediaItem;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: AudioService.position,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return ProgressBar(
            progress: snapshot.data!,
            total: mediaItem.duration!,
            thumbColor: primaryColor,
            progressBarColor: primaryColor,
            thumbGlowColor: primaryColor.withAlpha(100),
            baseBarColor: primaryColor.withAlpha(100),
            onSeek: (value) {
              audioHandler.seek(value);
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
