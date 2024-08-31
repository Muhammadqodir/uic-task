// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audiobook_player/domain/entities/audiotrack_entity.dart';
import 'package:audiobook_player/domain/entities/book_entity.dart';
import 'package:audiobook_player/domain/usecases/get_audiotracks.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'audiotrack_event.dart';
part 'audiotrack_state.dart';

class AudiotrackBloc extends Bloc<AudiotrackEvent, AudiotrackState> {
  GetAudioTracksUseCase _getAudioTracksUseCase;

  AudiotrackBloc(
    this._getAudioTracksUseCase,
  ) : super(AudiotrackInitial()) {
    on<GetAudiotracksEvent>(_getAudiotracksEvent);
  }

  Future<void> _getAudiotracksEvent(
    GetAudiotracksEvent event,
    Emitter<AudiotrackState> emit,
  ) async {
    emit(AudiotrackLoading());
    try {
      final audiotracks =
          await _getAudioTracksUseCase(params: event.bookEntity);
      if (audiotracks.isSuccess) {
        emit(AudiotrackLoaded(audiotracks.data!));
      } else {
        AudiotrackError(audiotracks.message ?? "undefined error");
      }
    } catch (e) {
      emit(AudiotrackError(e.toString()));
    }
  }

}
