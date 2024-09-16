
///////////////////زابط نوعا ما بدون تنفيذ
import 'package:get/get.dart' as g;
import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:untitled5/Services/Helper/error_api_handler.dart';
import 'package:untitled5/Services/Network/dio_api_service.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/filter/filter_model.dart';

class FilterController extends g.GetxController {
  var searchQuery = ''.obs;
  var searchResults = <dynamic>[].obs;
  var isLoading = false.obs;
  DioApiService dioApiService = DioApiService();
  Rx<FilterState> filterState = FilterState.init.obs;
  var message = ''.obs;

  Future<void> search({required String query, required String searchType}) async {
    String apiUrl;
    Map<String, dynamic> queryParams = {};

    switch (searchType) {
      case 'Artist_Name':
        apiUrl = "${UrlsApi.SearchApi}searchForArtist?";
        queryParams = {'contains[name]': query};
        break;
      case 'Title':
       apiUrl = "${UrlsApi.SearchApi}searchForPainting?";
        queryParams = {'contains[title]': query};
        break;
      case 'Description':
        apiUrl = "${UrlsApi.SearchApi}searchForPainting?";
        queryParams = {'contains[description]': query};
       //queryParams = {'contains[description]': query.replaceFirst("description:", "")};
        break;
      case 'Evaluation':
      case 'Price':
      case 'Date':
        apiUrl = "${UrlsApi.SearchApi}searchForType";
        queryParams = {'exact[id]': query};
        break;
      default:
        message.value = "Invalid search type";
        filterState(FilterState.error);
        return;
    }

    try {
      filterState(FilterState.loading);
      Response response = await dioApiService.postData(
        
        apiUrl,
        options: Options(
          headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          },
        ),
        queryParameters: queryParams,
      );

      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          var results = response.data['result'];
          searchResults.value = results.map((item) {
            if (item['title'] != null ) {
              return PaintingSearchModel.fromJson(item);
            }
              else if ( item['description'] != null) {
              return PaintingSearchModel.fromJson(item);
            }
             
           else if (item['name'] != null) {
              return ArtistSearchModel.fromJson(item);
            }
             else if (item['type_name'] != null) {
              return TypeSearchModel.fromJson(item);
            }
            return null;
          }).where((item) => item != null).toList();
          filterState(FilterState.successful);
        } else {
          message.value = response.data['data'];
          filterState(FilterState.error);
        }
      }
    } catch (error) {
      if (error is DioError) {
        message.value = ErrorApiHandler.getErrorMessage(error);
        filterState(FilterState.error);
      } else {
        message.value = error.toString();
        filterState(FilterState.error);
      }
    }
  }
}

enum FilterState {
  init,
  successful,
  error,
  loading,
}
