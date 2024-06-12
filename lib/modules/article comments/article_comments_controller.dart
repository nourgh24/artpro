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
      required int id}) async {
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



  // void deleteComment(int id) {
  //   comments.removeWhere((comment) => comment.id == id || comment.parentId == id);
  // }

  // void editComment(int id, String newContent) {
  //   var index = comments.indexWhere((comment) => comment.id == id);
  //   if (index != -1) {
  //     comments[index] = Comment(
  //       id: comments[index].id,
  //       content: newContent,
  //       likes: comments[index].likes,
  //       parentId: comments[index].parentId,
  //       replies: comments[index].replies,
  //     );
  //   }
  // }

  // void likeComment(int id) {
  //   var index = comments.indexWhere((comment) => comment.id == id);
  //   if (index != -1) {
  //     comments[index] = Comment(
  //       id: comments[index].id,
  //       content: comments[index].content,
  //       likes: comments[index].likes + 1,
  //       parentId: comments[index].parentId,
  //       replies: comments[index].replies,
  //     );
  //   }
  // }

  // List<Comment> getReplies(int parentId) {
  //   return comments.where((comment) => comment.parentId == parentId).toList();
  // }

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








/*
class ArticleCommentsController extends GetxController {
  var article_comments = <Article_Comments>[].obs;
  final add_Comment_Controller = TextEditingController();
  ArticlesCommentsService service = ArticlesCommentsService();

  @override
  void onInit() {
    super.onInit();
    // تحميل البيانات عند بدء التطبيق
    loadArticlesComments();
  }
  void dispose() {
    add_Comment_Controller.dispose();
    super.dispose();
  }
  void reportComment() {
    service.reportComment(add_Comment_Controller);
    // يمكنك هنا إضافة المنطق الخاص بتسجيل الدخول
    print('Add a Comment: ${add_Comment_Controller.text}');
  }

  void loadArticlesComments() {
    //جلب البيانات من مصدر البيانات،
    article_comments.assignAll([
      Article_Comments(
          imageUrl: 'images/4.jpg',
          authorImageUrl: 'images/5.jpg',
          authorName: 'John Doe',
          time: '12 hours ago',
          ArticleComment:
              'rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr'
              'ffffffffffffffffffffffffffffffffffffffffff'
      ),
      Article_Comments(
          imageUrl: 'images/4.jpg',
          authorImageUrl: 'images/5.jpg',
          authorName: 'John Doe',
          time: '12 hours ago',
          ArticleComment:
          'rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr'
              'ffffffffffffffffffffffffffffffffffffffffff'
      ),

      Article_Comments(
          imageUrl: 'images/7.jpg',
          authorImageUrl: 'images/8.jpg',
          authorName: 'John Doe',
          time: '12 hours ago',
          ArticleComment: 'wwwwwwwwwwweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef'
              'ffffffffffffffffffffffffffffffffffffffffff'
              'ffffffffffffffffffffffffffffffffffffffffff'
      ),

      Article_Comments(
          imageUrl: 'images/7.jpg',
          authorImageUrl: 'images/8.jpg',
          authorName: 'John Doe',
          time: '12 hours ago',
          ArticleComment: 'wwwwwwwwwwweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef'
              'nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn'
              'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'
              'wwwwwwwwwwweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef'
              'ffffffffffffffffffffffffffffffffffffffffff'
      ),

      Article_Comments(
          imageUrl: 'images/7.jpg',
          authorImageUrl: 'images/8.jpg',
          authorName: 'John Doe',
          time: '12 hours ago',
          ArticleComment: 'wwwwwwwwwwweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef'
              'wwwwwwwwwwweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef'
              'ffffffffffffffffffffffffffffffffffffffffff'
      ),
    ]);


  }
}
 */