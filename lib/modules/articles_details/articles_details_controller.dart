import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'articles_details_service.dart';


class ArticlesDetailsController extends GetxController {
  var articles_details = <Articles_Details>[].obs;
  var reportReason = ''.obs;
  final add_Comment_Controller = TextEditingController();
  ArticlesDetailsService service = ArticlesDetailsService();
  RxBool isFavorite = false.obs;
  RxBool isLike=false.obs;
  RxBool isDisLike=false.obs;


  @override
  void onInit() {
    super.onInit();
    // تحميل البيانات عند بدء التطبيق
    loadArticlesDetails();
  }


  void loadArticlesDetails() {
    //جلب البيانات من مصدر البيانات،
    articles_details.assignAll([
      Articles_Details(
        title: 'Article 1',
        imageUrl: 'images/4.jpg',
        authorImageUrl: 'images/5.jpg',
        authorName: 'John Doe',
        time: '12 hours ago',
          ArticleText:'wwwwwwwwwwweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef'
              'ffffffffffffffffffffffffffffffffffffffffff'
              'ffffffffffffffffffffffffffffffffffffffffff'
              'fffffffffffffffffffffffffffffffffffffffffffffffff'
              'gggggggggggggggggggggggggggggggggggggggg'
              'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk'
              'lllllllllllllllllllllllllllllllllllll'
              'ooooooooooooooooooooooooooooooooooooo'
              'pppppppppppppppppppppppppppppppppppppppppp'
              'rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr'
              'cccccccccccccccccccccccccccccccccccc'
              'nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn'
              'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'
              'wwwwwwwwwwweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef'
              'ffffffffffffffffffffffffffffffffffffffffff'
              'ffffffffffffffffffffffffffffffffffffffffff'
              'fffffffffffffffffffffffffffffffffffffffffffffffff'
              'gggggggggggggggggggggggggggggggggggggggg'
              'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk'
              'lllllllllllllllllllllllllllllllllllll'
              'ooooooooooooooooooooooooooooooooooooo'
              'pppppppppppppppppppppppppppppppppppppppppp'
              'rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr'
              'cccccccccccccccccccccccccccccccccccc'
              'nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn'
              'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'
              'wwwwwwwwwwweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef'
              'ffffffffffffffffffffffffffffffffffffffffff'
              'ffffffffffffffffffffffffffffffffffffffffff'
              'fffffffffffffffffffffffffffffffffffffffffffffffff'
              'gggggggggggggggggggggggggggggggggggggggg'
              'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk'
              'lllllllllllllllllllllllllllllllllllll'
              'ooooooooooooooooooooooooooooooooooooo'
              'pppppppppppppppppppppppppppppppppppppppppp'
              'rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr'
              'cccccccccccccccccccccccccccccccccccc'
              'nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn'
              'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm',
      ),
    ]);
  }
  void toggleFavorite() {
    isFavorite.toggle();
    isLike.toggle();
    isDisLike.toggle();
  }

  void updateReportReason(String reason) {
    reportReason.value = reason;
  }

  void submitReport() {
    print("Report submitted with reason: ${reportReason.value}");
    Get.back();
  }
}