import 'dart:convert';
import 'package:http/http.dart' as http;

import '../consts/api_const.dart';
import '../consts/http_exceptions.dart';
import '../models/news_model.dart';

class NewsApiServices {
  static Future<List<NewsModel>> getAllNews() async {
    try {
      var uri = Uri.https(BASEURL, "v2/everything", {
        "q": "bitcoin",
        "pageSize": "5",
        "domains": "techcrunch.com,",
      });
      var response = await http.get(uri, headers: {
        "x-Api-key": API_KEY,
      });

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
}
