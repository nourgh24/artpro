
class GalleryListModel {

   List<Result>? Gallerys;
   String? message;
   int? code;

  GalleryListModel({this.Gallerys, this.message, this.code});

  GalleryListModel.fromJson(Map<String, dynamic> json) {
    var list = json['result'][0] as List;
    List<Result> paintingsList = list.map((i) => Result.fromJson(i)).toList();
    Gallerys = paintingsList;
    message = json['result'][1];
    code = json['code'];

}
}

class Result {
  int? id;
  String? name;
  String? creationDate;
  String? details;
  int? artistId;
  String? createdAt;
  String? updatedAt;
  Artist? artist;

  Result(
      {this.id,
      this.name,
      this.creationDate,
      this.details,
      this.artistId,
      this.createdAt,
      this.updatedAt,
      this.artist});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    creationDate = json['creation_date'];
    details = json['details'];
    artistId = json['artist_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    artist =
        json['artist'] != null ?  Artist.fromJson(json['artist']) : null;
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
