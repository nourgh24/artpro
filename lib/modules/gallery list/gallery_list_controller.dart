
import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:untitled5/Services/Helper/error_api_handler.dart';
import 'package:untitled5/Services/Network/dio_api_service.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/gallery%20list/gallery_list_model.dart';
import 'gallery_list_services.dart';
class GalleryListController extends g.GetxController {
var galleries = <gallery_list>[].obs;
Rx<GalleryListState> galleryliststate = GalleryListState.init.obs;
String? message;
GalleryListModel?gallerylistmodel;
DioApiService dioApiService=DioApiService();


  @override
  void onInit() {
    super.onInit();
    loadArticles();
  }

  void loadArticles() {
    galleries.assignAll([
      gallery_list(
        title: 'Article 1',
        imageUrl: 'images/4.jpg',
        authorImageUrl: 'images/5.jpg',
        authorName: 'John Doe',
        time: '12 hours ago',
      ),
      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time:'12 hours ago',
      ),

      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time: '12 hours ago',
      ),
      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time: '12 hours ago',
      ),
      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time: '12 hours ago',
      ),
      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time: '12 hours ago',
      ),
      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time: '12 hours ago',
      ),
      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time: '12 hours ago',
      ),
      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time: '12 hours ago',
      ),
      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time: '12 hours ago',
      ),
      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time: '12 hours ago',
      ),
      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time: '12 hours ago',
      ),
      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time: '12 hours ago',
      ),
      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time: '12 hours ago',
      ),
      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time: '12 hours ago',
      ),
      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time: '12 hours ago',
      ),
      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time: '12 hours ago',
      ),
      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time: '12 hours ago',
      ),
      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time: '12 hours ago',
      ),
      gallery_list(
        title: 'Article 2',
        imageUrl: 'images/9.jpg',
        authorImageUrl: 'images/8.jpg',
        authorName: 'Jane Smith',
        time: '12 hours ago',
      ),
    ]);
  }

  
Future<void> getAllGalleryes() async {
    String apiUrl;
    if (AppSharedPreferences.getRole == 0) {
      apiUrl = UrlsApi.getAllGalleryApi;
    } else {
      apiUrl = UrlsApi.getAllGalleryApi;
    } 
    
    try {
      galleryliststate(GalleryListState.loading);
      Response response = await dioApiService.getData(apiUrl,
          options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          gallerylistmodel = GalleryListModel.fromJson(response.data);

          galleryliststate(GalleryListState.succsesful);
        } else {
          message = response.data['data'];
          galleryliststate(GalleryListState.error);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        galleryliststate(GalleryListState.error);
      } else {
        message = error.toString();
        galleryliststate(GalleryListState.error);
      }
    }
  }
}

  
enum GalleryListState {
  init,
  succsesful,
  error,
  loading,
}