import 'package:untitled5/modules/painting%20details/painting_model.dart';

class ArticlesModel {
  List<Result>? articles;
  String? message;
  int? code;

  ArticlesModel({this.articles,this.message, this.code});

  ArticlesModel.fromJson(Map<String, dynamic> json) {
    var list=json['result'][0] as List;
    List<Result>ArticlesList=list.map((i) => Result.fromJson(i)).toList();
    articles=ArticlesList;
    message = json['result'][1];
    code = json['code'];
  }
}
