import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'gallery_display_view_service.dart';

class GalleryDisplayViewController extends GetxController {
  var gallery_details = <Gallery_Details>[].obs;

  @override
  void onInit() {
    super.onInit();
    // تحميل البيانات عند بدء التطبيق
    loadArticlesDetails();
  }


  void loadArticlesDetails() {
    //جلب البيانات من مصدر البيانات،
    gallery_details.assignAll([
      Gallery_Details(
        title: 'Article 1',
        authorImageUrl: 'images/5.jpg',
        authorName: 'John Doe',
        time: '12 hours ago',
      ),
    ],
    );
  }
}

