import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../consts/api_const.dart';
import '../models/bookmark_model.dart';
import '../models/news_model.dart';
import '../services/news_api.dart';

class BookMarkProvider with ChangeNotifier {
  List<BookMarkModel> bookMarkList = [];
  List<BookMarkModel> get getBookMarkList {
    return bookMarkList;
  }

  Future<List<BookMarkModel>> fatchBookmarks() async {
    bookMarkList = await NewsApiServices.getBookmarks() ?? [];
    // notifyListeners();
    return bookMarkList;
  }

  Future<void> addToBookmark({required NewsModel newsModel}) async {
    try {
      var uri = Uri.https(BASEURL_FIREBASE, "bookmarks.json");
      var response = await http.post(uri,
          body: json.encode(
            newsModel.toJson(),
          ));
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteBookmark() async {
    try {
      var uri =
          Uri.https(BASEURL_FIREBASE, "bookmarks/-N7bH4DQZAxXdjYTBiIn.json");
      var response = await http.delete(
        uri,
      );
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
    } catch (error) {
      rethrow;
    }
  }
}
