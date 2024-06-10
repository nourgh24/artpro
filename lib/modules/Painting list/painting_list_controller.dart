import 'package:untitled5/modules/Painting%20list/painting_list_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

class PaintingListController extends GetxController {
  var dropdownType=''.obs;
  var paintings = <Addpainting>[].obs;
  var selectedImages = <Uint8List>[].obs;
  var isSelecting = false.obs;
  var title = "".obs;
  var description = "".obs;
  var size = "".obs;
  var price="".obs;
  var type="".obs;
  // final ImagePicker _picker = ImagePicker();
  Uint8List?immage;


/*
  void addImage(Uint8List image) {
    images.add(image);
  }
*/

  void setDropdownType(String value) {
    dropdownType.value = value;
  }

  // Future<void> pickImage() async {
  //   final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     final Uint8List imageData = await pickedImage.readAsBytes();
  //     this.immage=imageData;
  //     update();
  //   }
  // }

  void toggleSelectionMode() {
    isSelecting.value = !isSelecting.value;
    if (!isSelecting.value) {
      selectedImages.clear();
    }
  }

  void selectImage(Uint8List immage) {
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
    Get.toNamed('/AddGalleryDetails');
  }

  void saveGallery() {
    if (selectedImages.isNotEmpty) {
      Get.toNamed('/GalleryDisplayView', arguments: {
        'title': title.value,
        'description': description.value,
        'images': selectedImages.toList(),
      });
      selectedImages.clear();
      isSelecting.value = false;
      title.value = '';
      description.value = '';
    } else {
      Get.snackbar('Error', 'Please select images.');
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


  void addPainting(Addpainting painting) {
    paintings.add(painting);
  }

  void updatePainting(int index, Addpainting painting) {
    paintings[index] = painting;
  }

  void deletePainting(int index) {
    paintings.removeAt(index);
  }

}