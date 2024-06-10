
class gallery_list {
  final String title;
  final String authorImageUrl;
  final String authorName;
  final String time;
  final String imageUrl;


  gallery_list({
    required this.title,
    required this.authorImageUrl,
    required this.authorName,
    required this.time,
    required this.imageUrl,

  });
}

class ColorFilters{
  static final greyscale=ColorFilters.matrix(<double>[
    0.2126, 0.7152, 0.0722, 0,0,
    0.2126, 0.7152, 0.0722, 0,0,
    0.2126, 0.7152, 0.0722, 0,0,
    0,0,0,1,0
  ]);

  static matrix(List<double> list) {}
}