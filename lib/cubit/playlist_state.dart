// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'playlist_cubit.dart';

class PlaylistState {
  List<Audiotrack> list;
  int currentIndex;
  int currentTime;
  bool isLoading;
  PlaylistState({
    required this.list,
    required this.currentIndex,
    required this.currentTime,
    this.isLoading = false,
  });

  List<MediaItem> getMediaItems() {
    List<MediaItem> items = [];
    for (var element in list) {
      items.add(
        MediaItem(
          id: element.listenUrl ?? "undefined",
          title: element.title ?? "undefined",
          playable: true,
          duration: Duration(
            seconds: int.parse(element.playtime ?? "0"),
          ),
        ),
      );
    }
    return items;
  }

  PlaylistState copyWith({
    MyAudioHandler? audioHandler,
    List<Audiotrack>? list,
    int? currentIndex,
    int? currentTime,
    bool? isLoading,
  }) {
    return PlaylistState(
      list: list ?? this.list,
      currentIndex: currentIndex ?? this.currentIndex,
      currentTime: currentTime ?? this.currentTime,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
