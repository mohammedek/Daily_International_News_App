import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/article.dart';

class NewsService {
  Future<List<Article>> fetchTopHeadlines() async {
    const apiKey = '6fd45e45a140455eb512cf56660c54d6';
    const url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      print(jsonData);
      final articleList = jsonData['articles'] as List;
      final List<Article> fetchedArticles = articleList
          .map((articleJson) => Article.fromJson(articleJson))
          .toList();
      return fetchedArticles;
    }
    else {
      throw Exception('Failed to fetch top headlines');
    }
  }
}