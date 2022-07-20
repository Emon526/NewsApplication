import 'package:reading_time/reading_time.dart';

import '../services/global_methods.dart';

class NewsModel {
  String newsId,
      sourceName,
      authorName,
      title,
      description,
      url,
      utlToImage,
      publishedAt,
      dateToShow,
      content,
      readingTimeText;
  NewsModel({
    required this.newsId,
    required this.sourceName,
    required this.authorName,
    required this.title,
    required this.description,
    required this.url,
    required this.utlToImage,
    required this.publishedAt,
    required this.content,
    required this.dateToShow,
    required this.readingTimeText,
  });
  factory NewsModel.fromJson(dynamic json) {
    String title = json["title"] ?? "";
    String content = json["content"] ?? "";
    String description = json["description"] ?? "";

    String dateToShow = "";
    if (json["publishedAt"] != null) {
      dateToShow = GlobalMethods.formattedDateText(json["publishedAt"]);
    }
    return NewsModel(
        newsId: json["source"]["id"] ?? "",
        sourceName: json["source"]["name"] ?? "",
        authorName: json["author"] ?? "",
        title: title,
        description: description,
        url: json["url"] ?? "",
        utlToImage: json["urlToImage"] ?? "",
        publishedAt: json["publishedAt"] ?? "",
        content: content,
        dateToShow: dateToShow,
        readingTimeText: readingTime(title + description + content).msg);
  }
  static List<NewsModel> newsFromSnapshot(List newSnapshot) {
    return newSnapshot.map((jsondata) {
      return NewsModel.fromJson(jsondata);
    }).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["NewsId"] = newsId;
    data["sourceName"] = sourceName;
    data["authorName"] = authorName;
    data["title"] = title;
    data["description"] = description;
    data["url"] = url;
    data["utlToImage"] = utlToImage;
    data["publishedAt"] = publishedAt;
    data["dateToShow"] = dateToShow;
    data["content"] = content;
    data["readingTimeText"] = readingTimeText;
    return data;
  }
  //   @override
  // String toString() {
  //   return "news {newsId:$newsId}";
  // }
}
