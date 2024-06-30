// controllers/artist_controller.dart
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart'as g;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:untitled5/modules/certificate%20of%20reliability/certificate_model.dart';
// import 'package:image_picker/image_picker.dart';
import '../../Services/Helper/error_api_handler.dart';
import '../../Services/Network/dio_api_service.dart';
import '../../Services/Network/urls_api.dart';

class ArtistController extends g.GetxController {
  var imagePath1 = ''.obs;
  var imagePath2 = ''.obs;
  var imagePath3 = ''.obs;
  final ImagePicker _picker = ImagePicker();

  DioApiService dioApiService=DioApiService();
  String? message;
  Rx<CertificateState> certificateState=CertificateState.init.obs;

  Future<void> addCertificate({required Certificate certificate}) async {
    
    String storeBy;
    if (AppSharedPreferences.getRole == 0) {
      storeBy = UrlsApi.CertificateApi;
    } else {
      return null;
    }
    final Map<String, dynamic> CERTIFICAte = <String, dynamic>{};
   
    CERTIFICAte['image'] = await MultipartFile.fromFile(
      certificate.image.path,
      filename: certificate.image.path.split('/').last,
    );
     CERTIFICAte['personal_image'] = await MultipartFile.fromFile(
      certificate.personalImage.path,
      filename: certificate.personalImage.path.split('/').last,
    ); 
    CERTIFICAte['another_image'] = await MultipartFile.fromFile(
      certificate.anotherImage.path,
      filename: certificate.anotherImage.path.split('/').last,
    );
    

    FormData certificateFormData = FormData.fromMap(CERTIFICAte);

    try {
      certificateState(CertificateState.loading);
      Response response =
          await dioApiService.postData(storeBy, data: certificateFormData,
           options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data!['success']) {
          certificateState(CertificateState.succsesful);
        } else {
          message = response.data['message'];
          certificateState(CertificateState.error);
          g.Get.snackbar('Error', message!);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        certificateState(CertificateState.error);
      } else {
        message = error.toString();
        certificateState(CertificateState.error);
      }
    }
  }

    

   Future<void> pickImage(int fieldNumber) async {
     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
     if (pickedFile != null) {
       switch (fieldNumber) {
         case 1:
           imagePath1.value = pickedFile.path;
           break;
         case 2:
           imagePath2.value = pickedFile.path;
           break;
         case 3:
           imagePath3.value = pickedFile.path;
           break;
       }
        update();

     }
   }
}

enum CertificateState{
  init,
  succsesful,
  error,
  loading,
}

