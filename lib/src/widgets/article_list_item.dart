import 'package:flutter/material.dart';
import '../models/article.dart';

class ArticleListItem extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const ArticleListItem({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(article.title ?? 'not showing data here'),
      subtitle: Text(article.source),
      leading: article.urlToImage != null
          ? Image.network(
        article.urlToImage!,
        width: 72.0,
        height: 72.0,
        fit: BoxFit.contain,
      )
          : Container(
        width: 72.0,
        height: 72.0,
        color: Colors.red,
      ),
      onTap: onTap,
    );
  }
}
