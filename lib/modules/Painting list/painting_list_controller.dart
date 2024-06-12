import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled5/Services/Helper/error_api_handler.dart';
import 'package:untitled5/Services/Network/dio_api_service.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/Painting%20list/painting_list_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as g;
// import 'package:image_picker/image_picker.dart';

class PaintingListController extends g.GetxController {
  DioApiService dioApiService = DioApiService();
  Rx<AddPaintingState> addPaintingState = AddPaintingState.init.obs;

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

  void selectImage(File immage) {
    if (selectedImages.contains(immage)) {
      selectedImages.remove(immage);
      print('image deselected');
    } else {
      selectedImages.add(immage);
      print('image selected');
    }
  }

  void createGallery() {
    print('Gallery created with ${selectedImages.length} images.');
    g.Get.toNamed('/AddGalleryDetails');
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
    final Map<String, dynamic> addPainting = <String, dynamic>{};
    addPainting['title'] = addpainting.paintingTiltle;
    addPainting['description'] = addpainting.paintingDescription;
    addPainting['url'] = await MultipartFile.fromFile(
      addpainting.paintingImage!.path,
      filename: addpainting.paintingImage!.path,
    );
    addPainting['type_id'] = 1;
    addPainting['price'] = addpainting.paintingPrice;
    addPainting['size'] = addpainting.paintingSize;

    FormData addPaintingFormData = FormData.fromMap(addPainting);

    try {
      addPaintingState(AddPaintingState.loading);
      Response response =
          await dioApiService.postData(UrlsApi.paintingsArtistApi, data: addPaintingFormData,
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

    // void addPainting(Addpainting painting) {
    //   paintings.add(painting);
    // }

    void updatePainting(int index, Addpainting painting) {
      paintings[index] = painting;
    }

    void deletePainting(int index) {
      paintings.removeAt(index);
    }
  }
}

enum AddPaintingState {
  init,
  succsesful,
  error,
  loading,
}
