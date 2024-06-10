class Comment {
  final int id;
  final String content;
  final int likes;
  final int parentId;
  final List<Comment> replies;
  final String name;
  final String image;


  Comment({
    required this.id,
    required this.content,
    this.likes = 0,
    this.parentId = 0,
    this.replies = const [],
    this.image='',
    this.name='',
  });
}






/*
class Article_Comments {
  final String imageUrl;
  final String authorImageUrl;
  final String authorName;
  final String time;
  final String ArticleComment;
  bool favorited;

  Article_Comments({
    required this.imageUrl,
    required this.authorImageUrl,
    required this.authorName,
    required this.time,
    required this.ArticleComment,
    this.favorited=false,
  });
}*/
/*
class ArticlesCommentsService {
  reportComment(var add_Comment_Controller) async {
  }
}*/