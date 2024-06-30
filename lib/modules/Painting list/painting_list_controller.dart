import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled5/Services/Helper/error_api_handler.dart';
import 'package:untitled5/Services/Network/dio_api_service.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/Painting%20list/painting_list_model.dart';
import 'package:untitled5/modules/Painting%20list/painting_list_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as g;
import 'package:untitled5/modules/gallery/add_gallery_details.dart';
import 'package:untitled5/modules/gallery/gallery_display_view_controller.dart';

class PaintingListController extends g.GetxController {
  DioApiService dioApiService = DioApiService();
  Rx<AddPaintingState> addPaintingState = AddPaintingState.init.obs;
  Rx<PaintingListState> paintinglistState = PaintingListState.init.obs;
  Rx<DeletePaintingState> deletePaintingState = DeletePaintingState.init.obs;
  Rx<updatePaintingState> updatepaintingState = updatePaintingState.init.obs;

    final GalleryDisplayViewController galleryController = g.Get.find<GalleryDisplayViewController>();

  PaintingListModel?paintinglistmodel;

  String? message;
  var dropdownType = ''.obs;
  var paintings = <Addpainting>[].obs;
  var selectedImages = <File>[].obs;
  var isSelecting = false.obs;
  var title = "".obs;
  var description = "".obs;
  var size = "".obs;
  var price = "".obs;
  var type = "".obs;
  final ImagePicker _picker = ImagePicker();
  File? immage;

/*
  void addImage(Uint8List image) {
    images.add(image);
  }
*/

  void setDropdownType(String value) {
    dropdownType.value = value;
  }

  Future<void> pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final File imageData = File(pickedImage.path);
      immage = imageData;
      update();
    }
  }

  void toggleSelectionMode() {
    isSelecting.value = !isSelecting.value;
    if (!isSelecting.value) {
      selectedImages.clear();
    }
  }
/*
  void selectImage(File immage) {
    if (selectedImages.contains(immage)) {
      selectedImages.remove(immage);
      print('image deselected');
    } else {
      selectedImages.add(immage);
      print('image selected');
    }
  }*/

  /*void selectImage(File immage) {
  if (selectedImages.any((selectedImage) => selectedImage.path == immage.path)) {
    selectedImages.removeWhere((selectedImage) => selectedImage.path == immage.path);
    print('Image deselected');
  } else {
    selectedImages.add(immage);
    print('Image selected');
  }
}*/
void selectImage(String immage) {
  if (selectedImages.any((selectedImage) => selectedImage.path == immage)) {
    selectedImages.removeWhere((selectedImage) => selectedImage.path == immage);
    print('Image deselected');
  } else {
    selectedImages.add(File(immage));
    print('Image selected');
  }
}



  void createGallery() {
    print('Gallery created with ${selectedImages.length} images.');
    g.Get.to(() => AddGalleryDetails());
    //g.Get.to(AddGalleryDetails());
  }

  void saveGallery() {
    if (selectedImages.isNotEmpty) {
      g.Get.toNamed('/GalleryDisplayView', arguments: {
        'title': title.value,
        'description': description.value,
        'images': selectedImages.toList(),
      });
      selectedImages.clear();
      isSelecting.value = false;
      title.value = '';
      description.value = '';
    } else {
      g.Get.snackbar('Error', 'Please select images.');
    }
  }

  
/*
  void savePainting() {
    if (title.isNotEmpty && images.isNotEmpty) {
      Get.toNamed('/PaintingList', arguments: {
        'title': title.value,
        'description': description.value,
        'size': size.value,
        'image': images.value,
        'price':price.value,
      });
      title.value = '';
      description.value = '';
      size.value = '';
      images.clear();
      price.value='';
    } else {
      Get.snackbar('Error', 'Please fill in all fields and select images.');
    }
  }*/

  Future<void> addPainting({required Addpainting addpainting}) async {
    String storeBy;
    if (AppSharedPreferences.getRole == 0) {
      storeBy = UrlsApi.paintingsArtistApi;
    } else {
      return null;
    }
    final Map<String, dynamic> addPainting = <String, dynamic>{};
    addPainting['title'] = addpainting.paintingTiltle;
    addPainting['description'] = addpainting.paintingDescription;
    addPainting['url'] = await MultipartFile.fromFile(
      addpainting.paintingImage!.path,
      filename: addpainting.paintingImage!.path,
    );
    addPainting['type_id'] = mapTypeToId(addpainting.paintingType);
    addPainting['price'] = addpainting.paintingPrice;
    addPainting['size'] = addpainting.paintingSize;

    FormData addPaintingFormData = FormData.fromMap(addPainting);

    try {
      addPaintingState(AddPaintingState.loading);
      Response response =
          await dioApiService.postData(storeBy, data: addPaintingFormData,
           options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data!['success']) {
          addPaintingState(AddPaintingState.succsesful);
        } else {
          message = response.data!['date'];
          addPaintingState(AddPaintingState.error);
          g.Get.snackbar('Error', message!);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        addPaintingState(AddPaintingState.error);
      } else {
        message = error.toString();
        addPaintingState(AddPaintingState.error);
      }
    }
/*
    void updatePainting(int index, Addpainting painting) {
      paintings[index] = painting;
    }

    void deletePainting(int index) {
      paintings.removeAt(index);
    }*/
  }

  int mapTypeToId(String type) {
  switch (type) {
    case 'Art':
      return 1;
    case 'Graphic_Design':
      return 2;
    case 'Photography':
      return 3;
    case 'Visual_Art':
      return 4;
    case 'Sculpture':
      return 5;
    case 'printing_Art':
      return 6;
    case 'Mural_Art':
      return 7;
    case 'Mosaic':
      return 8;
    default:
      return 1;
  }
}




