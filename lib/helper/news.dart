import 'dart:convert';

import 'package:newz/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  Future<void> getNews() async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=in&category=general&apiKey=02882695d2a3478c958d59786b7f4d79';
    var response = await http.get(url);
    if (response != null) {
      var data = response.body;
      var decodedData = jsonDecode(data);
      if (decodedData['status'] == 'ok') {
        decodedData['articles'].forEach((element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            ArticleModel article = ArticleModel(
                urlToImage: element['urlToImage'],
                title: element['title'],
                url: element['url'],
                description: element['description'],
                author: element['author'],
                content: element['content'],
                publishedAt: element['publishedAt']);
            news.add(article);
          }
        });
      }
    }
  }
}

class CategoryBasedNews {
  List<ArticleModel> news = [];
  Future<void> getCategoryNews(String category) async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=02882695d2a3478c958d59786b7f4d79';
    var response = await http.get(url);
    if (response != null) {
      var data = response.body;
      var decodedData = jsonDecode(data);
      if (decodedData['status'] == 'ok') {
        decodedData['articles'].forEach((element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            ArticleModel article = ArticleModel(
                urlToImage: element['urlToImage'],
                title: element['title'],
                url: element['url'],
                description: element['description'],
                author: element['author'],
                content: element['content'],
                publishedAt: element['publishedAt']);
            news.add(article);
          }
        });
      }
    }
  }
}
