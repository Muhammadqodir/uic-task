// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isDownloaded;
  final String coverUrl;
  final String totalTime;
  final String author;

  const BookEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isDownloaded,
    required this.coverUrl,
    required this.totalTime,
    required this.author,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        deprecated,
        coverUrl,
        totalTime,
        author,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'isDownloaded': isDownloaded,
      'coverUrl': coverUrl,
      'totalTime': totalTime,
      'author': author,
    };
  }

  factory BookEntity.fromMap(Map<String, dynamic> map) {
    return BookEntity(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      isDownloaded: map['isDownloaded'] as bool,
      coverUrl: map['coverUrl'] as String,
      totalTime: map['totalTime'] as String,
      author: map['author'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookEntity.fromJson(String source) => BookEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
