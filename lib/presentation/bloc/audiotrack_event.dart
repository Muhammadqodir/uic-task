part of 'audiotrack_bloc.dart';

@immutable
sealed class AudiotrackEvent extends Equatable {
  final BookEntity bookEntity;
  const AudiotrackEvent({required this.bookEntity});
  @override
  List<Object> get props => [];
}

class GetAudiotracksEvent extends AudiotrackEvent {
  const GetAudiotracksEvent({required super.bookEntity});
}