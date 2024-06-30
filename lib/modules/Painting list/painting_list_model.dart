import 'dart:ffi';

class PaintingListModel {
  String? message;
  List<Result>? Paintings;
  int? code;

  PaintingListModel({this.message, this.Paintings, this.code});

  PaintingListModel.fromJson(Map<String, dynamic> json) {
   
    var list = json['result'][0] as List;
    List<Result> paintingsList = list.map((i) => Result.fromJson(i)).toList();
    Paintings = paintingsList;
    message = json['result'][1];
    code = json['code'];
  }


}

class Result {
  int? id;
  String? title;
  String? description;
  String? size;
  int? price;
  String? creationDate;
  String? url;
  int? artistId;
  int? typeId;
  dynamic archiveId;
  int? interactionsNumber;
  int? commentsNumber;
  int? ratesNumber;
  String? createdAt;
  String? updatedAt;
  String? formattedCreationDate;
  Artist? artist;
  Type? type;

  Result(
      {this.id,
      this.title,
      this.description,
      this.size,
      this.price,
      this.creationDate,
      this.url,
      this.artistId,
      this.typeId,
      this.archiveId,
      this.interactionsNumber,
      this.commentsNumber,
      this.ratesNumber,
      this.createdAt,
      this.updatedAt,
      this.formattedCreationDate,
      this.artist,
      this.type});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    size = json['size'];
    price = json['price'];
    creationDate = json['creation_date'];
    url = json['url'];
    artistId = json['artist_id'];
    typeId = json['type_id'];
    archiveId = json['archive_id'];
    interactionsNumber = json['interactions_number'];
    commentsNumber = json['comments_number'];
    ratesNumber = json['rates_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    formattedCreationDate = json['formatted_creation_date'];
    artist =
        json['artist'] != null ? new Artist.fromJson(json['artist']) : null;
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
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

class Type {
  int? id;
  String? typeName;

  Type({this.id, this.typeName});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['type_name'];
  }
}
