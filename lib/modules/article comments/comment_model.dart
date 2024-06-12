class CommentModel {
  bool? success;
  List<Comment>? comment;
  String? message;
  int? code;

  CommentModel({this.comment, this.message, this.code});

  CommentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    var list = json['result'][0] as List;
    List<Comment> commentList = list.map((i) => Comment.fromJson(i)).toList();
    comment = commentList;
    message = json['result'][1];
    code = json['code'];
  }
}

class Comment {
  int? id;
  String? commentText;
  String? date;
  int? userId;
  int? articleId;
  int? paintingId;
  String? userType;
  String? createdAt;
  String? updatedAt;
  String? formattedCreationDate;
  User? user;

  Comment(
      {this.id,
      this.commentText,
      this.date,
      this.userId,
      this.articleId,
      this.paintingId,
      this.userType,
      this.createdAt,
      this.updatedAt,
      this.formattedCreationDate,
      this.user});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commentText = json['comment_text'];
    date = json['date'];
    userId = json['user_id'];
    if (json['article_id'] != null) {
      articleId = json['article_id'];
    }
    if (json['painting_id'] != null) {
      paintingId = json['painting_id'];
    }
    userType = json['user_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    formattedCreationDate = json['formatted_creation_date'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? name;
  String? image;

  User({this.id, this.name, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
