class Article {
  String? author;
  String? url;
  String? imageUrl;
  String? title;
  String? publishedAt;
  String? content;
  String? description;

  bool isSaved;

  Article({
    required this.isSaved,
    required this.author,
    required this.publishedAt,
    required this.content,
    required this.imageUrl,
    required this.url,
    required this.description,
    required this.title,
  });
}
