class Articles_Details {
  final String title;
  final String imageUrl;
  final String authorImageUrl;
  final String authorName;
  final String time;
  final String ArticleText;
  bool favorited;

  Articles_Details({
    required this.title,
    required this.imageUrl,
    required this.authorImageUrl,
    required this.authorName,
    required this.time,
    required this.ArticleText,
    this.favorited=false,
  });
}

class ArticlesDetailsService{

  reportComment(var add_Comment_Controller ) async{
    }
}