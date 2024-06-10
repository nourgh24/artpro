class Details {
  final String title;
  final String imageUrl;
  final String authorImageUrl;

  final String time;
  bool favorited;

  Details({
    required this.title,
    required this.imageUrl,
    required this.authorImageUrl,
    required this.time,
    this.favorited=false,
  });
}