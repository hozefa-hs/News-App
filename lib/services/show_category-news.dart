import 'dart:convert';

import 'package:news_app_flutter/models/show_category.dart';
import 'package:news_app_flutter/models/slider_model.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ShowCategoryNews {
  List<ShowCategoryModel> categories = [];

  Future<void> getCategoryNews(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=74b1336fd0164282a93eb782c5d276dd";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    print(jsonData["status"]);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ShowCategoryModel categoryModel = ShowCategoryModel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            publishedAt: element["publishedAt"],
            content: element["content"],
          );
          categories.add(categoryModel);
        };
      });
    }
  }
}
