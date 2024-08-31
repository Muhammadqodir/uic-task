import 'package:audio_service/audio_service.dart';
import 'package:audiobook_player/core/audio_service.dart';
import 'package:audiobook_player/presentation/bloc/audio_player_bloc.dart';
import 'package:audiobook_player/presentation/widgets/audioplayer/control_btns.dart';
import 'package:audiobook_player/presentation/widgets/audioplayer/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({super.key});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  @override
  void initState() {
    super.initState();
    context.read<AudioPlayerBloc>().add(const LoadLastPlayedEvent());
  }

  @override
  Widget build(BuildContext context) {
    AudioPlayerBloc state = context.read<AudioPlayerBloc>();
    MyAudioHandler audioHandler = state.getAudioHandler();
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.5,
            color: Theme.of(context).dividerColor.withAlpha(100),
          ),
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: SafeArea(
        top: false,
        child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
          builder: (context, state) {
            if (state is AudioPlayerLoading) {
              return const Column(
                children: [
                  CupertinoActivityIndicator(),
                  SizedBox(height: 12),
                ],
              );
            } else if (state is AudioPlayerLoaded) {
              return StreamBuilder<MediaItem?>(
                stream: audioHandler.mediaItem,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Column(
                        children: [
                          Text(
                            state.book.title,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            snapshot.data!.title,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          ProgressBarWidget(
                            audioHandler: audioHandler,
                            mediaItem: snapshot.data!,
                          ),
                          ControlButtons(
                            audioHandler: audioHandler,
                          ),
                          const SizedBox(height: 12)
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
