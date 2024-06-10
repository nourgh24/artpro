import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'article_comments_service.dart';
class CommentController extends GetxController {
  var comments = <Comment>[].obs;
  RxString name = 'Nour ghanem'.obs;
  RxString image = 'images/13.jpg'.obs;
  RxString time= '12 hours ago'.obs;

  void addComment(String content, {int parentId = 0}) {
    int id = comments.length + 1;
    comments.add(Comment(
        id: id,
        content: content,
        parentId: parentId));
  }

  void deleteComment(int id) {
    comments.removeWhere((comment) => comment.id == id || comment.parentId == id);
  }

  void editComment(int id, String newContent) {
    var index = comments.indexWhere((comment) => comment.id == id);
    if (index != -1) {
      comments[index] = Comment(
        id: comments[index].id,
        content: newContent,
        likes: comments[index].likes,
        parentId: comments[index].parentId,
        replies: comments[index].replies,
      );
    }
  }

  void likeComment(int id) {
    var index = comments.indexWhere((comment) => comment.id == id);
    if (index != -1) {
      comments[index] = Comment(
        id: comments[index].id,
        content: comments[index].content,
        likes: comments[index].likes + 1,
        parentId: comments[index].parentId,
        replies: comments[index].replies,
      );
    }
  }

  List<Comment> getReplies(int parentId) {
    return comments.where((comment) => comment.parentId == parentId).toList();
  }
}








/*
class ArticleCommentsController extends GetxController {
  var article_comments = <Article_Comments>[].obs;
  final add_Comment_Controller = TextEditingController();
  ArticlesCommentsService service = ArticlesCommentsService();

  @override
  void onInit() {
    super.onInit();
    // تحميل البيانات عند بدء التطبيق
    loadArticlesComments();
  }
  void dispose() {
    add_Comment_Controller.dispose();
    super.dispose();
  }
  void reportComment() {
    service.reportComment(add_Comment_Controller);
    // يمكنك هنا إضافة المنطق الخاص بتسجيل الدخول
    print('Add a Comment: ${add_Comment_Controller.text}');
  }

  void loadArticlesComments() {
    //جلب البيانات من مصدر البيانات،
    article_comments.assignAll([
      Article_Comments(
          imageUrl: 'images/4.jpg',
          authorImageUrl: 'images/5.jpg',
          authorName: 'John Doe',
          time: '12 hours ago',
          ArticleComment:
              'rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr'
              'ffffffffffffffffffffffffffffffffffffffffff'
      ),
      Article_Comments(
          imageUrl: 'images/4.jpg',
          authorImageUrl: 'images/5.jpg',
          authorName: 'John Doe',
          time: '12 hours ago',
          ArticleComment:
          'rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr'
              'ffffffffffffffffffffffffffffffffffffffffff'
      ),

      Article_Comments(
          imageUrl: 'images/7.jpg',
          authorImageUrl: 'images/8.jpg',
          authorName: 'John Doe',
          time: '12 hours ago',
          ArticleComment: 'wwwwwwwwwwweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef'
              'ffffffffffffffffffffffffffffffffffffffffff'
              'ffffffffffffffffffffffffffffffffffffffffff'
      ),

      Article_Comments(
          imageUrl: 'images/7.jpg',
          authorImageUrl: 'images/8.jpg',
          authorName: 'John Doe',
          time: '12 hours ago',
          ArticleComment: 'wwwwwwwwwwweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef'
              'nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn'
              'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'
              'wwwwwwwwwwweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef'
              'ffffffffffffffffffffffffffffffffffffffffff'
      ),

      Article_Comments(
          imageUrl: 'images/7.jpg',
          authorImageUrl: 'images/8.jpg',
          authorName: 'John Doe',
          time: '12 hours ago',
          ArticleComment: 'wwwwwwwwwwweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef'
              'wwwwwwwwwwweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef'
              'ffffffffffffffffffffffffffffffffffffffffff'
      ),
    ]);


  }
}
 */