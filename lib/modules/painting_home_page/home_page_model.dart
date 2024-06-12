import 'package:untitled5/modules/painting%20details/painting_model.dart';

class HomePageModel {
  List<Result>? paintings;
  String? message;
  int? code;

  HomePageModel({this.paintings, this.message, this.code});

  HomePageModel.fromJson(Map<String, dynamic> json) {
    var list = json['result'][0] as List;
    List<Result> paintingsList = list.map((i) => Result.fromJson(i)).toList();
    paintings = paintingsList;
    message = json['result'][1];
    code = json['code'];
  }
}



