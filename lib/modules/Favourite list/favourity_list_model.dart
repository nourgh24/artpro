import 'package:untitled5/modules/articles%20list/add_article_model.dart';

/*class FavourityListModel {
   List<Result>? Favourites;
   String? message;
   int? code;
  FavourityListModel({this.Favourites, this.message, this.code});


  FavourityListModel.fromJson(Map<String, dynamic> json) {
   var list = json['result'][0] as List;
    List<Result> favourityList = list.map((i) => Result.fromJson(i)).toList();
    Favourites = favourityList;
    message = json['result'][1];
    code = json['code'];

}
}

class Result {
  int? id;
  int? elementsNumber;
  int? userId;
  String? userType;
  String? createdAt;
  String? updatedAt;

  Result(
      {this.id,
      this.elementsNumber,
      this.userId,
      this.userType,
      this.createdAt,
      this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    elementsNumber = json['elements_number'];
    userId = json['user_id'];
    userType = json['user_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  
}*/

import 'package:untitled5/modules/articles%20list/add_article_model.dart';

class FavourityListModel {
  List<Result>? favourites;
  String? message;
  int? code;

  FavourityListModel({this.favourites, this.message, this.code});

  FavourityListModel.fromJson(Map<String, dynamic> json) {
    // هنا يتم الوصول إلى الكائن الأول داخل result
    Map<String, dynamic> resultData = json['result'][0];
    // جمع جميع المفضلات في قائمة
    List<Result> favourityList = resultData.entries
        .where((entry) => int.tryParse(entry.key) != null) // تصفية المفاتيح الرقمية
        .map((entry) => Result.fromJson(entry.value)) // تحويل القيم إلى Result
        .toList();
    favourites = favourityList;
    
    // الوصول إلى الرسالة
    message = json['result'][1];
    code = json['code'];
  }
}

class Result {
  int? id;
  String? addingDate;
  int? paintingId;
  int? articleId;
  int? favouriteId;
  String? createdAt;
  String? updatedAt;
  Painting? painting;
  Article? article;

  Result(
      {this.id,
      this.addingDate,
      this.paintingId,
      this.articleId,
      this.favouriteId,
      this.createdAt,
      this.updatedAt,
      this.painting,
      this.article});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addingDate = json['adding_date'];
    paintingId = json['painting_id'];
    articleId = json['article_id'];
    favouriteId = json['favourite_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // التحقق من وجود painting أو article
    painting = json['painting'] != null ? Painting.fromJson(json['painting']) : null;
    article = json['article'] != null ? Article.fromJson(json['article']) : null;
  }
}

class Painting {
  int? id;
  String? title;
  String? description;
  String? size;
  int? price;
  String? creationDate;
  String? url;
  int? artistId;
  int? typeId;
  Artist? artist;
  Type? type;

  Painting({
    this.id,
    this.title,
    this.description,
    this.size,
    this.price,
    this.creationDate,
    this.url,
    this.artistId,
    this.typeId,
    this.artist,
    this.type,
  });

  Painting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    size = json['size'];
    price = json['price'];
    creationDate = json['creation_date'];
    url = json['url'];
    artistId = json['artist_id'];
    typeId = json['type_id'];
    artist = json['artist'] != null ? Artist.fromJson(json['artist']) : null;
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
  }
}

class Artist {
  int? id;
  String? name;
  String? image;

  Artist({this.id, this.name, this.image});

  Artist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}

class Type {
  int? id;
  String? typeName;

  Type({this.id, this.typeName});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['type_name'];
  }
}

class Article {
  int? id;
  String? title;
  String? description;
  String? url;
  String? creationDate;
  Artist? artist;

  Article({
    this.id,
    this.title,
    this.description,
    this.url,
    this.creationDate,
    this.artist,
  });

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    creationDate = json['creation_date'];
    artist = json['artist'] != null ? Artist.fromJson(json['artist']) : null;
  }
}

