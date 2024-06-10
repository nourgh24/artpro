import 'package:get/get.dart';

class Gallery3dController extends GetxController {
  // قائمة اللوحات الفنية
  var artworks = <Artwork>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadArtworks();
  }
  loadArtworks(){
    artworks.assignAll([//// يتم استدعاء ips
      Artwork(name: 'Painting 1', imageUrl: 'images/4.jpg'),
      Artwork(name: 'Painting 2', imageUrl: 'images/7.jpg'),
      Artwork(name: 'Painting 3', imageUrl: 'images/8.jpg'),
      Artwork(name: 'Painting 4', imageUrl: 'images/9.jpg'),
      // يمكنك إضافة المزيد من اللوحات هنا
   ]);
  }

}


/*
import 'package:get/get.dart';

import 'gallery3d_service.dart';
class PhotoViewerController extends GetxController {
  Rx<PhotoViewerModel> photoViewerModelObj = PhotoViewerModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
*/

class Artwork {
  final String name;
  final String imageUrl;

  Artwork({required this.name, required this.imageUrl});
}
