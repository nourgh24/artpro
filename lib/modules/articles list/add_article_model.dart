
class getArticlemodel {
  List<Result>? Articles;
   String? message;
   int? code;
  getArticlemodel({this.Articles, this.message, this.code});

  getArticlemodel.fromJson(Map<String, dynamic> json) {
     
      var list = json['result'][0] as List;
    List<Result> paintingsList = list.map((i) => Result.fromJson(i)).toList();
    Articles = paintingsList;
    message = json['result'][1];
    code = json['code'];
  }

 
}

class Result {
  int? id;
  String? title;
  String? description;
  String? url;
  String? creationDate;
  int? artistId;
  int? interactionsNumber;
  int? commentsNumber;
  String? createdAt;
  String? updatedAt;
  String? formattedCreationDate;
  Artist? artist;

  Result(
      {this.id,
      this.title,
      this.description,
      this.url,
      this.creationDate,
      this.artistId,
      this.interactionsNumber,
      this.commentsNumber,
      this.createdAt,
      this.updatedAt,
      this.formattedCreationDate,
      this.artist});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    creationDate = json['creation_date'];
    artistId = json['artist_id'];
    interactionsNumber = json['interactions_number'];
    commentsNumber = json['comments_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    formattedCreationDate = json['formatted_creation_date'];
    artist =
        json['artist'] != null ? new Artist.fromJson(json['artist']) : null;
  }

}

class Artist {
  int? id;
  String? name;
  dynamic image;

  Artist({this.id, this.name, this.image});

  Artist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
