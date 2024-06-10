class Article {
  final String title;
  final String imageUrl;
  final String authorImageUrl;
  final String authorName;
  final String time;
  bool favorited;

  Article({
    required this.title,
    required this.imageUrl,
    required this.authorImageUrl,
    required this.authorName,
    required this.time,
    this.favorited=false,
  });

}