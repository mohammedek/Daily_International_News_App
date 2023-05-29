import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import '../models/article.dart';
class ArticleScreen extends StatelessWidget {
  final Article article;

  const ArticleScreen({Key? key, required this.article}) : super(key: key);

  void _launchURL() async {
    final String url = article.url;
    print('URL $url');
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }else {
      // print(article.url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          article.title ?? 'Error on this page',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (article.urlToImage != null) Image.network(article.urlToImage!),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
              child: Text(
                article.content ?? article.title,style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
                ),
              ),
      Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: InkWell(
        onTap: _launchURL,
        child: const Text(
          'Go To the link to see more',
          style:  TextStyle(
            fontSize: 16,
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      ) ],
        ),
      ),
    );
  }
}
