import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:untitled5/Services/Helper/error_api_handler.dart';
import 'package:untitled5/Services/Network/dio_api_service.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/article%20comments/comment_model.dart';

class CommentController extends g.GetxController {
  DioApiService dioApiService = DioApiService();

  // var comments = <Comment>[].obs;
  RxString name = 'Nour ghanem'.obs;
  RxString image = 'images/13.jpg'.obs;
  RxString time = '12 hours ago'.obs;
  CommentModel? commentModel;

  Rx<CommentState> commentState = CommentState.init.obs;
  String? message;

  void addComment(
      {required String apiUrl,
      required String commentText,
      required int id
      }) async {
    String storeBy;

    if (AppSharedPreferences.getRole == 0) {
      storeBy = "storeFromArtist";
    } else {
      storeBy = "store";
    }
    try {
      Response response = await dioApiService.postData("$apiUrl$storeBy/$id",
          data: {"comment_text": commentText},
          options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          getComments(apiUrl: apiUrl, id: id);
        } else {
          message = response.data['data'];
          g.Get.snackbar('Error', message!);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        g.Get.snackbar('Error', message!);
      } else {
        message = error.toString();
        g.Get.snackbar('Error', message!);
      }
    }
  }


   void deleteComment(
      {required String apiUrl,
      required String commentText,
      required int id,
      required int commedntId}) async {
    String deleteBy;

    if (AppSharedPreferences.getRole == 0) {
      deleteBy = "deleteFromArtist";
    } else {
      deleteBy = "delete";
    }
    try {
      Response response = await dioApiService.postData("$apiUrl$deleteBy/$commedntId",
        
          options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          getComments(apiUrl: apiUrl, id: id);
        } else {
          message = response.data['data'];
          g.Get.snackbar('Error', message!);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        g.Get.snackbar('Error', message!);
      } else {
        message = error.toString();
        g.Get.snackbar('Error', message!);
      }
    }
  }



   void updateComment(
      {required String apiUrl,
      required String commentText,
      required int id,
      required int commedntId}) async {
    String updateBy;

    if (AppSharedPreferences.getRole == 0) {
      updateBy = "updateFromArtist";
    } else {
      updateBy = "update";
    }
    try {
      Response response = await dioApiService.postData("$apiUrl$updateBy/$commedntId",
        data: {
          "comment_text":commentText
        },
          options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          getComments(apiUrl: apiUrl, id: id);
         g. Get.back();
        } else {
          message = response.data['data'];
          g.Get.snackbar('Error', message!);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        g.Get.snackbar('Error', message!);
      } else {
        message = error.toString();
        g.Get.snackbar('Error', message!);
      }
    }
  }

  Future<void> getComments({required String apiUrl, required int id}) async {
    try {
      commentState(CommentState.loading);
      Response response = await dioApiService.postData("${apiUrl}show/$id",
          options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          commentModel = CommentModel.fromJson(response.data);
          print("im here");

          commentState(CommentState.succsesful);
        } else {
          message = response.data['data'];
          commentState(CommentState.error);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        commentState(CommentState.error);
      } else {
        message = error.toString();
        commentState(CommentState.error);
      }
    }
  }
}

enum CommentState {
  init,
  succsesful,
  error,
  loading,
}