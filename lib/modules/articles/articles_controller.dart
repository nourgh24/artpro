
  import 'package:get/get.dart';
import 'articles_service.dart';
  class ArticlesController extends GetxController {
  var articles = <Article>[].obs;


  @override
  void onInit() {
  super.onInit();
  // تحميل البيانات عند بدء التطبيق
  loadArticles();
  }

  void loadArticles() {
  // جلب البيانات من مصدر البيانات، سواء كانت من API أو قاعدة بيانات محلية أو أي مصدر آخر
  articles.assignAll([
  Article(
  title: 'Article 1',
  imageUrl: 'images/4.jpg',
  authorImageUrl: 'images/5.jpg',
  authorName: 'John Doe',
  time: '12 hours ago',
  ),
  Article(
  title: 'Article 2',
  imageUrl: 'images/9.jpg',
  authorImageUrl: 'images/8.jpg',
  authorName: 'Jane Smith',
  time:'12 hours ago',
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