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
    Rx<PaintingComplaintState> paintingcomplaintState = PaintingComplaintState.init.obs;
    Rx<PaintingliketState> paintinglikeState = PaintingliketState.init.obs;
    Rx<PaintingDislikeState> paintingdislikeState = PaintingDislikeState.init.obs;
    Rx<PaintingFavouriteState> paintingfavouriteState = PaintingFavouriteState.init.obs;
    Rx<ArticleFavouriteState> articlefavouriteState = ArticleFavouriteState.init.obs;

    




  String? message;

  var rating = 0.0.obs;
  var totalRating = 4.5.obs;

  @override
  void onInit() {
  super.onInit();
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


  
Future<void> addPComplaint(
  {required AddPaintingComplaint addpaintingcopmlaint, 
  required int paintingId}) async {
    
    String storeBy;
    String rolecomplaint;
    String complaint;
    int id;
    complaint=UrlsApi.ArticleComplaintApi;
    if (AppSharedPreferences.getRole == 0) {
      rolecomplaint="storeFromArtistAgainstPainting/";
      storeBy = "$complaint$rolecomplaint$paintingId";
    } else {
      rolecomplaint="storeFromUserAgainstPainting/";
      storeBy = "$complaint$rolecomplaint$paintingId";
          }
    final Map<String, dynamic> addPaintingcopmlaint = <String, dynamic>{};
    addPaintingcopmlaint['content'] = addpaintingcopmlaint.Description;

    FormData AddComplaintFormData = FormData.fromMap(addPaintingcopmlaint);

    try {
      paintingcomplaintState(PaintingComplaintState.loading);
      Response response =
          await dioApiService.postData(storeBy, data: AddComplaintFormData,
           options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          paintingcomplaintState(PaintingComplaintState.succsesful);
          g.Get.snackbar('Success', 'Complaint is added successfully');
        } else {
          message = response.data['date'];
          paintingcomplaintState(PaintingComplaintState.error);
          g.Get.snackbar('Error', message!);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        paintingcomplaintState(PaintingComplaintState.error);
      } else {
        message = error.toString();
        paintingcomplaintState(PaintingComplaintState.error);
      }

    }
    g.Get.snackbar('Error', message!);

  }


  Future<void> addLike_Painting(
    {required AddPaintingLike likedetails, required int paintingId}) async {
    
    String storeBy;
    String roleLike;
    String Like;
    int id;
    Like=UrlsApi.AddLikePaintingApi;
    if (AppSharedPreferences.getRole == 0) {
      roleLike="changeFromArtist/like/";
      storeBy = "$Like$roleLike$paintingId";
    } else {
      roleLike="change/like/";
      storeBy = "$Like$roleLike$paintingId";
          }
    final Map<String, dynamic> addPaintinglike = <String, dynamic>{};
    addPaintinglike['type'] = likedetails.Like;

    FormData AddLikeFormData = FormData.fromMap(addPaintinglike);

    try {
      paintinglikeState(PaintingliketState.loading);
      Response response =
          await dioApiService.postData(storeBy, data: AddLikeFormData,
           options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          paintinglikeState(PaintingliketState.succsesful);
          g.Get.snackbar('Success', response.data['result'][1] ?? 'Liked is added successfully');
        } else {
          message = response.data['date'];
          paintinglikeState(PaintingliketState.error);
          g.Get.snackbar('Error', message!);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        paintinglikeState(PaintingliketState.error);
      } else {
        message = error.toString();
        paintinglikeState(PaintingliketState.error);
      }

    }
    g.Get.snackbar('Error', message!);

  }

  
  Future<void> addDisLike_Painting(
    {required AddPaintingDisLike dislikedetails, required int paintingId}) async {
    
    String storeBy;
    String roleDisLike;
    String DisLike;
    int id;
    DisLike=UrlsApi.AddLikePaintingApi;
    if (AppSharedPreferences.getRole == 0) {
      roleDisLike="changeFromArtist/dislike/";
      storeBy = "$DisLike$roleDisLike$paintingId";
    } else {
      roleDisLike="change/dislike/";
      storeBy = "$DisLike$roleDisLike$paintingId";
          }
    final Map<String, dynamic> addPaintingdislike = <String, dynamic>{};
    addPaintingdislike['type'] = dislikedetails.DisLike;

    FormData AddDisLikeFormData = FormData.fromMap(addPaintingdislike);

    try {
      paintingdislikeState(PaintingDislikeState.loading);
      Response response =
          await dioApiService.postData(storeBy, data: AddDisLikeFormData,
           options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          paintingdislikeState(PaintingDislikeState.succsesful);
          g.Get.snackbar('Success', response.data['result'][1] ?? 'DisLiked is added successfully');
        } else {
          message = response.data['date'];
          paintingdislikeState(PaintingDislikeState.error);
          g.Get.snackbar('Error', message!);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        paintingdislikeState(PaintingDislikeState.error);
      } else {
        message = error.toString();
        paintingdislikeState(PaintingDislikeState.error);
      }

    }
    g.Get.snackbar('Error', message!);

  }


  Future<void> addFavourite_Painting(
    {required AddPaintingFavourite favouritedetails, required int paintingId}) async {
    
    String storeBy;
    String rolefavourite;
    String favourite;
    favourite=UrlsApi.AddFavouriteApi;
    if (AppSharedPreferences.getRole == 0) {
      rolefavourite="changeFromArtist/";
      storeBy = "$favourite$rolefavourite$paintingId";
    } else {
      rolefavourite="change/";
      storeBy = "$favourite$rolefavourite$paintingId";
          }
    final Map<String, dynamic> addPaintingFavourite = <String, dynamic>{};
    addPaintingFavourite[''] = favouritedetails.Favourite;

    FormData AddFavouriteFormData = FormData.fromMap(addPaintingFavourite);

    try {
      paintingfavouriteState(PaintingFavouriteState.loading);
      Response response =
          await dioApiService.postData(storeBy, data: AddFavouriteFormData,
           options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          paintingfavouriteState(PaintingFavouriteState.succsesful);
          g.Get.snackbar('Success', response.data['result'][1] ?? 'Favourite is added successfully');
        } else {
          message = response.data['date'];
          paintingfavouriteState(PaintingFavouriteState.error);
          g.Get.snackbar('Error', message!);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        paintingfavouriteState(PaintingFavouriteState.error);
      } else {
        message = error.toString();
        paintingfavouriteState(PaintingFavouriteState.error);
      }

    }
    g.Get.snackbar('Error', message!);

  }


  Future<void> addFavourite_Article(
    {required AddArticleFavourite favouritedetails, required int articleId}) async {
    
    String storeBy;
    String rolefavourite;
    String favourite;
    favourite=UrlsApi.AddFavouriteApi;
    if (AppSharedPreferences.getRole == 0) {
      rolefavourite="changeArticleFromArtist/";
      storeBy = "$favourite$rolefavourite$articleId";
    } else {
      rolefavourite="changeArticle/";
      storeBy = "$favourite$rolefavourite$articleId";
          }
    final Map<String, dynamic> addArticleFavourite = <String, dynamic>{};
    addArticleFavourite[''] = favouritedetails.Favourite;

    FormData AddFavouriteFormData = FormData.fromMap(addArticleFavourite);

    try {
      articlefavouriteState(ArticleFavouriteState.loading);
      Response response =
          await dioApiService.postData(storeBy, data: AddFavouriteFormData,
           options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          articlefavouriteState(ArticleFavouriteState.succsesful);
          g.Get.snackbar('Success', response.data['result'][1] ?? 'Favourite is added successfully');
        } else {
          message = response.data['date'];
          articlefavouriteState(ArticleFavouriteState.error);
          g.Get.snackbar('Error', message!);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        articlefavouriteState(ArticleFavouriteState.error);
      } else {
        message = error.toString();
        articlefavouriteState(ArticleFavouriteState.error);
      }

    }
    g.Get.snackbar('Error', message!);

  }
}





enum PaintingDetailsState {
  init,
  succsesful,
  error,
  loading,
}


enum PaintingComplaintState {
  init,
  succsesful,
  error,
  loading,
}


enum PaintingliketState {
  init,
  succsesful,
  error,
  loading,
}


enum PaintingDislikeState {
  init,
  succsesful,
  error,
  loading,
}


enum PaintingFavouriteState {
  init,
  succsesful,
  error,
  loading,
}


enum ArticleFavouriteState {
  init,
  succsesful,
  error,
  loading,
}
