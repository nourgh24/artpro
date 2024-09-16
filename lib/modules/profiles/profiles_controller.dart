import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:untitled5/Services/Helper/error_api_handler.dart';
import 'package:untitled5/Services/Network/dio_api_service.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/profiles/profiles_controller.dart';
import 'package:untitled5/modules/profiles/profiles_model.dart';

class ProfilesController extends g.GetxController {
  DioApiService dioApiService = DioApiService();
  GetProfilesModel?getprofilesmodel;

  g.Rx<GetProfileState> getprofileState = GetProfileState.init.obs;
  String? message;

  
 Future<void> GetProfile(
  { required int artistId}
  ) async {
  print("getArtistArticles called with artistId: $artistId");
    String apiUrl;
    if (AppSharedPreferences.getRole == 0) {
     apiUrl =  UrlsApi.GetProfileArtistApi;
    } else {
      apiUrl =  UrlsApi. GetProfileUserApi;
    }
    try {
      getprofileState(GetProfileState.loading);
      Response response = await dioApiService.getData("$apiUrl",
          options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          getprofilesmodel = GetProfilesModel.fromJson(response.data);

          getprofileState(GetProfileState.succsesful);
        } else {
          message = response.data['data'];
          getprofileState(GetProfileState.error);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        getprofileState(GetProfileState.error);
      } else {
        message = error.toString();
        getprofileState(GetProfileState.error);
      }
    }
}
}

enum GetProfileState {
  init,
  succsesful,
  error,
  loading,
}