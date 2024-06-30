import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled5/Services/Helper/error_api_handler.dart';
import 'package:untitled5/Services/Network/dio_api_service.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/gallery/gallery_display_model.dart';

import 'gallery_display_view_service.dart';

class GalleryDisplayViewController extends g.GetxController {
  var gallery_details = <Gallery_Details>[].obs;
  Rx<AddGalleryState> addgalleryeState = AddGalleryState.init.obs;
  Rx<getGalleryDetailsState> getgalleryedetailsState = getGalleryDetailsState.init.obs;

  DioApiService dioApiService = DioApiService();
  GalleryDisplayModel?gallerydisplaymodel;
  File? image;
  String? message;
    final  imageUrl= 'images/8.jpg';


  @override
  void onInit() {
    super.onInit();
    loadArticlesDetails();
  }

  void loadArticlesDetails() {
    gallery_details.assignAll([
      Gallery_Details(
        title: 'Article 1',
        desicription: "iiiiii",
        authorImageUrl: 'images/5.jpg',
        authorName: 'John Doe',
        time: '12 hours ago',
        images: [
        
      ],
      ),
    ],
    );
  }
  
  Future<void> addGallery({required Gallery_Details gallerydetails}) async {
    String storeBy;
    if (AppSharedPreferences.getRole == 0) {
      storeBy = UrlsApi.AddGalleryApi;
    } else {
      return null;
    }
    final Map<String, dynamic> addGallery = <String, dynamic>{};

    addGallery['name'] = gallerydetails.title;
    addGallery['details'] = gallerydetails.desicription;
    addGallery['images'] = gallerydetails.images;
   
   /* List<MultipartFile> imageFiles = [];
  for (var image in gallerydetails.images) {
    imageFiles.add(await MultipartFile.fromFile(image.path));
  }
  addGallery['images'] = imageFiles;*/

    FormData addgalleryFormData = FormData.fromMap(addGallery);

    try {
      addgalleryeState(AddGalleryState.loading);
      Response response =
          await dioApiService.postData(storeBy, data: addgalleryFormData,
           options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data!['success']) {
          addgalleryeState(AddGalleryState.succsesful);
        } else {
          message = response.data!['date'];
          addgalleryeState(AddGalleryState.error);
          g.Get.snackbar('Error', message!);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        addgalleryeState(AddGalleryState.error);
      } else {
        message = error.toString();
        addgalleryeState(AddGalleryState.error);
      }
    }
  }




Future<void> getGalleryDetails({required int galleryId}) async {
     print("11111111");

   String storeBy="";
    if (AppSharedPreferences.getRole == 0) {
      storeBy = UrlsApi.getGalleryDetailsApi;
    } if (AppSharedPreferences.getRole == 1) {
        storeBy = UrlsApi.getGalleryDetailsApi;
            }

    try {

      getgalleryedetailsState(getGalleryDetailsState.loading);
      Response response = await dioApiService.postData('$storeBy$galleryId',
          options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
          print(response.data);
      if (response.data != null && response.statusCode == 200) {
  
        if (response.data['success']) {
          
           gallerydisplaymodel= GalleryDisplayModel.fromJson(response.data);
          getgalleryedetailsState(getGalleryDetailsState.succsesful);
        } else {
          message = response.data['data'];
          getgalleryedetailsState(getGalleryDetailsState.error);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        getgalleryedetailsState(getGalleryDetailsState.error);
      } else {
        message = error.toString();
        getgalleryedetailsState(getGalleryDetailsState.error);
      }
    }
  }

}
enum AddGalleryState {
  init,
  succsesful,
  error,
  loading,
}


enum getGalleryDetailsState {
  init,
  succsesful,
  error,
  loading,
}