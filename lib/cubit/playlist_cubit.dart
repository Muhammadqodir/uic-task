import 'package:audiobook/api/api.dart';
import 'package:audiobook/models/audiotrack.dart';
import 'package:audiobook/utils/dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'playlist_state.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  PlaylistCubit()
      : super(
          PlaylistState(
            list: const [],
            currentIndex: 0,
            currentTime: 0,
          ),
        );

  Future<void> getBookAudioTracks(BuildContext context, String id) async {
    setLoading(true);
    ApiResponse<List<Audiotrack>> res = await Api().getAudioTracks(id);
    if (res.isSuccess) {
      print(res.data!.length);
      emit(state.copyWith(list: res.data));
    } else {
      showErrorDialog(context, res.title, res.message);
    }
    setLoading(false);
  }

  void setLoading(bool loading) {
    emit(state.copyWith(isLoading: loading));
  }
}
