import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled5/Services/Helper/error_api_handler.dart';
import 'package:untitled5/Services/Network/dio_api_service.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/articles%20list/add_article_model.dart';
import '../articles/articles_service.dart';
import 'articles_list_service.dart';

class ArticleListController extends g.GetxController {
  DioApiService dioApiService = DioApiService();
  Rx<AddArticleState> addarticleState = AddArticleState.init.obs;
  Rx<getArticleState> getarticleState = getArticleState.init.obs;
  Rx<updateArticleState> updatearticleState = updateArticleState.init.obs;
  Rx<DeleteArticleState> deletearticleState = DeleteArticleState.init.obs;

    
  getArticlemodel? getarticleModel;


  var articles = <AddArticlee>[].obs;
  File? image;
  String? message;
  RxString imageUrl= 'images/13.jpg'.obs;

  final ImagePicker _picker = ImagePicker();

Future<void> pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final File imageData = File(pickedImage.path);
      image = imageData;
      update();
    }
  }

  Future<void> addArticle({required AddArticlee addarticle}) async {
    String storeBy;
    if (AppSharedPreferences.getRole == 0) {
      storeBy = UrlsApi.AddArticleApi;
    } else {
      return null;
    }
    final Map<String, dynamic> addArticle = <String, dynamic>{};
    addArticle['title'] = addarticle.artistTitle;
    addArticle['description'] = addarticle.articleText;
    addArticle['url'] = await MultipartFile.fromFile(addarticle.articleImage!.path,
      filename: addarticle.articleImage!.path,
    );
    
    FormData addarticleFormData = FormData.fromMap(addArticle);

    try {
      addarticleState(AddArticleState.loading);
      Response response =
          await dioApiService.postData(storeBy, data: addarticleFormData,
           options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data!['success']) {
          addarticleState(AddArticleState.succsesful);
        } else {
          message = response.data!['date'];
          addarticleState(AddArticleState.error);
          g.Get.snackbar('Error', message!);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        addarticleState(AddArticleState.error);
      } else {
        message = error.toString();
        addarticleState(AddArticleState.error);
      }
    }
  }

   

Future<void> getArtistArticles({ required int artistId}) async {
  print("getArtistArticles called with artistId: $artistId");
    String apiUrl;
      apiUrl =  UrlsApi.ArtistArticleApi;
    
    try {
      getarticleState(getArticleState.loading);
      Response response = await dioApiService.postData("$apiUrl$artistId",
          options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          getarticleModel = getArticlemodel.fromJson(response.data);

          getarticleState(getArticleState.succsesful);
        } else {
          message = response.data['data'];
          getarticleState(getArticleState.error);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        getarticleState(getArticleState.error);
      } else {
        message = error.toString();
        getarticleState(getArticleState.error);
      }
    }
  }

  
  Future<void> UpdateArticle({required int articleId, required AddArticlee updateArticle}) async {
  String updateBy;
  if (AppSharedPreferences.getRole == 0) {
    updateBy = "${UrlsApi.UpdateArticleApi}$articleId";
  } else {
    return null;
  }

  final Map<String, dynamic> updateArticleData = <String, dynamic>{};
  updateArticleData['title'] = updateArticle.artistTitle;
  updateArticleData['description'] = updateArticle.articleText;
  if (updateArticle.articleImage != null) {
    updateArticleData['url'] = await MultipartFile.fromFile(
      updateArticle.articleImage.path,
      filename: updateArticle.articleImage.path.split('/').last,
    );
  } 

  FormData UpdateArticleFormData = FormData.fromMap(updateArticleData);

  try {
    updatearticleState(updateArticleState.loading);
    Response response = await dioApiService.postData(updateBy, data: UpdateArticleFormData, 
      options: Options(headers: {
        "Authorization": "Bearer ${AppSharedPreferences.getToken}"
      }));

    if (response.data != null && response.statusCode == 200) {
      if (response.data['success']) {
        updatearticleState(updateArticleState.succsesful);
      } else {
        message = response.data['data'];
        updatearticleState(updateArticleState.error);
        g.Get.snackbar('Error', message!);
      }
    }
  } catch (error) {
    if (error is DioException) {
      message = ErrorApiHandler.getErrorMessage(error);
      updatearticleState(updateArticleState.error);
    } else {
      message = error.toString();
      updatearticleState(updateArticleState.error);
    }
  }
}

Future<void> deleteArticle({required int articleId}) async {
  String deleteBy;
  if (AppSharedPreferences.getRole == 0) {
    deleteBy = "${UrlsApi.DeleteArticleApi}$articleId";
  } else {
    return null;
  }

  try {
    deletearticleState(DeleteArticleState.loading);
    Response response = await dioApiService.postData(deleteBy,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }));
    if (response.data != null && response.statusCode == 200) {
      if (response.data['success']) {
        deletearticleState(DeleteArticleState.succsesful);
      } else {
        message = response.data['data'];
        deletearticleState(DeleteArticleState.error);
        g.Get.snackbar('Error', message!);
      }
    }
  } catch (error) {
    if (error is DioException) {
      message = ErrorApiHandler.getErrorMessage(error);
      deletearticleState(DeleteArticleState.error);
    } else {
      message = error.toString();
      deletearticleState(DeleteArticleState.error);
    }
  }
}
}

enum AddArticleState {
  init,
  succsesful,
  error,
  loading,
}


enum getArticleState {
  init,
  succsesful,
  error,
  loading,
}
  
  
enum updateArticleState {
  init,
  succsesful,
  error,
  loading,
}

  
enum DeleteArticleState {
  init,
  succsesful,
  error,
  loading,
}
  