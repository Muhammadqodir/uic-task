import 'package:audiobook_player/core/res/datastate.dart';
import 'package:audiobook_player/data/models/audiotrack_model.dart';
import 'package:dio/dio.dart';

import 'package:xml/xml.dart';
import '../models/book_model.dart';

class OnlineDataSource {
  final String baseUrl = "https://librivox.org/api/feed/audiobooks";
  final dio = Dio();

  Future<DataState<List<BookModel>>> fetchBooks() async {
    try {
      final response = await dio.get(
        'https://librivox.org/api/feed/audiobooks?format=json',
      );
      if (response.statusCode == 200) {
        List<BookModel> list = [];
        for (var element in response.data["books"]) {
          list.add(BookModel.fromJson(element));
        }
        return DataState.success(data: list);
      } else {
        return DataState.error(message: response.statusMessage);
      }
    } on Exception catch (e) {
      return DataState.error(message: e.toString(), error: e);
    }
  }

  Future<DataState<List<AudiotrackModel>>> getAudioTracks(String id) async {
    try {
      final response = await dio.get(
        'https://librivox.org/api/feed/audiotracks?project_id=$id&format=json',
      );
      if (response.statusCode == 200) {
        List<AudiotrackModel> list = [];
        for (var element in response.data["sections"]) {
          list.add(AudiotrackModel.fromJson(element));
          if (list.length > 3) {
            break;
          }
        }
        return DataState.success(data: list);
      } else {
        return DataState.error(message: response.statusMessage);
      }
    } on Exception catch (e) {
      return DataState.error(message: e.toString(), error: e);
    }
  }

  Future<String> getBookCover(String id) async {
    try {
      final response = await dio.get(
        'https://librivox.org/rss/$id',
      );
      if (response.statusCode == 200) {
        final document = XmlDocument.parse(response.data);
        final itunesImage = document
            .findAllElements('image',
                namespace: 'http://www.itunes.com/dtds/podcast-1.0.dtd')
            .firstOrNull;

        if (itunesImage != null) {
          return itunesImage.getAttribute('href').toString();
        } else {
          return "undefined";
        }
      } else {
        return "undefinde";
      }
    } catch (e) {
      return "undefined";
    }
  }
}
