// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audiobook_player/core/audio_service.dart';
import 'package:audiobook_player/core/res/datastate.dart';
import 'package:audiobook_player/data/datasources/offline_datasource.dart';
import 'package:audiobook_player/data/models/last_played.dart';
import 'package:audiobook_player/di/injection.dart';
import 'package:audiobook_player/domain/entities/audiotrack_entity.dart';
import 'package:audiobook_player/domain/entities/book_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final MyAudioHandler _myAudioHandler;

  AudioPlayerBloc(this._myAudioHandler) : super(AudioPlayerInitial()) {
    on<InitPlaylistEvent>(_initPlaylist);
    on<SkipToIndexEvent>(_skipToIndex);
    on<AudiotrackTapEvent>(_audiotackTap);
    on<LoadLastPlayedEvent>(_loadLastPlayed);
  }

  MyAudioHandler getAudioHandler() {
    return _myAudioHandler;
  }

  Future<void> _loadLastPlayed(
    LoadLastPlayedEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    emit(AudioPlayerLoading());
    DataState<LastPlayed> lastPlayed =
        await getIt<OfflineDataSource>().getLastPlayed();
    if (lastPlayed.isSuccess) {
      await _myAudioHandler.initTracks(
        traks: lastPlayed.data!.list.map((e) => e.toMediaItem()).toList(),
      );
      await _myAudioHandler.skipToQueueItem(lastPlayed.data!.index);
      await _myAudioHandler.seek(Duration(seconds: lastPlayed.data!.positoin));
      await _myAudioHandler.pause();
      emit(AudioPlayerLoaded(
        audioTracks: lastPlayed.data!.list,
        book: lastPlayed.data!.bookEntity,
      ));
    } else {
      emit(AudioPlayerInitial());
    }
  }

  Future<void> _initPlaylist(
    InitPlaylistEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    emit(AudioPlayerLoading());
    await _myAudioHandler.stop();
    await _myAudioHandler.initTracks(
      traks: event.playlist.map((e) => e.toMediaItem()).toList(),
    );
    await _myAudioHandler.skipToQueueItem(event.startPlayingIndex);
    //saving last played
    await getIt<OfflineDataSource>().saveLastPlayed(LastPlayed(
      bookEntity: event.bookEntity,
      list: event.playlist,
      index: event.startPlayingIndex,
      positoin: 0,
    ));
    emit(AudioPlayerLoaded(
      audioTracks: event.playlist,
      book: event.bookEntity,
    ));
  }

  Future<void> _skipToIndex(
    SkipToIndexEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    _myAudioHandler.skipToQueueItem(event.index);
  }

  Future<void> _audiotackTap(
    AudiotrackTapEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    if (state is AudioPlayerLoaded) {
      if ((state as AudioPlayerLoaded).book == event.bookEntity) {
        add(SkipToIndexEvent(index: event.startPlayingIndex));
        return;
      }
    }
    add(InitPlaylistEvent(
      bookEntity: event.bookEntity,
      playlist: event.playlist,
      startPlayingIndex: event.startPlayingIndex,
    ));
  }
}
