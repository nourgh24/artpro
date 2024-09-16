import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/modules/articles/articles.dart';
import 'package:untitled5/modules/articles_details/articles_details_model';
import 'package:untitled5/modules/articles_details/articles_details_model';
import 'articles_details_controller.dart';
import 'package:get/get.dart';
import 'articles_details_service.dart';
import 'package:untitled5/modules/article%20comments/article_comments.dart';


class ArticlesDetails extends StatefulWidget {
  final AddComplaint? complaint;
  final int articleId;
  ArticlesDetails({required this.articleId,required this.complaint, super.key});

  final complaintDescriptionController = TextEditingController();
  
  @override
  State<ArticlesDetails> createState() => _ArticlesDetailsState();
  
}

class _ArticlesDetailsState extends State<ArticlesDetails> {

  final ArticlesDetailsController _controller = Get.put(ArticlesDetailsController());
  static const favoritedKey='favorited_Key';
  static const likedKey='likedKey';
  static const dislikedKey='dislikedKey';
  late bool Favorited=false;
  late bool Liked=false;
  late bool DisLiked=false;
  int Like_count=0;
  int DisLike_count=0;

 
  
  @override
  void initState(){
    super.initState();
     if (widget.complaint != null) {
      widget.complaintDescriptionController.text = widget.complaint!.Description;
    }
    _controller.getArticleDetails(articleId: widget.articleId);
    _restorepersistedPreference();
    _liked();
    _disliked();

  }


  void _liked()async{
    var preferences=await SharedPreferences.getInstance();
    var Liked=preferences.getBool(likedKey);
    setState(()
    => this.Liked=Liked!
    );
  }
  void _likedPreference()async{
    setState(() {
      if(Liked){
        Like_count -=1;
        Liked=false;
      }else{
        Like_count +=1;
        Liked=true;
      }
      // Liked=!Liked;
    });
    var preferences=await SharedPreferences.getInstance();
    preferences.setBool(likedKey,Liked);
  }
  void _disliked()async{
    var preferences=await SharedPreferences.getInstance();
    var DisLiked=preferences.getBool(dislikedKey);
    setState(()
    => this.DisLiked=DisLiked!
    );
  }
  void _dislikedPreference()async{
    setState(() {
      if(DisLiked){
        DisLike_count -=1;
        DisLiked=false;
      }else{
        DisLike_count +=1;
        DisLiked=true;
      }
      //DisLiked=!DisLiked;
    });
    var preferences=await SharedPreferences.getInstance();
    preferences.setBool(dislikedKey,DisLiked);
  }
  void _restorepersistedPreference()async{
    var preferences=await SharedPreferences.getInstance();
    var Favorited =preferences.getBool(favoritedKey);
    setState(()
    => this.Favorited=Favorited!);
  }

  void _persistPreference(int articleId)async{
    setState(() {
      _controller.articles_details[articleId].favorited=!_controller.articles_details[articleId].favorited;
    });
    var preferences=await SharedPreferences.getInstance();
    preferences.setBool(favoritedKey,Favorited);
  }

@override
Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
   
