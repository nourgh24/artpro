import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/articles%20list/add_article_model.dart';
import 'package:untitled5/modules/articles%20list/articles_list_service.dart';
import 'package:untitled5/modules/articles/articles_controller.dart';
import 'add_article.dart';
import 'articles_list_controller.dart';

class ArticlesList extends StatefulWidget {
  final int artistId;
   const ArticlesList({Key? key, required this.artistId}) : super(key: key);

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}
class _ArticlesListState extends State<ArticlesList> {
  final ArticleListController articleController = Get.put(
      ArticleListController());

@override
  void initState() {
    super.initState();
    int currentArtistId =  widget.artistId;
     print("AppSharedPreferences.getId: ${AppSharedPreferences.getId}");
    print("Current Artist ID: $currentArtistId");
    articleController.getArtistArticles(artistId: currentArtistId);
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    bool isCurrentArtist =  AppSharedPreferences.getRole==0 ;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        title: Text('Articles',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
      ),
      body: Obx(() {
         if (articleController.getarticleState.value ==
                      getArticleState.loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (articleController.getarticleState.value == getArticleState.error) {
                    return MaterialButton(
                      onPressed: () {
              articleController.getArtistArticles(artistId: widget.artistId);                      },
                      child: Center(child: Container(
                        color: Colors.orange[100],
                        child: Text("Try agein"))),
                    );
                  }
                  if (articleController.getarticleModel == null || 
                  articleController.getarticleModel!.Articles == null||
                articleController.getarticleModel!.Articles!.isEmpty
                  ) {
          return Center(child: Text('No articles available.'));
        }

        return ListView.builder(
          itemCount: articleController.getarticleModel!.Articles!.length,
          itemBuilder: (context, index) {
            final article = articleController.getarticleModel!.Articles![index];
            return Column(
              children: [
                Container(
                  height: screenheight*0.13,
                  child: Card(
                    key:ValueKey(article.id),
                    child: ListTile(
                      leading: CircleAvatar(
                              radius: 25,
                             backgroundImage: NetworkImage(
                          '${article.artist!.image}'),
                              ),
                      title: Text(article.title!),
                      //subtitle: Text(article.description!),
                      trailing: Container(
                        width: screenwidth*0.2,
                          height: screenheight*0.23,
                        child:  Positioned.fill(
                          child:  CachedNetworkImage(
                              placeholder: (context, url) => Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.5),
                                  highlightColor: Colors.grey,
                                  child: Container(
                                    width: double.maxFinite,
                                    height: screenheight * 0.5,
                                    color: Colors.grey,
                                  )),
                              imageBuilder: (context, imageProvider) => Container(
                                width: double.maxFinite,
                                height: screenheight * 0.5,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              fadeInDuration: const Duration(milliseconds: 4),
                              fadeOutDuration: const Duration(milliseconds: 4),
                              imageUrl: UrlsApi.baseimageUrl+ article.url! ,
                              errorWidget: (context, url, error) => Container(
                                width: double.maxFinite,
                                height: screenheight * 0.5,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('${articleController.imageUrl.value}'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              fit: BoxFit.cover,
                            ),
                        ),
                    ),
                     onTap: () => _editArticle(context, article,index),
                    ),
                  ),
                ),
                SizedBox(height: screenheight*0.01,),
              ],
            );
          },
        );
      }),
      floatingActionButton:isCurrentArtist
          ? FloatingActionButton(
        backgroundColor:Colors.orange[300],
        onPressed: () => Get.to(AddArticle()),
        child: Icon(Icons.add),
      ):null
    );
  }

  void _editArticle(BuildContext context, Result article, int index) {
    //final article = articleController.getarticleModel!.Articles![article];
    Get.to(AddArticle(
      index: index,
      article: AddArticlee(
      artistTitle: article.title!,
      articleText: article.description!,
      articleImage:File(article.url!),
      
      ),
      
    ));
  }
}

