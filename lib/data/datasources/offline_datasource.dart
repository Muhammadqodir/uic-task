import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:audiobook_player/core/res/datastate.dart';
import 'package:audiobook_player/data/models/audiotrack_model.dart';
import 'package:audiobook_player/data/models/last_played.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/book_model.dart';

class OfflineDataSource {
  Future<DataState<List<BookModel>>> fetchBooks() async {
    List<dynamic> cachedTracks = jsonDecode(
      (await SharedPreferences.getInstance()).getString("books_list") ?? "[]",
    );
    print("cached books");
    print(cachedTracks);
    List<BookModel> list = List<BookModel>.from(
      cachedTracks.map(
        (e) => BookModel.fromJson(e),
      ),
    );
    return DataState.success(data: list);
  }

  Future<DataState<List<AudiotrackModel>>> fetchAudiotracks(
    String bookId,
  ) async {
    List<dynamic> cachedTracks = jsonDecode(
      (await SharedPreferences.getInstance())
              .getString("${bookId}_audiotracks") ??
          "[]",
    );
    List<AudiotrackModel> list = List<AudiotrackModel>.from(
      cachedTracks.map(
        (e) => AudiotrackModel.fromJson(e),
      ),
    );
    return DataState.success(data: list);
  }

  Future<void> cacheBooks(List<BookModel> books) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(
      "books_list",
      jsonEncode(books),
    );
  }

  Future<void> cacheAudioTracks(
    String bookId,
    List<AudiotrackModel> tracks,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(
      "${bookId}_audiotracks",
      jsonEncode(tracks),
    );
  }

  Future<void> downloadAudiotrack(AudiotrackModel model) async {
    try {
      log("Downloading(${model.title ?? "undefined"})");
      File file = await DefaultCacheManager().getSingleFile(
        model.listenUrl ?? "undefined",
      );
      await addToSavedAudiotracks(model, file);
      log("Downloaded(${file.path})");
      log("DownloadedAbs(${file.absolute.path})");
    } catch (e, s) {
      log("Failed to save audiotrack");
    }
  }

  Future<Map<String, dynamic>> getSavedAudiotracks() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return jsonDecode(
      await preferences.getString("savedAudiotracks") ?? "{}",
    ) as Map<String, dynamic>;
  }

  Future<void> addToSavedAudiotracks(AudiotrackModel model, File file) async {
    Map<String, dynamic> savedAudiotracks = await getSavedAudiotracks();
    savedAudiotracks[model.listenUrl ?? "undefined"] = file.path;
    await (await SharedPreferences.getInstance())
        .setString("savedAudiotracks", jsonEncode(savedAudiotracks));
  }

  Future<DataState<LastPlayed>> getLastPlayed() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String lastPlayedStr = preferences.getString("lastPlayed") ?? "{}";
    if (lastPlayedStr != "{}") {
      return DataState.success(
        data: LastPlayed.fromJson(
          preferences.getString("lastPlayed") ?? "{}",
        ),
      );
    } else {
      return DataState.error(message: "Last played book not found");
    }
  }

  Future<void> saveLastPlayed(LastPlayed lastPlayed) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("lastPlayed", lastPlayed.toJson());
  }

  Future<void> saveLastPlayedPosition(int pos, int index) async {
    DataState<LastPlayed> lastPlayed = await getLastPlayed();
    if (lastPlayed.isSuccess) {
      lastPlayed.data!.positoin = pos;
      lastPlayed.data!.index = index;
      saveLastPlayed(lastPlayed.data!);
    }
  }
}
