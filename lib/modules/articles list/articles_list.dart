import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_article.dart';
import 'articles_list_controller.dart';

class ArticlesList extends StatefulWidget {
  const ArticlesList({super.key});

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}
class _ArticlesListState extends State<ArticlesList> {
  final ArticleListController articleController = Get.put(
      ArticleListController());

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenheight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        title: Text('Articles',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: articleController.articlesList.length,
          itemBuilder: (context, index) {
            final article = articleController.articlesList[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('images/4.jpg'),
                ),
                title: Text(article.artistName),
                subtitle: Text(article.articleText),
                trailing: Container(
                  width: screenwidth*0.2,
                    height: screenheight*0.23,
                    child:article.articleImage.isNotEmpty
                        ?Image.memory(articleController.getArticleImage(article.articleImage),
                      fit: BoxFit.cover,
                    )
                        :Container(),
                ),
                onTap: () => _editArticle(context, index),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.orange[300],
        onPressed: () => Get.to(AddArticle()),
        child: Icon(Icons.add),
      ),
    );
  }

  void _editArticle(BuildContext context, int index) {
    final article = articleController.articlesList[index];
    Get.to(AddArticle(
      article: article,
      index: index,
    ));
  }
}

