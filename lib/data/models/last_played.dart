// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:audiobook_player/data/models/book_model.dart';
import 'package:audiobook_player/domain/entities/audiotrack_entity.dart';
import 'package:audiobook_player/domain/entities/book_entity.dart';

class LastPlayed {
  BookEntity bookEntity;
  List<AudiotrackEntity> list;
  int index;
  int positoin;
  LastPlayed({
    required this.bookEntity,
    required this.list,
    required this.index,
    required this.positoin,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bookEntity': bookEntity.toMap(),
      'list': list.map((x) => x.toMap()).toList(),
      'index': index,
      'positoin': positoin,
    };
  }

  factory LastPlayed.fromMap(Map<String, dynamic> map) {
    return LastPlayed(
      bookEntity: BookEntity.fromMap(map['bookEntity'] as Map<String,dynamic>),
      list: List<AudiotrackEntity>.from((map['list'] as List<dynamic>).map<AudiotrackEntity>((x) => AudiotrackEntity.fromMap(x as Map<String,dynamic>),),),
      index: map['index'] as int,
      positoin: map['positoin'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LastPlayed.fromJson(String source) => LastPlayed.fromMap(json.decode(source) as Map<String, dynamic>);
}
