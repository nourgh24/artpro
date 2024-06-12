// controllers/artist_controller.dart
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart'as g;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:image_picker/image_picker.dart';
import '../../Services/Helper/error_api_handler.dart';
import '../../Services/Network/dio_api_service.dart';
import '../../Services/Network/urls_api.dart';

class ArtistController extends g.GetxController {
  var imagePath1 = ''.obs;
  var imagePath2 = ''.obs;
  var imagePath3 = ''.obs;
  // final ImagePicker _picker = ImagePicker();

  DioApiService dioApiService=DioApiService();
  String? message;
  Rx<CertificateState> certificateState=CertificateState.init.obs;
  Future certificate() async {
    try{
      certificateState(CertificateState.loading);
      Response response=await dioApiService.postData( UrlsApi.verifyApi,
          data: {},
          options: Options(
            headers: {
              "Authorization":"Bearer ${AppSharedPreferences.getToken}"
            }
          ));
      if(response.data!=null&&response.statusCode==200){
        certificateState(CertificateState.succsesful);
      }
    }catch(error){
      if (error is DioException){
        message=ErrorApiHandler.getErrorMessage(error);
        certificateState(CertificateState.error);
      }
      else{
        message=error.toString();
        certificateState(CertificateState.error);
      }
    }
  }



  // Future<void> pickImage(int fieldNumber) async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     switch (fieldNumber) {
  //       case 1:
  //         imagePath1.value = pickedFile.path;
  //         break;
  //       case 2:
  //         imagePath2.value = pickedFile.path;
  //         break;
  //       case 3:
  //         imagePath3.value = pickedFile.path;
  //         break;
  //     }
  //   }
  // }
}
enum CertificateState{
  init,
  succsesful,
  error,
  loading,
}

