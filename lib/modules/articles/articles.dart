import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/modules/articles/articles_controller.dart';
import 'package:untitled5/modules/articles/articles_controller.dart';
import 'package:untitled5/modules/articles_details/articles_details.dart';
import 'package:untitled5/modules/articles_details/articles_details_service.dart';
import 'articles_controller.dart';
import 'articles_service.dart';

class Articles extends StatefulWidget {
  const Articles({super.key});

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {

  final ArticlesController _controller = Get.put(ArticlesController());
  static const favoritedKey='favorited_Key';
  late bool Favorited=false;

  @override
    void initState(){
    super.initState();
    _restorepersistedPreference();
    _controller.getAllArticles();
  }
  void _restorepersistedPreference()async{
    var preferences=await SharedPreferences.getInstance();
    var Favorited =preferences.getBool(favoritedKey);
    setState(()
     => this.Favorited=Favorited!);
  }

  void _persistPreference(int articleId)async{
    setState(() {
      _controller.articles[articleId].favorited=!_controller.articles[articleId].favorited;
    });
    var preferences=await SharedPreferences.getInstance();
    preferences.setBool(favoritedKey,Favorited);
  }
  @override
    Widget build(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: screenheight*1,
        width: screenwidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
            height: screenheight  *0.17,
            width: screenwidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
              color: Colors.orange[100],
            ),
            child: Stack(children: [
              Positioned(
                top: 30,
                left: 0,
                child: Container(
                  height: screenheight *0.07,
                  width: screenwidth *0.7,
                   decoration: BoxDecoration(
                  color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),                  
                ),
              ),

              Positioned(
                top: 40,
                left: 20,
                child:  Text("Article of art",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontSize: 20,
                color: Colors.orange[200],
                ),
                ),
              ),
            ],),
            ),
          SizedBox(
            height: screenheight*0.01,
          ),
        Expanded(
          child: Obx((){
            if (_controller.articleState.value ==
                      ArticlesState.loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (_controller.articleState.value == ArticlesState.error) {
                    return MaterialButton(
                      onPressed: () {
                        _controller.getAllArticles();
                      },
                      child: Center(child: Container(
                        color: Colors.orange[100],
                        child: Text("Try agein to view the articles"))),
                    );
                  }
                      return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _controller.articlesModel!.articles!.length,
                      itemBuilder: (context, index) {
                        final Article article = _controller.articles[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => ArticlesDetails(
                        complaint:AddComplaint(Description: ""),
                       articleId: _controller.articlesModel!.articles![index].id!,
                             ));
                          },
                          child: Container(
                            width: screenwidth*0.95,
                            height: screenheight*0.35,
                            child: Card(
                                elevation: 20,
                                margin: EdgeInsets.all(12),
                                child: Stack(
                                  children: [
                                    // صورة المقال
                                   CachedNetworkImage(
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey.withOpacity(0.5),
                                    highlightColor: Colors.grey,
                                    child: Container(
                                      height:screenheight*0.22,
                                      width: screenwidth,
                                    ),
                                  ),
                                  imageBuilder: (context, imageProvider) => Image(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    height: screenheight *0.22,
                                    width: screenwidth,
                            
                                  ),
                                  fadeInDuration: const Duration(milliseconds: 4),
                                  fadeOutDuration:const Duration(milliseconds: 4),
                                  imageUrl:UrlsApi.baseimageUrl+ _controller
                                      .articlesModel!.articles![index].url!,
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    _controller.imageUrl,
                                    fit: BoxFit.cover,
                                    height: screenheight * 0.22,
                                    width: screenwidth,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                   
                                    Positioned(
                                      top: 10,
                                      left: 10,
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(
                                          _controller
                                      .articlesModel!.articles![index].artist!.image??
                              ""),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                        right: 10,
                                        child:IconButton(
                                          onPressed:(){
                                            _persistPreference(index);
                                          },
                                          icon:Icon(
                                            _controller.articles[index].favorited?Icons.favorite:Icons.favorite_border,
                                          //  Favorited?Icons.favorite:Icons.favorite_border,
                                            color:  _controller.articles[index].favorited?Colors.red:Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                      
                                    ),
                                    // اسم الكاتب
                                    Positioned(
                                      top: 5,
                                      left: 50,
                                      child: TextButton(onPressed: (){},
                                      child: Text(
                                          _controller.articlesModel!.articles![index].artist!.name!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      
                                      ),
                                    ),
                                    ),
                                      
                                    Positioned(
                                      top: 20,
                                      left: 50,
                                      child: TextButton(onPressed: (){},child: Text(
                                        _controller.articlesModel!.articles![index].formattedCreationDate!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      
                                      ),
                                      ),
                                    ),
                                    // عنوان المقال
                                    Positioned(
                                      bottom: 90,
                                      left: 10,
                                      child: Text(
                                        _controller.articlesModel!.articles![index].title!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    Positioned(
                                      bottom: 0,
                                      right: 10,
                                      child: Center(
                                        child: Text(
                                          _controller.articlesModel!.articles![index].description!,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Lateef',
                                          ),
                                        ),
                                      ),
                                    ),



                                    
                                  ],
                                ),
                              ),
                          ),
                        
                          );
                      },

                      );
                      },
        ),
        
        ),
        ],
          ),
      ),

    );
  }
}
