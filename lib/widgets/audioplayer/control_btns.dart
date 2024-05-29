import 'package:audio_service/audio_service.dart';
import 'package:audiobook/cubit/playlist_cubit.dart';
import 'package:audiobook/services/audio_handler.dart';
import 'package:audiobook/widgets/ontap_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              ],
            );
          }
          return SizedBox.shrink();
        });
  }
}
