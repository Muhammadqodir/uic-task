// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audiobook_player/domain/entities/book_entity.dart';
import 'package:audiobook_player/presentation/bloc/audio_player_bloc.dart';
import 'package:audiobook_player/presentation/bloc/audiotrack_bloc.dart';
import 'package:audiobook_player/presentation/widgets/audiotrack_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudiotrackListPage extends StatelessWidget {
  final BookEntity bookEntity;
  const AudiotrackListPage({
    Key? key,
    required this.bookEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(bookEntity.title)),
      body: BlocBuilder<AudiotrackBloc, AudiotrackState>(
        builder: (context, state) {
          if (state is AudiotrackLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AudiotrackLoaded) {
            return ListView.builder(
              itemCount: state.audiotracks.length,
              itemBuilder: (context, index) {
                final audiotrack = state.audiotracks[index];
                return AudiotrackWidget(
                  book: bookEntity,
                  track: audiotrack,
                  onTap: () {
                    context.read<AudioPlayerBloc>().add(
                          AudiotrackTapEvent(
                            bookEntity: bookEntity,
                            playlist: state.audiotracks,
                            startPlayingIndex: index,
                          ),
                        );
                  },
                );
              },
            );
          } else if (state is AudiotrackError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
