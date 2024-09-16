import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:image_picker/image_picker.dart';
import 'package:untitled5/Services/Helper/error_api_handler.dart';
import 'package:untitled5/Services/Network/dio_api_service.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/Profile%20Edit/profile_edit_model.dart';
import 'package:untitled5/modules/Profile%20Edit/profile_edit_service.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';


class ProfileEditController extends g.GetxController {
  DioApiService dioApiService = DioApiService();
  ProfileEditModel?profileditmodel;

  Rx<ProfileEditState> profileditState = ProfileEditState.init.obs;
  String? message;
  final ImagePicker _picker = ImagePicker();
  File? immage;

  

  Future<void> pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final File imageData = File(pickedImage.path);
      immage = imageData;
      update();
    }
  }
  
  Future<void> EditProfile(
    {
     required Editprofile editprofile}
    ) async {
  String updateBy;
  if (AppSharedPreferences.getRole == 0) {
    updateBy = "${UrlsApi.EditProfileArtistApi}";
    } else {
    updateBy = "${UrlsApi.EditProfileUserApi}";
    }
 
  final Map<String, dynamic> editProfile = <String, dynamic>{};
  editProfile['expertise'] = editprofile.expertise;
  editProfile['specialization'] = editprofile.specialization;
    editProfile['image'] = await MultipartFile.fromFile(
    editprofile.image!.path,
    filename: editprofile.image!.path.split('/').last,
    );
  
  editProfile['biography'] = editprofile.biography;
  editProfile['user_name'] = editprofile.user_name;

  FormData EditProfileFormData = FormData.fromMap(editProfile);

  try {
    profileditState(ProfileEditState.loading);
    Response response = await dioApiService.postData(updateBy,data: EditProfileFormData, 
      options: Options(headers: {
        "Authorization": "Bearer ${AppSharedPreferences.getToken}"
      }));

    if (response.data != null && response.statusCode == 200) {
      if (response.data['success']) {
        profileditState(ProfileEditState.succsesful);
      } else {
        message = response.data['data'];
        profileditState(ProfileEditState.error);
        g.Get.snackbar('Error', message!);
      }
    }
  } catch (error) {
    if (error is DioException) {
      message = ErrorApiHandler.getErrorMessage(error);
      profileditState(ProfileEditState.error);
    } else {
      message = error.toString();
      profileditState(ProfileEditState.error);
    }
  }
}
  
}

enum ProfileEditState {
  init,
  succsesful,
  error,
  loading,
}