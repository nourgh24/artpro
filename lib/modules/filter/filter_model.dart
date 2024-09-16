class FilterModel {
  String searchType; // 'فنان', 'عنوان', 'وصف'
  String query;
  String sortBy; // 'السعر', 'التاريخ', 'التقييم'
  String filterType; // نوع الصور

  FilterModel({required this.searchType, required this.query,
   this.sortBy = '', this.filterType = ''});
}
class ArtistSearchModel {
  final int id;
  final String name;
  final String? image;

  ArtistSearchModel({required this.id, required this.name, this.image});

  factory ArtistSearchModel.fromJson(Map<String, dynamic> json) {
    return ArtistSearchModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}

class PaintingSearchModel {
  final int id;
  final String title;
  final String description;
  final String url;
  final String creationDate;
  final ArtistSearchModel artist;
  final TypeSearchModel type;

  PaintingSearchModel({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.creationDate,
    required this.artist,
    required this.type,
  });

  factory PaintingSearchModel.fromJson(Map<String, dynamic> json) {
    return PaintingSearchModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      creationDate: json['creation_date'],
      artist: ArtistSearchModel.fromJson(json['artist']),
      type: TypeSearchModel.fromJson(json['type']),
    );
  }
}

class TypeSearchModel {
  final int id;
  final String typeName;

  TypeSearchModel({required this.id, required this.typeName});

  factory TypeSearchModel.fromJson(Map<String, dynamic> json) {
    return TypeSearchModel(
      id: json['id'],
      typeName: json['type_name'],
    );
  }
}
/////////////////////////////////////
/////////////////////////////
/////////////////////////////////
////////////////////////////
/*class SearchResult {
  final bool success;
  final List<Result> result;
  final String message;
  final int code;

  SearchResult({
    required this.success,
    required this.result,
    required this.message,
    required this.code,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      success: json['success'],
      result: (json['result'][0] as List)
          .map((item) => Result.fromJson(item))
          .toList(),
      message: json['result'][1],
      code: json['code'],
    );
  }
}

class Result {
  final int id;
  final String? name;
  final String? image;
  final String? typeName;
  final String? details;
  final String? createdAt;
  final String? updatedAt;
  final List<Painting>? paintings;

  Result({
    required this.id,
    this.name,
    this.image,
    this.typeName,
    this.details,
    this.createdAt,
    this.updatedAt,
    this.paintings,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      typeName: json['type_name'],
      details: json['details'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      paintings: json['paintings'] != null
          ? (json['paintings'] as List)
              .map((painting) => Painting.fromJson(painting))
              .toList()
          : null,
    );
  }
}

class Painting {
  final int id;
  final String title;
  final String description;
  final String? size;
  final int price;
  final String creationDate;
  final String url;
  final int artistId;
  final int typeId;
  final int? archiveId;
  final int interactionsNumber;
  final int commentsNumber;
  final int ratesNumber;
  final String createdAt;
  final String updatedAt;
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
    this.archiveId,
    required this.interactionsNumber,
    required this.commentsNumber,
    required this.ratesNumber,
    required this.createdAt,
    required this.updatedAt,
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
      creationDate: json['creation_date'],
      url: json['url'],
      artistId: json['artist_id'],
      typeId: json['type_id'],
      archiveId: json['archive_id'],
      interactionsNumber: json['interactions_number'],
      commentsNumber: json['comments_number'],
      ratesNumber: json['rates_number'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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

