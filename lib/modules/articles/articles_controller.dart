import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:untitled5/Services/Helper/error_api_handler.dart';
import 'package:untitled5/Services/Network/dio_api_service.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/articles/articles_model.dart';
import 'articles_service.dart';
  class ArticlesController extends g.GetxController {

    DioApiService dioApiService=DioApiService();
    Rx<ArticlesState> articleState = ArticlesState.init.obs;
    String? massage;
    ArticlesModel?articlesModel;
    String? message;
    final   imageUrl= 'images/10.jpg';
    bool Favorited=false;

  var articles = <Article>[].obs;
  @override
  void onInit() {
  super.onInit();
  loadArticles();
  }


Future<void> getAllArticles() async {
    String apiUrl;
    if (AppSharedPreferences.getRole == 0) {
      apiUrl =  "${UrlsApi.ArticlesApi}artist";
    } else {
      apiUrl = UrlsApi.ArticlesApi;
    }
    try {
      articleState(ArticlesState.loading);
      Response response = await dioApiService.getData(apiUrl,
          options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          articlesModel = ArticlesModel.fromJson(response.data);
          print("im herer 3");

          articleState(ArticlesState.succsesful);
        } else {
          message = response.data['data'];
          articleState(ArticlesState.error);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        articleState(ArticlesState.error);
      } else {
        message = error.toString();
        articleState(ArticlesState.error);
      }
    }
  }
  void loadArticles() {
  articles.assignAll([

    Article(
      title: 'Article 2',
      imageUrl: 'images/9.jpg',
      authorImageUrl: 'images/8.jpg',
      authorName: 'Jane Smith',
      time: '12 hours ago',
    ),
    Article(
      title: 'Article 2',
      imageUrl: 'images/9.jpg',
      authorImageUrl: 'images/8.jpg',
      authorName: 'Jane Smith',
      time: '12 hours ago',
    ),
    Article(
      title: 'Article 2',
      imageUrl: 'images/9.jpg',
      authorImageUrl: 'images/8.jpg',
      authorName: 'Jane Smith',
      time: '12 hours ago',
    ),
    Article(
      title: 'Article 2',
      imageUrl: 'images/9.jpg',
      authorImageUrl: 'images/8.jpg',
      authorName: 'Jane Smith',
      time: '12 hours ago',
    ),
    Article(
      title: 'Article 2',
      imageUrl: 'images/9.jpg',
      authorImageUrl: 'images/8.jpg',
      authorName: 'Jane Smith',
      time: '12 hours ago',
    ),
    Article(
      title: 'Article 2',
      imageUrl: 'images/9.jpg',
      authorImageUrl: 'images/8.jpg',
      authorName: 'Jane Smith',
      time: '12 hours ago',
    ),
    Article(
      title: 'Article 2',
      imageUrl: 'images/9.jpg',
      authorImageUrl: 'images/8.jpg',
      authorName: 'Jane Smith',
      time: '12 hours ago',
    ),
    Article(
      title: 'Article 2',
      imageUrl: 'images/9.jpg',
      authorImageUrl: 'images/8.jpg',
      authorName: 'Jane Smith',
      time: '12 hours ago',
    ),
    Article(
      title: 'Article 2',
      imageUrl: 'images/9.jpg',
      authorImageUrl: 'images/8.jpg',
      authorName: 'Jane Smith',
      time: '12 hours ago',
    ),
    Article(
      title: 'Article 2',
      imageUrl: 'images/9.jpg',
      authorImageUrl: 'images/8.jpg',
      authorName: 'Jane Smith',
      time: '12 hours ago',
    ),
    Article(
      title: 'Article 2',
      imageUrl: 'images/9.jpg',
      authorImageUrl: 'images/8.jpg',
      authorName: 'Jane Smith',
      time: '12 hours ago',
    ),
    Article(
      title: 'Article 2',
      imageUrl: 'images/9.jpg',
      authorImageUrl: 'images/8.jpg',
      authorName: 'Jane Smith',
      time: '12 hours ago',
    ),
    Article(
      title: 'Article 2',
      imageUrl: 'images/9.jpg',
      authorImageUrl: 'images/8.jpg',
      authorName: 'Jane Smith',
      time: '12 hours ago',
    ),
    Article(
      title: 'Article 2',
      imageUrl: 'images/9.jpg',
      authorImageUrl: 'images/8.jpg',
      authorName: 'Jane Smith',
      time: '12 hours ago',
    ),
    Article(
      title: 'Article 2',
      imageUrl: 'images/9.jpg',
      authorImageUrl: 'images/8.jpg',
      authorName: 'Jane Smith',
      time: '12 hours ago',
    ),
  ]);
  }
  }



  enum ArticlesState {
  init,
  succsesful,
  error,
  loading,
}