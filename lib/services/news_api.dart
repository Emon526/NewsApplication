import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../consts/api_const.dart';
import '../consts/http_exceptions.dart';
import '../models/bookmark_model.dart';
import '../models/news_model.dart';

class NewsApiServices {
  static Future<List<NewsModel>> getAllNews(
      {required int page, required String sortBy}) async {
    try {
      var uri = Uri.https(BASEURL, "v2/everything", {
        "q": "bitcoin",
        "pageSize": "5",
        "domains": "techcrunch.com,",
        "page": page.toString(),
        "sortBy": sortBy,
      });
      var response = await http.get(uri, headers: {
        "x-Api-key": API_KEY,
      });
      log("Response Code : ${response.statusCode}");
      Map data = jsonDecode(response.body);
      List newsTemplist = [];
      if (data['code'] != null) {
        throw HttpExceptions(data['code']);
        // for showing using status code
        // throw HttpExceptions(response.statusCode.toString());
      }
      for (var i in data["articles"]) {
        newsTemplist.add(i);
      }
      return NewsModel.newsFromSnapshot(newsTemplist);
    } catch (error) {
      throw error.toString();
    }
  }

  static Future<List<NewsModel>> getTopHeadlines() async {
    try {
      var uri = Uri.https(BASEURL, "v2/top-headlines", {'country': 'us'});
      var response = await http.get(uri, headers: {
        "x-Api-key": API_KEY,
      });
      // log("Response Code : ${response.statusCode}");
      Map data = jsonDecode(response.body);
      List newsTemplist = [];
      if (data['code'] != null) {
        throw HttpExceptions(data['code']);
        // for showing using status code
        // throw HttpExceptions(response.statusCode.toString());
      }
      for (var i in data["articles"]) {
        newsTemplist.add(i);
      }
      return NewsModel.newsFromSnapshot(newsTemplist);
    } catch (error) {
      throw error.toString();
    }
  }

  static Future<List<NewsModel>> searchNews({required String query}) async {
    try {
      var uri = Uri.https(BASEURL, "v2/everything", {
        "q": query,
        "pageSize": "10",
        "domains": "techcrunch.com,",
      });
      var response = await http.get(uri, headers: {
        "x-Api-key": API_KEY,
      });
      log("Response Code : ${response.statusCode}");
      Map data = jsonDecode(response.body);
      List newsTemplist = [];
      if (data['code'] != null) {
        throw HttpExceptions(data['code']);
        // for showing using status code
        // throw HttpExceptions(response.statusCode.toString());
      }
      for (var i in data["articles"]) {
        newsTemplist.add(i);
      }
      return NewsModel.newsFromSnapshot(newsTemplist);
    } catch (error) {
      throw error.toString();
    }
  }

  static Future<List<BookMarkModel>?> getBookmarks() async {
    try {
      var uri = Uri.https(BASEURL_FIREBASE, "bookmarks.json");
      var response = await http.get(
        uri,
      );
      // log('Response status: ${response.statusCode}');
      // log('Response body: ${response.body}');
      Map data = jsonDecode(response.body);
      List allKeys = [];
      if (data['code'] != null) {
        throw HttpExceptions(data['code']);
        // for showing using status code
        // throw HttpExceptions(response.statusCode.toString());
      }
      for (String key in data.keys) {
        allKeys.add(key);
      }
      log("allkeys = $allKeys");
      return BookMarkModel.bookmarksFromSnapshot(json: data, allKeys: allKeys);
    } catch (error) {
      rethrow;
    }
  }
}
