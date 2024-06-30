class GalleryDisplayModel {
  String? message;
  List<Result>? gallerys;
  int? code;

  GalleryDisplayModel({this.message, this.gallerys, this.code});

  GalleryDisplayModel.fromJson(Map<String, dynamic> json) {
    var list = json['result'][0] as List; 

    List<Result> resultsList = list.map((i) => Result.fromJson(i)).toList();
    gallerys = resultsList;
    message = json['result'][1];
    code = json['code']; 
  }
}

class Result {
  int? id;
  String? name;
  String? details;
  String? creationDate;
  String? formattedCreationDate;
  int? artistId;
  String? createdAt;
  String? updatedAt;
  List<Paintings>? paintings;

  Result({
    this.id,
    this.name,
    this.details,
    this.creationDate,
    this.formattedCreationDate,
    this.artistId,
    this.createdAt,
    this.updatedAt,
    this.paintings,
  });

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    details = json['details'];
    creationDate = json['creation_date'];
    formattedCreationDate = json['formatted_creation_date'];
    artistId = json['artist_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['paintings'] != null) {
      paintings = <Paintings>[];
      json['paintings'].forEach((v) {
        paintings!.add(Paintings.fromJson(v));
      });
    }
  }
}

class Paintings {
  int? id;
  String? title;
  String? description;
  String? size;
  int? price;
  String? creationDate;
  String? url;
  int? artistId;
  int? typeId;
  int? archiveId;
  int? interactionsNumber;
  int? commentsNumber;
  int? ratesNumber;
  String? createdAt;
  String? updatedAt;
  Artist? artist;
  Type? type;

  Paintings({
    this.id,
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
    this.artist,
    this.type,
  });

  Paintings.fromJson(Map<String, dynamic> json) {
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
    artist = json['artist'] != null ? Artist.fromJson(json['artist']) : null;
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
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


///////////////////////////
///
///
/*
class Result {
  final int id;
  final String name;
  final String details;
  final DateTime creationDate;
  final int artistId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final List<Painting> paintings;

  Result({
    required this.id,
    required this.name,
    required this.details,
    required this.creationDate,
    required this.artistId,
    required this.updatedAt,
    required this.createdAt,
    required this.paintings,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    var list = json['paintings'] as List;
    List<Painting> paintingsList = list.map((i) => Painting.fromJson(i)).toList();

    return Result(
      id: json['id'],
      name: json['name'],
      details: json['details'],
      creationDate: DateTime.parse(json['creation_date']),
      artistId: json['artist_id'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      paintings: paintingsList,
    );
  }

  
}

class Painting {
  final int id;
  final String title;
  final String description;
  final String? size;
  final int price;
  final DateTime creationDate;
  final String url;
  final int artistId;
  final int typeId;
  final int archiveId;
  final int interactionsNumber;
  final int commentsNumber;
  final int ratesNumber;
  final Artist artist;
  final Type type;

  Painting({
    required this.id,
    required this.title,
    required this.description,
    this.size,
    required this.price,
    required this.creationDate,
    required this.url,
    required this.artistId,
    required this.typeId,
    required this.archiveId,
    required this.interactionsNumber,
    required this.commentsNumber,
    required this.ratesNumber,
    required this.artist,
    required this.type,
  });

  factory Painting.fromJson(Map<String, dynamic> json) {
    return Painting(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      size: json['size'],
      price: json['price'],
      creationDate: DateTime.parse(json['creation_date']),
      url: json['url'],
      artistId: json['artist_id'],
      typeId: json['type_id'],
      archiveId: json['archive_id'],
      interactionsNumber: json['interactions_number'],
      commentsNumber: json['comments_number'],
      ratesNumber: json['rates_number'],
      artist: Artist.fromJson(json['artist']),
      type: Type.fromJson(json['type']),
    );
  }

}

class Artist {
  final int id;
  final String name;
  final String? image;

  Artist({
    required this.id,
    required this.name,
    this.image,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

 
}

class Type {
  final int id;
  final String typeName;

  Type({
    required this.id,
    required this.typeName,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      id: json['id'],
      typeName: json['type_name'],
    );
  }

}*/
