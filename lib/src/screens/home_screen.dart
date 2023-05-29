import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/article.dart';
import '../screens/article_screen.dart';
import '../services/news_services.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  void fetchNews() async {
    try {
      final List<Article> fetchedArticles =
      await NewsService().fetchTopHeadlines();
      setState(() {
        articles = fetchedArticles;
      });
    } catch (e) {
      print('Error 1: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black54,
        title: const Text('Headlines 💡'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              // contentPadding: EdgeInsets.all(10),
              titleAlignment: ListTileTitleAlignment.threeLine,
              leading: article.urlToImage != null
                  ? Image.network(
                article.urlToImage!,
                fit: BoxFit.cover,
                errorBuilder: (context, exception, stackTrace) {
                  // Handle image loading error
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey,
                    child: const Center(
                      child: Icon(Icons.error),
                    ),
                  );
                },
              )
                  : Container(),
              title: Text(
                article.title.trim() ?? 'No title available',
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleScreen(article: article),
                  ),
                );
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            thickness: 1,
            endIndent: 1,
            indent: 1,
          );
        },
      ),
    );
  }
}
