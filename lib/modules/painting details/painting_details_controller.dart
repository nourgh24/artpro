import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:untitled5/Services/Helper/error_api_handler.dart';
import 'package:untitled5/Services/Network/dio_api_service.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/painting%20details/painting_details_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as g;
import 'package:untitled5/modules/painting%20details/painting_model.dart';

class PaintingDetailsController extends g.GetxController {
    DioApiService dioApiService = DioApiService();

  RxBool showDetails = false.obs;
  RxBool isFavorite = false.obs;
  RxBool isLike=false.obs;
  RxBool isDisLike=false.obs;
  RxString imageDescription = ''
      'Image Description :duuif dbfjsj uie ufuo yuyue yugd yusgyufyu ysgdyu '
      'Image Description :duuif dbfjsj uie ufuo yuyue yugd yusgyufyu ysgdyu '
      'Image Description :duuif dbfjsj uie ufuo yuyue yugd yusgyufyu ysgdyu'.obs;
  RxString imageType = 'Panoramic'.obs;
  RxString title = 'Panoramic'.obs;
  RxString artist = 'Nour ghanem'.obs;
  RxDouble imagePrice = 99.99.obs;
  RxString time= '12 hours ago'.obs;
  RxString imageUrl= 'images/13.jpg'.obs;
  RxString authorImageUrl= 'images/5.jpg'.obs;
  RxString size="200 x 160".obs;
  var details = <Details>[].obs;
  PaintingModel? paintingsModel;
    Rx<PaintingDetailsState> paintingDetailsState = PaintingDetailsState.init.obs;
  String? message;

  var rating = 0.0.obs;
  var totalRating = 4.5.obs;

  @override
  void onInit() {
  super.onInit();
  // تحميل البيانات عند بدء التطبيق
  loadArticles();
  }
  void updateRating(double newRating) {
    rating.value = newRating;
  }

  void loadArticles() {
    details.assignAll([
    Details(
  title: 'Article 1',
  imageUrl: 'images/13.jpg',
  authorImageUrl: 'images/5.jpg',
  time: '12 hours ago',
    ),
    ],
  );
    }
  void toggleShowDetails() {
    showDetails.toggle();
  }

  void toggleFavorite() {
    isFavorite.toggle();
    isLike.toggle();
    isDisLike.toggle();
  }



   Future<void> getPaintingDetails({required int paintingId}) async {
    try {
      paintingDetailsState(PaintingDetailsState.loading);
      Response response = await dioApiService.postData("${UrlsApi.paintingDetailsApi}$paintingId",
          options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
  
        if (response.data['success']) {
          
          paintingsModel = PaintingModel.fromJson(response.data);
          print("im here");

          paintingDetailsState(PaintingDetailsState.succsesful);
        } else {
          message = response.data['data'];
          paintingDetailsState(PaintingDetailsState.error);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        paintingDetailsState(PaintingDetailsState.error);
      } else {
        message = error.toString();
        paintingDetailsState(PaintingDetailsState.error);
      }
    }
  }
}
enum PaintingDetailsState {
  init,
  succsesful,
  error,
  loading,
}

