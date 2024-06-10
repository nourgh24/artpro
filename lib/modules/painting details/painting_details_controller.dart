import 'package:untitled5/modules/painting%20details/painting_details_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaintingDetailsController extends GetxController {
  RxBool showDetails = false.obs;
  RxBool isFavorite = false.obs;
  RxBool isLike=false.obs;
  RxBool isDisLike=false.obs;
  RxString imageDescription = ''
      'Image Description :duuif dbfjsj uie ufuo yuyue yugd yusgyufyu ysgdyu '
      'Image Description :duuif dbfjsj uie ufuo yuyue yugd yusgyufyu ysgdyu '
      'Image Description :duuif dbfjsj uie ufuo yuyue yugd yusgyufyu ysgdyu'.obs;
  RxString imageType = 'Panoramic'.obs;
  RxString title = 'Panoramic'.obs;
  RxString artist = 'Nour ghanem'.obs;
  RxDouble imagePrice = 99.99.obs;
  RxString time= '12 hours ago'.obs;
  RxString imageUrl= 'images/13.jpg'.obs;
  RxString authorImageUrl= 'images/5.jpg'.obs;
  RxString size="200 x 160".obs;
  var details = <Details>[].obs;

  var rating = 0.0.obs;
  var totalRating = 4.5.obs;

  @override
  void onInit() {
  super.onInit();
  // تحميل البيانات عند بدء التطبيق
  loadArticles();
  }
  void updateRating(double newRating) {
    rating.value = newRating;
  }

  void loadArticles() {
    details.assignAll([
    Details(
  title: 'Article 1',
  imageUrl: 'images/13.jpg',
  authorImageUrl: 'images/5.jpg',
  time: '12 hours ago',
    ),
    ],
  );
    }
  void toggleShowDetails() {
    showDetails.toggle();
  }

  void toggleFavorite() {
    isFavorite.toggle();
    isLike.toggle();
    isDisLike.toggle();
  }
}

