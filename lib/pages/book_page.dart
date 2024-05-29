import 'package:audio_service/audio_service.dart';
import 'package:audiobook/cubit/playlist_cubit.dart';
import 'package:audiobook/layouts/list_layout.dart';
import 'package:audiobook/models/book.dart';
import 'package:audiobook/widgets/audiotrack.dart';
import 'package:audiobook/widgets/cross_list_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookPage extends StatefulWidget {
  const BookPage({
    super.key,
    required this.book,
  });
  final AudioBook book;

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PlaylistCubit>().getBookAudioTracks(
          context,
          widget.book.id ?? "undefined",
        );
  }

  @override
  Widget build(BuildContext context) {
    PlaylistState state = context.watch<PlaylistCubit>().state;
    List<MediaItem> items = state.getMediaItems();
    return ListLayout(
      body: state.isLoading
          ? const Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                CupertinoActivityIndicator()
              ],
            )
          : Column(
              children: items
                  .map(
                    (e) => CrossListElement(
                      onPressed: () {
                        state.audioHandler.skipToQueueItem(
                          items.indexOf(e),
                        );
                      },
                      child: AudiotrackWidget(
                        track: e,
                        audioHandler: state.audioHandler,
                      ),
                    ),
                  )
                  .toList(),
            ),
      title: widget.book.title ?? "undefied",
    );
  }
}
