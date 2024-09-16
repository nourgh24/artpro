class PaintingModel {
   Result? painting;
   String? message;
   int? code;

  PaintingModel({required this.painting, required this.message, required this.code});

   PaintingModel.fromJson(Map<String, dynamic> json) {
      painting= Result.fromJson(json['result'][0]);
      message= json['result'][1];
      code= json['code'];
  
  }
}

class Result {
  int? id;
  String? title;
  String? description;
  dynamic size;
  dynamic price;
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
    artist = json['artist'] != null ? Artist.fromJson(json['artist']) : null;
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
  }
}


class Artist {
  int? id;
  String? name;
  dynamic userName;
  String? email;
  dynamic emailVerifiedAt;
  dynamic image;
  dynamic expertise;
  dynamic specialization;
  dynamic biography;
  dynamic gender;
  int? followersNumber;
  int? ratesNumber;
  String? createdAt;
  String? updatedAt;

  Artist(
      {this.id,
      this.name,
      this.userName,
      this.email,
      this.emailVerifiedAt,
      this.image,
      this.expertise,
      this.specialization,
      this.biography,
      this.gender,
      this.followersNumber,
      this.ratesNumber,
      this.createdAt,
      this.updatedAt});

  Artist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userName = json['user_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    image = json['image'];
    expertise = json['expertise'];
    specialization = json['specialization'];
    biography = json['biography'];
    gender = json['gender'];
    followersNumber = json['followers_number'];
    ratesNumber = json['rates_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}

class Type {
  int? id;
  String? typeName;
  String? details;
  String? createdAt;
  String? updatedAt;

  Type({this.id, this.typeName, this.details, this.createdAt, this.updatedAt});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['type_name'];
    details = json['details'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}
