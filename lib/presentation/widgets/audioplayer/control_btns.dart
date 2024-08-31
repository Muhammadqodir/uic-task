import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:audiobook_player/core/audio_service.dart';
import 'package:audiobook_player/presentation/widgets/ontapscale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_to_airplay/flutter_to_airplay.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({
    super.key,
    required this.audioHandler,
  });
  final MyAudioHandler audioHandler;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlaybackState>(
      stream: audioHandler.playbackState.stream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (Platform.isIOS) const SizedBox(width: 48),
              Spacer(),
              OnTapScaleAndFade(
                onTap: () {
                  audioHandler.skipToPrevious();
                },
                child: const Icon(
                  CupertinoIcons.left_chevron,
                  size: 32,
                ),
              ),
              const SizedBox(width: 24),
              OnTapScaleAndFade(
                onTap: () {
                  if (audioHandler.audioPlayer.playing) {
                    audioHandler.pause();
                  } else {
                    audioHandler.play();
                  }
                },
                child: Icon(
                  snapshot.data!.playing
                      ? CupertinoIcons.pause
                      : CupertinoIcons.play,
                  size: 32,
                ),
              ),
              const SizedBox(width: 24),
              OnTapScaleAndFade(
                onTap: () {
                  audioHandler.skipToNext();
                },
                child: const Icon(
                  CupertinoIcons.right_chevron,
                  size: 32,
                ),
              ),
              Spacer(),
              if (Platform.isIOS) AirPlayIconButton()
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
