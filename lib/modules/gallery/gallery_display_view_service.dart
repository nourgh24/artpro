import 'dart:io';

class Gallery_Details {
  final String title;
  final String desicription;
  final String authorImageUrl;
  final String authorName;
  final String time;
  final List<File> images;

  Gallery_Details({
    required this.title,
    required this.desicription,
    required this.authorImageUrl,
    required this.authorName,
    required this.time,
    required this.images,
  });
}