/*class GalleryDisplayModel {
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

*/
class GalleryDisplayModel {
  String? message;
  List<Result>? gallerys;
  int? code;

  GalleryDisplayModel({this.message, this.gallerys, this.code});

  // تعديل لتحليل الـ JSON بشكل صحيح
  GalleryDisplayModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      var galleryData = json['result'][0];  // البيانات الأساسية عن المعرض موجودة في العنصر الأول
      gallerys = [Result.fromJson(galleryData)]; // تحويل الكائن إلى قائمة تحتوي على كائن واحد
      message = json['result'][1];  // الرسالة موجودة في العنصر الثاني
    }
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
