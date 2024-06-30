import 'dart:io';

class ArtistModel {
  String? imagePath1;
  String? imagePath2;
  String? imagePath3;

  ArtistModel({this.imagePath1, this.imagePath2, this.imagePath3});
}

   class Certificate {
     final File image;
     final File personalImage;
    final File anotherImage;
     final String sendDate;
     final int artistId;
     final String updatedAt;
     final String createdAt;
     final int id;

     Certificate({
       required this.image,
       required this.personalImage,
       required this.anotherImage,
       required this.sendDate,
       required this.artistId,
       required this.updatedAt,
       required this.createdAt,
       required this.id,
     });

     factory Certificate.fromJson(Map<String, dynamic> json) {
       return Certificate(
         image: json['image'],
         personalImage: json['personal_image'],
         anotherImage: json['another_image'],
         sendDate: json['send_date'],
         artistId: json['artist_id'],
         updatedAt: json['updated_at'],
         createdAt: json['created_at'],
         id: json['id'],
       );
     }
   }

   class ApiResponse {
     final bool success;
     final List<Certificate> result;
     final String message;
     final int code;

     ApiResponse({
       required this.success,
       required this.result,
       required this.message,
       required this.code,
     });

     factory ApiResponse.fromJson(Map<String, dynamic> json) {
       return ApiResponse(
         success: json['success'],
         result: List<Certificate>.from(json['result'].map((x) => Certificate.fromJson(x))),
         message: json['message'],
         code: json['code'],
       );
     }
   }
   
