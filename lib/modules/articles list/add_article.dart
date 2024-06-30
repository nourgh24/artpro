import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'articles_list_controller.dart';
import 'articles_list_service.dart';
import 'articles_list.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/Painting%20list/painging_avatar_widget.dart';
import 'package:untitled5/modules/articles%20list/add_article_model.dart';

class AddArticle extends StatelessWidget {
  final ArticleListController articleController = Get.find<ArticleListController>();
  final int? index;
  final AddArticlee? article;
  
  AddArticle({this.index, this.article});

  final articleTitleController = TextEditingController();
  final articleTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    if (article != null) {
      articleTitleController.text = article!.artistTitle;
      articleTextController.text = article!.articleText;
      articleController.image = article!.articleImage;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[200],
          title: Text(article == null ? 'Add Article' : 'Edit Article'),
          actions: [
            Obx(() {
              if (articleController.deletearticleState.value == DeleteArticleState.loading) {
                return CircularProgressIndicator();
              }

              if (article != null) {
                return TextButton(
                  onPressed: () async {
                    await articleController.deleteArticle(
                      articleId: articleController.getarticleModel!.Articles![index!].id!,
                    ); 

                    if (articleController.deletearticleState.value == DeleteArticleState.succsesful) {
                      Get.snackbar(
                        'Success',
                        'Article deleted successfully',
                        backgroundColor: Color.fromARGB(255, 202, 238, 203),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      Get.to(ArticlesList(artistId: articleController.getarticleModel!.Articles![index!].id!));
                    } /*else {
                      Get.snackbar(
                        'Error',
                        'Failed to delete article',
                        backgroundColor: Color.fromARGB(255, 241, 191, 187),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }*/
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            }),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Add Article image ",
                  style: TextStyle(
                    fontSize: 15,
                    backgroundColor: Colors.orange[50],
                  ),
                ),
                SizedBox(height: screenheight * 0.02),
                Container(
                  color: Colors.black12,
                  height: screenheight * 0.25,
                  width: screenwidth * 0.95,
                  child: Center(
                    child: Stack(
                      children: [
                        if (articleController.image != null)
                          Positioned.fill(
                            child: PaingingAvatarWidget(
                              fileImage: articleController.image!,
                            ),
                          ),
                        Align(
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: () {
                              articleController.pickImage().then((_) {
                                articleController.update();
                              });
                            },
                            icon: Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenheight * 0.02),
                Text(
                  "Add Article title ",
                  style: TextStyle(
                    fontSize: 15,
                    backgroundColor: Colors.orange[50],
                  ),
                ),
                SizedBox(height: screenheight * 0.02),
                TextFormField(
                  controller: articleTitleController,
                  decoration: InputDecoration(
                    labelText: 'Article Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: screenheight * 0.02),
                Text(
                  "Add Article Description ",
                  style: TextStyle(
                    fontSize: 15,
                    backgroundColor: Colors.orange[50],
                  ),
                ),
                SizedBox(height: screenheight * 0.02),
                TextFormField(
                  maxLines: 10,
                  minLines: 1,
                  style: TextStyle(fontSize: 15),
                  controller: articleTextController,
                  decoration: InputDecoration(
                    labelText: 'Article Text',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Obx(() {
                    if (articleController.addarticleState.value == AddArticleState.loading ||
                        articleController.updatearticleState.value == updateArticleState.loading) {
                      return CircularProgressIndicator();
                    }

                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[200],
                        padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                      ),
                      onPressed: () {
                        final newArticle = AddArticlee(
                          artistTitle: articleTitleController.text,
                          articleText: articleTextController.text,
                          articleImage: articleController.image!,
                        );

                        if (index == null) {
                          articleController.addArticle(addarticle: newArticle).then((_) {
                            Get.snackbar(
                              'Success',
                              'Article added successfully',
                              backgroundColor: Color.fromARGB(255, 194, 236, 196),
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            Get.offAll(ArticlesList(artistId: articleController.getarticleModel!.Articles!.last.id!));
                          }).catchError((error) {
                            /*Get.snackbar(
                              'Error',
                              'Failed to add article: $error',
                              backgroundColor: Color.fromARGB(255, 229, 185, 181),
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );*/
                          });
                        } else {
                          articleController.UpdateArticle(
                            articleId: articleController.getarticleModel!.Articles![index!].id!,
                            updateArticle: newArticle,
                          ).then((_) {
                            Get.snackbar(
                              'Success',
                              'Article updated successfully',
                              backgroundColor: Color.fromARGB(255, 194, 236, 196),
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            Get.offAll(ArticlesList(artistId: articleController.getarticleModel!.Articles![index!].id!));
                          }).catchError((error) {
                            Get.snackbar(
                              'Error',
                              'Failed to update article: $error',
                              backgroundColor: Color.fromARGB(255, 229, 185, 181),
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          });
                        }
                      },
                     
                      child: Text(article == null ? 'Add' : 'Update'),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
