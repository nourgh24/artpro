import 'dart:typed_data';

import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
import '../articles/articles_service.dart';
import 'articles_list_service.dart';

class ArticleListController extends GetxController {
  var articlesList = <ArticleList>[].obs;
  Uint8List?image;
  // final ImagePicker _picker = ImagePicker();


  // Future<void> pickImage() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     final Uint8List imageData = await image.readAsBytes();
  //     this.image=imageData;
  //     update();
  //   }
  // }

  void addArticle(ArticleList article) {
    articlesList.add(article);
  }

  void updateArticle(int index, ArticleList article) {
    articlesList[index] = article;
  }

  void deleteArticle(int index) {
    articlesList.removeAt(index);
  }
  Uint8List getArticleImage(String imageString){
    return Uint8List.fromList(imageString.codeUnits);
  }
}