  return SafeArea(
    child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: screenHeight*0.95,
            width: screenWidth,
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    if (_controller.articledetailsState.value == ArticleDetailsState.loading) {
                      return Center(child: CircularProgressIndicator());
                    }
    
                    if (_controller.articledetailsState.value == ArticleDetailsState.error) {
                      return SizedBox();
                    }
    
                    return Column(
                      children: [
                        Card(
                          elevation: 2,
                          margin:EdgeInsets.all(2) ,
                          child: Stack(
                            children: [
                              Positioned(
                                 child:CachedNetworkImage(
                            placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(0.5),
                                highlightColor: Colors.grey,
                                child: Container(
                                  width: double.maxFinite,
                                  height: screenHeight*0.37,
                                  color: Colors.grey,
                                )),
                            imageBuilder: (context, imageProvider) => Container(
                              width: double.maxFinite,
                                  height: screenHeight*0.37,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            fadeInDuration: const Duration(milliseconds: 4),
                            fadeOutDuration: const Duration(milliseconds: 4),
                            imageUrl: UrlsApi.baseimageUrl+ _controller.articledetailsModel!.article!.url!,
                            errorWidget: (context, url, error) => Container(
                              width: double.maxFinite,
                                  height: screenHeight*0.37,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('${_controller.imageUrl}'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            fit: BoxFit.cover,
                          ),
                              ),
                              Positioned(
                                top: 10,
                                left: 10,
                                child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: IconButton(
                                  onPressed: () {
                                     _persistPreference(1);
                                  },
                                  icon: Icon(
                                    _controller.articles_details[0].favorited ? Icons.favorite : Icons.favorite_border,
                                    color: _controller.articles_details[0].favorited ? Colors.red : Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 20,
                                child: Text(
                                  _controller.articledetailsModel!.article!.title??"",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.02),
                     Container(
                  width: screenWidth * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //////////////////////////////////////////////////////////////////////////
                       CachedNetworkImage(
                        placeholder: (context, url) => Center(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.5),
                            highlightColor: Colors.grey,
                            child: const CircleAvatar(
                              radius: 25,
                            ),
                          ),
                        ),
                        imageUrl: _controller.articledetailsModel!.article!.artist!.image ?? "",
                        errorWidget: (context, url, error) => CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage('${_controller.articles_details[0]}'),
                        ),
                        fit: BoxFit.cover,
                      ),
                      ///////////////////////////////////////////////////////////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///////////////////////////////////////////////////////////////////////////
                         TextButton(
                            onPressed: () {},
                            child: Text(
                              '${_controller.articledetailsModel!.article!.artist!.name??""}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                         Text(
                            '${_controller.articledetailsModel!.article!.formattedCreationDate}',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          ///////////////////////////////////////////////////////////////////////////////
                        ],
                      ),
                      SizedBox(width: screenWidth * 0.15),
                      TextButton(
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              backgroundColor: Colors.orange[50],
                              title: Text(
                                'Reason for reporting',
                                style: TextStyle(color: Colors.black54, fontSize: 15),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                  /*  onChanged: (value) {
                                      _controller.updateReportReason(value);
                                    },*/
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter Reason here...',
                                    ),
                                   controller: widget.complaintDescriptionController,
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                               final newcomplaint = AddComplaint(
                               Description:widget.complaintDescriptionController.text,
                               ); 
                                     _controller.addComplaint(
                                      addcopmlaint: newcomplaint,
                                      articleId: widget.articleId,
                                      );
                                       // _controller.submitReport();
                                        Get.back();
                                  },
                                  child: Text('Save', style: TextStyle(color: Colors.black45)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('Cancel', style: TextStyle(color: Colors.black45)),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text(
                          'Report the article',
                          style: TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                /////////////////////////////////////////////////////////////////////////
                Container(
                  height: screenHeight * 0.3,
                  width: screenWidth * 0.85,
                  child: SingleChildScrollView(
                    child: Text(
                      '${_controller.articledetailsModel!.article!.description ??""}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Lateef',
                      ),
                    ),
                  ),
                ),
                ///////////////////////////////////////////////////////////////////////////
                SizedBox(height: screenHeight * 0.05),
                 Row(
                  children: [
                    SizedBox(width: screenWidth * 0.05),
                    Container(    
                      width: screenWidth * 0.5,
                      height: screenHeight * 0.06,
                      color: Colors.black12,
                      child: TextButton(
                        onPressed: () {
                          Get.to(CommentView(
                            id: _controller.articledetailsModel!.article!.id!,
                            apiUrl: UrlsApi.articlesCommentsApi,
                          ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Add a Comment',
                              style: TextStyle(
                                color: Colors.orange[200],
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.05),
                            //////////////////////////////////////////////////////////////////////////
                           Text(
                              '(${_controller.articledetailsModel!.article!.commentsNumber ??""})',
                              style: TextStyle(
                                color: Colors.orange[200],
                              ),
                            ),
                            ////////////////////////////////////////////////////////////////////////
                          ],
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        () async{
                        AddArticleLike likedetails = AddArticleLike(Like: "like");
                     await _controller.addLike_Article(likedetails: likedetails, articleId: _controller.articledetailsModel!.article!.id!);                      // _likedPreference();
                       setState(() {
                    Liked = !Liked;
                     if (Liked) {
                    DisLiked = false;
                           }} );
                        };
                         _likedPreference();
                      },
                      icon: Icon(
                        Liked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                        color: Liked ? Colors.blue : Colors.grey,
                        size: 25,
                      ),
                    ),

                    IconButton(
                       onPressed: () {
                        () async{
                        AddArticleDisLike Dislikedetails = AddArticleDisLike(DisLike: "dislike");
                     await _controller.addDisLike_Articles(dislikedetails: Dislikedetails,articleId: _controller.articledetailsModel!.article!.id! );
                       // _likedPreference();

                       setState(() {
                    DisLiked = !DisLiked;
                     if (DisLiked) {
                    Liked = false;
                           }} );
                        };
                         _dislikedPreference();
                      },
                     
                      icon: Icon(
                        DisLiked ? Icons.thumb_down_alt : Icons.thumb_down_alt_outlined,
                        color: DisLiked ? Colors.blue : Colors.grey,
                        size: 25,
                      ),
                    ),
                    ////////////////////////////////////////////////////////////////////////////////
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '(${_controller.articledetailsModel!.article!.interactionsNumber})',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                ///////////////////////////////////////////////////////////////////////////////////////////
                  ],
                ),
                      ],
                    );
                  }),
                ),
              ],            
            ),
          ),
        ),
      ),
    ),
  );
}
}

