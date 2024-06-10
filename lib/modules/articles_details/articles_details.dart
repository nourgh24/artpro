import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'articles_details_controller.dart';
import 'package:get/get.dart';
import 'articles_details_service.dart';

class ArticlesDetails extends StatefulWidget {
  const ArticlesDetails({super.key});

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
  final int commentsCount = 15;
  final int interactionsCount = 20;

  @override
  void initState(){
    super.initState();
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
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            height: screenheight*1.4,
            width: screenwidth,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                      height: screenheight*0.4,
                     width: screenwidth*0.95,
                     child: Obx(
                        () => ListView.builder(
                          scrollDirection: Axis.values.first,
                          itemCount: _controller.articles_details.length,
                          itemBuilder: (context, index) {
                            final Articles_Details article_detaile = _controller
                                .articles_details[index];
                            return GestureDetector(
                              onTap: () {
                                // يتم عرض تفاصيل الـ Card عند النقر عليه
                              },
                              child: Container(
                                child: Card(
                                  elevation: 10,
                                  margin: EdgeInsets.all(10),
                                  child: Stack(
                                    children: [
                                      // صورة المقال
                                      Image.asset(
                                        article_detaile.imageUrl,
                                        width: screenwidth*0.95, // عرض الصورة
                                        height: screenheight*0.4, // ارتفاع الصورة
                                        fit: BoxFit.cover,
                                      ),
                                      // زر لفتح تفاصيل الـ Card
                                      Positioned.fill(
                                        child: Material(
                                          color: Colors.black12,
                                          child: InkWell(
                                            onTap: () {
                                              // يتم عرض تفاصيل الـ Card عند النقر عليه
                                            },
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                        ),
                                      ),
                                      // صورة البروفايل

                                      Positioned(
                                        top: 10,
                                        left: 10,
                                        child: IconButton(
                                          onPressed: () {
                                            Get.toNamed('/Articles');
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
                                            _persistPreference(index);
                                          },
                                          icon: Icon(
                                            _controller.articles_details[index]
                                                .favorited ? Icons.favorite : Icons
                                                .favorite_border,
                                            //  Favorited?Icons.favorite:Icons.favorite_border,
                                            color: _controller.articles_details[index]
                                                .favorited ? Colors.red : Colors
                                                .white,
                                            size: 25,
                                          ),
                                        ),

                                      ),
                                      // اسم الكاتب

                                      // عنوان المقال
                                      Positioned(
                                        bottom: 10,
                                        left:20,
                                        child: Text(
                                          article_detaile.title,
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
                              ),
                            );
                          },
                  ),
                  ),
                  ),

                SizedBox(
                  height:screenheight*0.02,
                ),
                  Container(
                    height: screenheight*0.12,
                    child: Obx(
                    () => ListView.builder(
                    itemCount: _controller.articles_details.length,
                    itemBuilder: (context, index) {
              final Articles_Details article_detaile = _controller
                  .articles_details[index];
              return GestureDetector(
                onTap: () {
                  // يتم عرض تفاصيل الـ Card عند النقر عليه
                },
                child:
                Container(
                  width: screenwidth*0.9,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  SizedBox(width: screenwidth*0.01,),
                  CircleAvatar(
                      radius: 27,
                      backgroundImage: AssetImage(
                        article_detaile.authorImageUrl),
                    ),

                  Column(
                    children: [
                      TextButton(
                          onPressed: () {}, child: Text(
                          article_detaile.authorName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        ),
                     SizedBox(height: 0.01,),
                     Text(
                        article_detaile.time,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 8,
                          fontWeight: FontWeight.normal,
                        ),

                      ),
                    ],
                  ),
                  SizedBox(width: screenwidth*0.37,),
                  TextButton(
                      child: Text('Report the article',
                      style: TextStyle(
                        color: Colors.orangeAccent,
                      ),
                      ),
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            backgroundColor: Colors.orange[50],
                            title: Text('Reason for reporting',
                              style: TextStyle(color: Colors.black54, fontSize: 15),),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  onChanged: (value) {
                                    _controller.updateReportReason(value);
                                  },
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    counterStyle: CupertinoTextField.cupertinoMisspelledTextStyle,
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter Rrason here...',


                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  _controller.submitReport();
                                },
                                child: Text('Save',style:TextStyle(color: Colors.black45,),),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('cancle',style:TextStyle(color:Colors.black45,)),
                              ),
                            ],
                          ),
                        );

                      }),
                  ],
                  ),
              ),
              );
                    },
                    ),
                    ),
                  ),
                Center(
                  child:
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: screenheight*0.6,
                    width: screenwidth*0.9,
                    child: Obx(
                          () => ListView.builder(
                        scrollDirection: Axis.vertical, // التمرير الشاقولي
                        itemCount: _controller.articles_details.length,
                        itemBuilder: (context, index) {
                          final Articles_Details article_detaile = _controller
                              .articles_details[index];
                          return GestureDetector(
                            onTap: () {
                              // يتم عرض تفاصيل الـ Card عند النقر عليه
                            },
                            child:
                            Column(
                              children: [
                                Container(
                                  color: Colors.white,
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                      Text(
                                        article_detaile.ArticleText,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ],
              ),
                            );
              }
                            ),
                          ),
                      ),
                    ),
                  ),
                SizedBox(height: screenheight*0.05,),
                Row(
                  children: [
                    SizedBox(
                      height: screenheight*0.1,
                      width: screenwidth*0.05,
                    ),

                    SizedBox(width: screenwidth*0.005,),
                    Container(
                      width: screenwidth*0.5,
                      height: screenheight*0.06,
                      color: Colors.black12,
                      child: TextButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Add a Comment',
                                style: TextStyle(
                              color: Colors.blueAccent,
                                ),),
                              SizedBox(width: screenwidth*0.05,),
                               Text(
                                    '($commentsCount)',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                            ],
                          ),
                          onPressed: () {
                            Get.toNamed('/CommentView');

                          }),
                    ),
                    SizedBox(width: screenwidth*0.05,),
                    IconButton(
                      onPressed:(){
                        _likedPreference();
                      },
                      icon:Icon(
                        Liked?Icons.thumb_up:Icons.thumb_up_alt_outlined,
                        //  Favorited?Icons.favorite:Icons.favorite_border,
                        color:  Liked?Colors.blue:Colors.grey,
                        size: 25,
                      ),
                    ),
                    SizedBox(width: screenwidth*0.005,
                      child: SizedBox(
                        child: Text('$Like_count'),
                      ),
                    ),

                    IconButton(
                      onPressed:(){
                        _dislikedPreference();
                      },
                      icon:Icon(
                        DisLiked?Icons.thumb_down_alt:Icons.thumb_down_alt_outlined,
                        //  Favorited?Icons.favorite:Icons.favorite_border,
                        color:  DisLiked?Colors.blue:Colors.grey,
                        size: 25,
                      ),
                    ),
                    SizedBox(width: screenwidth*0.005,
                      child: SizedBox(
                        child: Text('$DisLike_count'),
                      ),
                    ),
                    SizedBox(width: screenwidth*0.001,),
                    TextButton(onPressed: (){
                    },
                        child:  Text(
                          '($interactionsCount)',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),),
                  ],
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
