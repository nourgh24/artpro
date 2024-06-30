import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as g;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:untitled5/Services/Helper/error_api_handler.dart';
import 'package:untitled5/Services/Network/dio_api_service.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/articles_details/articles_details_model';
import 'articles_details_service.dart';

class ArticlesDetailsController extends g.GetxController {
  DioApiService dioApiService = DioApiService();
  Rx<ArticleDetailsState> articledetailsState = ArticleDetailsState.init.obs;
  Rx<ArticleComplaintState> articlecomplaintState = ArticleComplaintState.init.obs;
  Rx<ArticleliketState> articlelikeState = ArticleliketState.init.obs;
  Rx<ArticleDislikeState> articledislikeState = ArticleDislikeState.init.obs;



  String? message;
  ArticleDetailsModel? articledetailsModel;  
  final  imageUrl= 'images/8.jpg';
  var articles_details = <Articles_Details>[].obs;
  var reportReason = ''.obs;
  final add_Comment_Controller = TextEditingController();
  ArticlesDetailsService service = ArticlesDetailsService();
  RxBool isFavorite = false.obs;
  RxBool isLike=false.obs;
  RxBool isDisLike=false.obs;


  @override
  void onInit() {
    super.onInit();
    loadArticlesDetails();
  }


Future<void> getArticleDetails({required int articleId}) async {
    try {
      articledetailsState(ArticleDetailsState.loading);
      Response response = await dioApiService.postData("${UrlsApi.ArticleDetailsApi}$articleId",
          options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
          print(response.data);
      if (response.data != null && response.statusCode == 200) {
  
        if (response.data['success']) {
          
           articledetailsModel= ArticleDetailsModel.fromJson(response.data);
          print("im here");
          articledetailsState(ArticleDetailsState.succsesful);
        } else {
          message = response.data['data'];
          articledetailsState(ArticleDetailsState.error);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        articledetailsState(ArticleDetailsState.error);
      } else {
        message = error.toString();
        articledetailsState(ArticleDetailsState.error);
      }
    }
  }

Future<void> addComplaint({required AddComplaint addcopmlaint, required int articleId}) async {
    
    String storeBy;
    String rolecomplaint;
    String complaint;
    int id;
    complaint=UrlsApi.ArticleComplaintApi;

    if (AppSharedPreferences.getRole == 0) {
      rolecomplaint="storeFromArtistAgainstArticle/";
      storeBy = "$complaint$rolecomplaint$articleId";
    } else {
      rolecomplaint="storeFromUserAgainstArticle/";
      storeBy = "$complaint$rolecomplaint$articleId";
      
          }

    final Map<String, dynamic> addCopmlaint = <String, dynamic>{};
    addCopmlaint['content'] = addcopmlaint.Description;

    FormData AddComplaintFormData = FormData.fromMap(addCopmlaint);

    try {
      articlecomplaintState(ArticleComplaintState.loading);
      Response response =
          await dioApiService.postData(storeBy, data: AddComplaintFormData,
           options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          articlecomplaintState(ArticleComplaintState.succsesful);
          g.Get.snackbar('Success', 'Complaint is added successfully');
        } else {
          message = response.data['date'];
          articlecomplaintState(ArticleComplaintState.error);
          g.Get.snackbar('Error', message!);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        articlecomplaintState(ArticleComplaintState.error);
      } else {
        message = error.toString();
        articlecomplaintState(ArticleComplaintState.error);
      }

    }
    g.Get.snackbar('Error', message!);

  }




  void loadArticlesDetails() {
    articles_details.assignAll([
      Articles_Details(
         imageUrl: 'images/8.jpg',
        title: 'Article 1',
        authorImageUrl: 'images/5.jpg',
        authorName: 'John Doe',
        time: '12 hours ago',
          ArticleText:'wwwwwwwwwwweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef'
              'ffffffffffffffffffffffffffffffffff'
              'ooooooooooooooooooooooooooooooooooooo'
              'pppppppppppppppppp',
      ),
    ]);
  }
  void toggleFavorite() {
    isFavorite.toggle();
    isLike.toggle();
    isDisLike.toggle();
  }

  void updateReportReason(String reason) {
    reportReason.value = reason;
  }

  void submitReport() {
    print("Report submitted with reason: ${reportReason.value}");
    g.Get.back();
  }

  
  Future<void> addLike_Article(
    {required AddArticleLike likedetails, required int articleId}) async {
    
    String storeBy;
    String roleLike;
    String Like;
    Like=UrlsApi.AddLikeArticleApi;
    if (AppSharedPreferences.getRole == 0) {
      roleLike="changeFromArtist/like/";
      storeBy = "$Like$roleLike$articleId";
    } else {
      roleLike="change/like/";
      storeBy = "$Like$roleLike$articleId";
          }
    final Map<String, dynamic> addArticlelike = <String, dynamic>{};
    addArticlelike['type'] = likedetails.Like;

    FormData AddLikeFormData = FormData.fromMap(addArticlelike);

    try {
      articlelikeState(ArticleliketState.loading);
      Response response =
          await dioApiService.postData(storeBy, data: AddLikeFormData,
           options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          articlelikeState(ArticleliketState.succsesful);
          g.Get.snackbar('Success', response.data['result'][1] ?? 'Liked is added successfully');
        } else {
          message = response.data['date'];
          articlelikeState(ArticleliketState.error);
          g.Get.snackbar('Error', message!);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        articlelikeState(ArticleliketState.error);
      } else {
        message = error.toString();
        articlelikeState(ArticleliketState.error);
      }

    }
    g.Get.snackbar('Error', message!);

  }

  
  Future<void> addDisLike_Articles(
    {required AddArticleDisLike dislikedetails, required int articleId}) async {
    
    String storeBy;
    String roleDisLike;
    String DisLike;
    int id;
    DisLike=UrlsApi.AddLikeArticleApi;
    if (AppSharedPreferences.getRole == 0) {
      roleDisLike="changeFromArtist/dislike/";
      storeBy = "$DisLike$roleDisLike$articleId";
    } else {
      roleDisLike="change/dislike/";
      storeBy = "$DisLike$roleDisLike$articleId";
          }
    final Map<String, dynamic> addArticledislike = <String, dynamic>{};
    addArticledislike['type'] = dislikedetails.DisLike;

    FormData AddDisLikeFormData = FormData.fromMap(addArticledislike);

    try {
      articledislikeState(ArticleDislikeState.loading);
      Response response =
          await dioApiService.postData(storeBy, data: AddDisLikeFormData,
           options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          articledislikeState(ArticleDislikeState.succsesful);
          g.Get.snackbar('Success', response.data['result'][1] ?? 'DisLiked is added successfully');
        } else {
          message = response.data['date'];
          articledislikeState(ArticleDislikeState.error);
          g.Get.snackbar('Error', message!);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        articledislikeState(ArticleDislikeState.error);
      } else {
        message = error.toString();
        articledislikeState(ArticleDislikeState.error);
      }

    }
    g.Get.snackbar('Error', message!);

  }
}

enum ArticleDetailsState {
  init,
  succsesful,
  error,
  loading,
}

enum ArticleComplaintState {
  init,
  succsesful,
  error,
  loading,
}


enum ArticleliketState {
  init,
  succsesful,
  error,
  loading,
}


enum ArticleDislikeState {
  init,
  succsesful,
  error,
  loading,
}