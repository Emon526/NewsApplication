import 'package:flutter/material.dart';

import '../models/news_model.dart';
import '../services/news_api.dart';

class NewsProvider with ChangeNotifier {
  List<NewsModel> newList = [];
  List<NewsModel> get getNewsList {
    return newList;
  }

  Future<List<NewsModel>> fatchAllNews(
      {required int pageIndex, required String sortBy}) async {
    newList = await NewsApiServices.getAllNews(page: pageIndex, sortBy: sortBy);
    return newList;
  }
}
