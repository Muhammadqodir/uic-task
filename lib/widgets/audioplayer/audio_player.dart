import 'package:audio_service/audio_service.dart';
import 'package:audiobook/cubit/audioplayer_cubit.dart';
import 'package:audiobook/cubit/playlist_cubit.dart';
import 'package:audiobook/services/audio_handler.dart';
import 'package:audiobook/widgets/audioplayer/control_btns.dart';
import 'package:audiobook/widgets/audioplayer/progress.dart';
import 'package:audiobook/widgets/ontap_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MyAudioHandler audioHandler =
        context.read<AudioplayerCubit>().state.audioHandler;
    return StreamBuilder<MediaItem?>(
      stream: audioHandler.mediaItem,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 0.5,
                  color: Theme.of(context).dividerColor.withAlpha(100),
                ),
              ),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Column(
              children: [
                Text(
                  audioHandler.bookName,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  snapshot.data!.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ProgressBarWidget(
                  audioHandler: audioHandler,
                  mediaItem: snapshot.data!,
                ),
                ControlButtons(
                  audioHandler: audioHandler,
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
