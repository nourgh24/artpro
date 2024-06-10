import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'articles_list_controller.dart';
import 'articles_list_service.dart';

class AddArticle extends StatelessWidget {
  final ArticleListController articleController = Get.find<ArticleListController>();

  final int? index;
  final ArticleList? article;

  AddArticle({this.index, this.article});

  final artistNameController = TextEditingController();
  final articleTextController = TextEditingController();
  final articleImageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    if (article != null) {
      artistNameController.text = article!.artistName;
      articleTextController.text = article!.articleText;
      articleImageController.text = article!.articleImage;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(article == null ? 'Add Article' : 'Edit Article'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: screenheight * 0.4,
              width: screenwidth * 0.9,
              child: Center(
                child: Stack(
                  children: [
                    if (articleController.image != null)
                      Positioned.fill(
                        child: Image.memory(
                          articleController.image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: () {
                          // articleController.pickImage();
                        },
                        icon: Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TextField(
              controller: artistNameController,
              decoration: InputDecoration(labelText: 'Artist Name'),
            ),
            TextField(
              controller: articleTextController,
              decoration: InputDecoration(labelText: 'Article Text'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newArticle = ArticleList(
                  artistName: artistNameController.text,
                  articleText: articleTextController.text,
                  articleImage: articleController.image != null
                      ? String.fromCharCodes(articleController.image!)
                      : '',
                );

                if (index == null) {
                  articleController.addArticle(newArticle);
                } else {
                  articleController.updateArticle(index!, newArticle);
                }

                Get.back();
              },
              child: Text(article == null ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}
