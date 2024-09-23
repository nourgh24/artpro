import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:untitled5/Services/Helper/error_api_handler.dart';
import 'package:untitled5/Services/Network/dio_api_service.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/Favourite%20list/favourity_list_model.dart';

class FavourityListController extends GetxController {
    DioApiService dioApiService = DioApiService();
    Rx<getFavourityState> getfavourityState = getFavourityState.init.obs;

    FavourityListModel?favourityListModel;
      String? message;


    
Future<void> getListFavourity(
  //{ required int artistId}
  ) async {
  //print("getArtistArticles called with artistId: $artistId");
    String apiUrl;
    if (AppSharedPreferences.getRole == 0) {
      apiUrl = UrlsApi.ListFavourityArtistApi;
    } else {
      apiUrl = UrlsApi.ListFavourityUserApi;
    }
    
    try {
      getfavourityState(getFavourityState.loading);
      Response response = await dioApiService.getData(apiUrl,
          options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          favourityListModel = FavourityListModel.fromJson(response.data);

          getfavourityState(getFavourityState.succsesful);
        } else {
          message = response.data['data'];
          getfavourityState(getFavourityState.error);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        getfavourityState(getFavourityState.error);
      } else {
        message = error.toString();
        getfavourityState(getFavourityState.error);
      }
    }
  }


}

enum getFavourityState {
  init,
  succsesful,
  error,
  loading,
}
  