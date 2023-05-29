import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/article.dart';
import '../screens/article_screen.dart';
import '../services/news_services.dart';
import '../screens/login_screen.dart'; // Import your LoginScreen here

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Article> articles = [];
  bool isLoggedIn = false; // Store the login state

  @override
  void initState() {
    super.initState();
    checkLoginState(); // Check the login state
  }

  void checkLoginState() async {
    User? user = FirebaseAuth.instance.currentUser;
    if(mounted){
      setState(() {
        isLoggedIn = user != null;
      });
    }
    if (isLoggedIn) {
      fetchNews(); // If logged in, fetch the news
    }
  }

  void fetchNews() async {
    try {
      final List<Article> fetchedArticles = await NewsService().fetchTopHeadlines();
      if(mounted) {
        setState(() {
          articles = fetchedArticles;
        });
      }
      } catch (e) {
      print('Error 1: $e');
    }
  }


  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoggedIn) {
      // If not logged in, show the login options
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black54,
          title: const Text('Headlines 💡'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Please log in to view the news',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: const Text('Log in'),
              ),
            ],
          ),
        ),
      );
    } else {
      // If logged in, show the news
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black54,
          title: const Text('Headlines 💡'),
          actions: [
            IconButton(
              onPressed: logout,
              icon: const Icon(Icons.logout),
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
                titleAlignment: ListTileTitleAlignment.threeLine,
                leading: article.urlToImage != null
                    ? Image.network(
                  article.urlToImage!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, exception, stackTrace) {
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
}
