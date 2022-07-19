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
    return NewsModel(
        newsId: json["source"]["id"] ?? "",
        sourceName: json["source"]["name"] ?? "",
        authorName: json["author"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        url: json["url"] ?? "",
        utlToImage: json["urlToImage"] ?? "",
        publishedAt: json["publishedAt"] ?? "",
        content: json["content"] ?? "",
        dateToShow: "dateToShow",
        readingTimeText: "readingTimeText");
  }
  static List<NewsModel> newsFromSnapshot(List newSnapshot) {
    return newSnapshot.map((e) {
      return NewsModel.fromJson(e);
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
}
