import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:audiobook/api/api.dart';
import 'package:audiobook/models/audiotrack.dart';
import 'package:audiobook/services/audio_handler.dart';
import 'package:audiobook/utils/dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    emit(state.copyWith(list: []));
    ApiResponse<List<Audiotrack>> res = await Api().getAudioTracks(id);
    if (res.isSuccess) {
      emit(state.copyWith(list: res.data));
    } else {
      showErrorDialog(context, res.title, res.message);
    }
    setLoading(false);
  }

  Future<void> getBookAudioTracksFromCache(
      BuildContext context, String id) async {
    print("Getting from cache");
    setLoading(true);
    emit(state.copyWith(list: []));

    List<dynamic> cachedTracks = jsonDecode(
      (await SharedPreferences.getInstance()).getString(id + "_audiotracks") ??
          "{}",
    );
    print(cachedTracks);
    List<Audiotrack> list = List<Audiotrack>.from(
      cachedTracks.map(
        (e) => Audiotrack.fromJson(e),
      ),
    );
    emit(state.copyWith(list: list));
    setLoading(false);
  }

  void setLoading(bool loading) {
    emit(state.copyWith(isLoading: loading));
  }
}
