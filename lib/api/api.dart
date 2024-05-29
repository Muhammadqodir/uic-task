import 'package:audiobook/models/book.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

class Api {
  final dio = Dio();
  Future<ApiResponse<List<AudioBook>>> getBooksList() async {
    final response = await dio.get(
      'https://librivox.org/api/feed/audiobooks?format=json',
    );
    if (response.statusCode == 200) {
      List<AudioBook> list = [];
      for (var element in response.data["books"]) {
        list.add(AudioBook.fromJson(element));
      }
      return ApiResponse.success(data: list);
    } else {
      return ApiResponse.error(message: response.data["error"]);
    }
  }

  Future<String> getBookCover(String id) async {
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
  }
}

class ApiResponse<T> {
  String message;
  String title;
  T? data;
  bool isSuccess;
  ApiResponse({
    required this.title,
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  ApiResponse.success({
    this.isSuccess = true,
    this.message = "success",
    this.title = "success",
    required this.data,
  });

  ApiResponse.error({
    this.isSuccess = false,
    required this.message,
    this.title = "Error",
    this.data,
  });
}
