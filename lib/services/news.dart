import 'dart:convert';

import '../models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/everything?q=tesla&from=2024-05-13&sortBy=publishedAt&apiKey=74b1336fd0164282a93eb782c5d276dd";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    print(jsonData["status"]);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            publishedAt: element["publishedAt"],
            content: element["content"],
          );
          news.add(articleModel);
        }
        ;
      });
    }
  }
}
