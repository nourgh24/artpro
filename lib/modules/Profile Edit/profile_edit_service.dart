import 'dart:io';

class Editprofile {
  String expertise;
  String specialization;
  String biography;
  String user_name;
  File? image;

  Editprofile({
    required this.expertise,
    required this.specialization,
    required this.biography,
    required this.user_name,
    required this.image,
  });
}
