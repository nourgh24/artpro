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
