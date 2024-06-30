import 'dart:io';

class AddArticlee {
  String artistTitle;
  String articleText;
  File articleImage;

  AddArticlee({
    required this.artistTitle,
    required this.articleText,
    required this.articleImage,
  });
}
///////////////////////////////////////
class DeleteArticle{
  String artistTitle;
  String articleText;
  String articleId;
  File articleImage;

  DeleteArticle({
    required this.artistTitle,
    required this.articleText,
    required this.articleImage,
    required this.articleId,
  });
}
////////////////////////////////////////////