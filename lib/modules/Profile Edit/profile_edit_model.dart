class ProfileEditModel {
  String? message;
  Result? ProfileEdit;
  int? code;

  ProfileEditModel({this.message, this.ProfileEdit, this.code});

  ProfileEditModel.fromJson(Map<String, dynamic> json) {
     ProfileEdit= Result.fromJson(json['result'][0]);
      message= json['result'][1];
      code= json['code'];
  
  }
}

class Result {
  int? id;
  String? name;
  String? userName;
  String? email;
  String? emailVerifiedAt;
  String? image;
  String? expertise;
  String? specialization;
  String? biography;
  dynamic? gender;
  dynamic? code;
  dynamic? deviceToken;
  int? followersNumber;
  int? ratesNumber;
  String? createdAt;
  String? updatedAt;

  Result(
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
      this.code,
      this.deviceToken,
      this.followersNumber,
      this.ratesNumber,
      this.createdAt,
      this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
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
    code = json['code'];
    deviceToken = json['device_token'];
    followersNumber = json['followers_number'];
    ratesNumber = json['rates_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
