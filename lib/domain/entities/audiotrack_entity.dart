// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:audio_service/audio_service.dart';

class AudiotrackEntity {
  String id;
  String sectionNumber;
  String title;
  String listenUrl;
  String language;
  String playtime;
  bool isDownloaded;
  String localUrl;
  AudiotrackEntity({
    required this.id,
    required this.sectionNumber,
    required this.title,
    required this.listenUrl,
    required this.language,
    required this.playtime,
    required this.isDownloaded,
    required this.localUrl,
  });

  MediaItem toMediaItem() {
    return MediaItem(
      id: isDownloaded ? localUrl : listenUrl,
      title: title,
      playable: true,
      duration: Duration(
        seconds: int.parse(playtime),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sectionNumber': sectionNumber,
      'title': title,
      'listenUrl': listenUrl,
      'language': language,
      'playtime': playtime,
      'isDownloaded': isDownloaded,
      'localUrl': localUrl,
    };
  }

  factory AudiotrackEntity.fromMap(Map<String, dynamic> map) {
    return AudiotrackEntity(
      id: map['id'] as String,
      sectionNumber: map['sectionNumber'] as String,
      title: map['title'] as String,
      listenUrl: map['listenUrl'] as String,
      language: map['language'] as String,
      playtime: map['playtime'] as String,
      isDownloaded: map['isDownloaded'] as bool,
      localUrl: map['localUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AudiotrackEntity.fromJson(String source) => AudiotrackEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
