import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:untitled5/modules/painting_home_page/home_page_model.dart';

import '../../Services/Helper/error_api_handler.dart';
import '../../Services/Network/dio_api_service.dart';

class HomePageController extends g.GetxController {

  DioApiService dioApiService = DioApiService();
  Rx<PaintingState> paintingState = PaintingState.init.obs;
  Rx<SinglePaintingState> singlePaintingState = SinglePaintingState.init.obs;
  HomePageModel? homePageModel;
  String? message;


  var artworks = <Artwork>[].obs;
  loadArtworks() {
    artworks.assignAll([
      Artwork(name: 'Painting 1', imageUrl: 'images/4.jpg'),
      Artwork(name: 'Painting 2', imageUrl: 'images/7.jpg'),
      Artwork(name: 'Painting 3', imageUrl: 'images/8.jpg'),
      Artwork(name: 'Painting 4', imageUrl: 'images/9.jpg'),
      Artwork(name: 'Painting 1', imageUrl: 'images/4.jpg'),
      Artwork(name: 'Painting 2', imageUrl: 'images/7.jpg'),
      Artwork(name: 'Painting 3', imageUrl: 'images/8.jpg'),
      Artwork(name: 'Painting 4', imageUrl: 'images/9.jpg'),
      Artwork(name: 'Painting 1', imageUrl: 'images/4.jpg'),
      Artwork(name: 'Painting 2', imageUrl: 'images/7.jpg'),
      Artwork(name: 'Painting 3', imageUrl: 'images/8.jpg'),
      Artwork(name: 'Painting 4', imageUrl: 'images/9.jpg'),
    ]);
  }

  Future<void> getAllPainting() async {
    String apiUrl;
    if (AppSharedPreferences.getRole == 0) {
      apiUrl = "${UrlsApi.homeApi}artist";
    } else {
      apiUrl = UrlsApi.homeApi;
    }
    try {
      paintingState(PaintingState.loading);
      Response response = await dioApiService.getData(apiUrl,
          options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          homePageModel = HomePageModel.fromJson(response.data);
          print("im herer 3");

          paintingState(PaintingState.succsesful);
        } else {
          message = response.data['data'];
          paintingState(PaintingState.error);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        paintingState(PaintingState.error);
      } else {
        message = error.toString();
        paintingState(PaintingState.error);
      }
    }
  }

  Future<void> getOnePainting({required int paintingId}) async {
    try {
      singlePaintingState(SinglePaintingState.loading);
      Response response = await dioApiService.getData(
        "",
      );
      if (response.data != null && response.statusCode == 200) {
        singlePaintingState(SinglePaintingState.succsesful);
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        singlePaintingState(SinglePaintingState.error);
      } else {
        message = error.toString();
        singlePaintingState(SinglePaintingState.error);
      }
    }
  }
}


enum PaintingState {
  init,
  succsesful,
  error,
  loading,
}

enum SinglePaintingState {
  init,
  succsesful,
  error,
  loading,
}

class Artwork {
  final String name;
  final String imageUrl;

  Artwork({required this.name, required this.imageUrl});
}