Future<void> getPaintingList({ required int artistId}) async {
  print("getPaintingList called with artistId: $artistId");
    String apiUrl;
      apiUrl =  UrlsApi.paintingsListApi;
    
    try {
      paintinglistState(PaintingListState.loading);
      Response response = await dioApiService.postData("$apiUrl$artistId",
          options: Options(headers: {
            "Authorization": "Bearer ${AppSharedPreferences.getToken}"
          }));
      if (response.data != null && response.statusCode == 200) {
        if (response.data['success']) {
          paintinglistmodel = PaintingListModel.fromJson(response.data);

          paintinglistState(PaintingListState.succsesful);
        } else {
          message = response.data['data'];
          paintinglistState(PaintingListState.error);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        paintinglistState(PaintingListState.error);
      } else {
        message = error.toString();
        paintinglistState(PaintingListState.error);
      }
    }
  }


  Future<void> UpdatePainting({required int paintingId, required Addpainting updatePainting}) async {
  String updateBy;
  if (AppSharedPreferences.getRole == 0) {
    updateBy = "${UrlsApi.updatepaintingApi}$paintingId";
  } else {
    return null;
  }

  final Map<String, dynamic> updatePaintingData = <String, dynamic>{};
  updatePaintingData['title'] = updatePainting.paintingTiltle;
  updatePaintingData['description'] = updatePainting.paintingDescription;
  if (updatePainting.paintingImage != null) {
    updatePaintingData['url'] = await MultipartFile.fromFile(
      updatePainting.paintingImage!.path,
      filename: updatePainting.paintingImage!.path.split('/').last,
    );
  } 
  updatePaintingData['type_id'] = updatePainting.paintingType;
  updatePaintingData['price'] = updatePainting.paintingPrice;
  updatePaintingData['size'] = updatePainting.paintingSize;

  FormData UpdatePaintingFormData = FormData.fromMap(updatePaintingData);

  try {
    updatepaintingState(updatePaintingState.loading);
    Response response = await dioApiService.postData(updateBy, data: UpdatePaintingFormData, 
      options: Options(headers: {
        "Authorization": "Bearer ${AppSharedPreferences.getToken}"
      }));

    if (response.data != null && response.statusCode == 200) {
      if (response.data['success']) {
        updatepaintingState(updatePaintingState.succsesful);
      } else {
        message = response.data['data'];
        updatepaintingState(updatePaintingState.error);
        g.Get.snackbar('Error', message!);
      }
    }
  } catch (error) {
    if (error is DioException) {
      message = ErrorApiHandler.getErrorMessage(error);
      updatepaintingState(updatePaintingState.error);
    } else {
      message = error.toString();
      updatepaintingState(updatePaintingState.error);
    }
  }
}
  
Future<void> deletePainting({required int paintingId}) async {
  String deleteBy;
  if (AppSharedPreferences.getRole == 0) {
    deleteBy = "${UrlsApi.deletepaintingApi}$paintingId";
  } else {
    return null;
  }

  try {
    deletePaintingState(DeletePaintingState.loading);
    Response response = await dioApiService.postData(deleteBy,
        options: Options(headers: {
          "Authorization": "Bearer ${AppSharedPreferences.getToken}"
        }));
    if (response.data != null && response.statusCode == 200) {
      if (response.data['success']) {
        deletePaintingState(DeletePaintingState.succsesful);
      } else {
        message = response.data['data'];
        deletePaintingState(DeletePaintingState.error);
        g.Get.snackbar('Error', message!);
      }
    }
  } catch (error) {
    if (error is DioException) {
      message = ErrorApiHandler.getErrorMessage(error);
      deletePaintingState(DeletePaintingState.error);
    } else {
      message = error.toString();
      deletePaintingState(DeletePaintingState.error);
    }
  }
}
}

enum AddPaintingState {
  init,
  succsesful,
  error,
  loading,
}


enum PaintingListState {
  init,
  succsesful,
  error,
  loading,
}


enum updatePaintingState {
  init,
  succsesful,
  error,
  loading,
}

  
enum DeletePaintingState {
  init,
  succsesful,
  error,
  loading,
}
  
