class Article {
  final String source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: json['source']?['name'] ?? 'Name',
      author: json['author'] ?? 'Author',
      title: json['title'] ?? 'Title',
      description: json['description'] ?? 'Description',
      url: json['url'] ?? 'Url ',
      urlToImage: json['urlToImage'] ?? 'imageUrl',
      publishedAt: json['publishedAt'] ?? 'published at',
      content: json['content'],
    );
  }
}
