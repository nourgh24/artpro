import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
          SizedBox(height: screenheight*0.01,),
        IconButton(onPressed:(){
          Get.toNamed('/Welcome');
        },
          icon: Icon(Icons.arrow_back),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
        SizedBox(width: screenwidth*0.01,),
        Text("Articles of art",
          style: TextStyle(fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Colors.blueGrey,
          ),
          ),
          SizedBox(width: screenwidth*0.6,),
        IconButton(onPressed:(){
          Get.toNamed('/Navpar');

        },
          icon: Icon(Icons.arrow_forward,
            color: Colors.blue,
          ),
        ),

        ],
          ),
        SizedBox(height: screenwidth*0.005,),
        Column(
          children: [
            Center(
              child: Container(
                height: screenheight*0.67,
                width: screenwidth*0.9,
                child: Obx(
                      () => ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _controller.articles.length,
                    itemBuilder: (context, index) {
                      final Article article = _controller.articles[index];
                      return GestureDetector(
                        onTap: () {
                          // يتم عرض تفاصيل الـ Card عند النقر عليه
                        },
                        child: Container(
                          width: screenwidth*0.9,
                          height: screenheight*0.25,
                          child: Card(
                            elevation: 10,
                            margin: EdgeInsets.all(10),
                            child: Stack(
                              children: [
                                // صورة المقال
                                Image.asset(
                                  article.imageUrl,
                                  width: screenwidth*0.9, // عرض الصورة
                                  height:screenheight*0.25, // ارتفاع الصورة
                                  fit: BoxFit.cover,
                                ),

                                // زر لفتح تفاصيل الـ Card
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.black12,
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed('/ArticlesDetails');
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
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: AssetImage(article.authorImageUrl),
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
                                  top: 15,
                                  left: 50,
                                  child: TextButton(onPressed: (){},child: Text(
                                      article.authorName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),

                                  ),
                                ),
                                ),

                                Positioned(
                                  top: 30,
                                  left: 50,
                                  child: TextButton(onPressed: (){},child: Text(
                                    article.time,
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
                                  bottom: 10,
                                  left: 10,
                                  child: Text(
                                    article.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
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
            ),
          ],
        ),
            SizedBox(height: 40,),
       /*     Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                SizedBox(width: 10,),
                Text("Latest Articles",
                  style: TextStyle(fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(width: 300,),
                IconButton(onPressed:(){
                },
                  icon: Icon(Icons.arrow_forward,
                    color: Colors.blue,
                  ),
                ),

              ],
            ),

            Container(
              height: 180,
              child: Obx(
                    () => ListView.builder(
                  scrollDirection: Axis.horizontal, // التمرير الأفقي
                  itemCount: _controller.latestarticles.length,
                  itemBuilder: (context, index) {
                    final LatestArticle latestArticle = _controller.latestarticles[index];
                    return GestureDetector(
                      onTap: () {
                        // يتم عرض تفاصيل الـ Card عند النقر عليه
                      },
                      child: Container(
                        width: 200,
                        child: Card(
                          elevation: 10,
                          margin: EdgeInsets.all(10),
                          child: Stack(
                            children: [
                              // صورة المقال
                              Image.asset(
                                latestArticle.image,
                                width: 250, // عرض الصورة
                                height:100, // ارتفاع الصورة
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
                              // اسم الكاتب
                              Positioned(
                                bottom: 15,
                                left: 58,
                                child: TextButton(onPressed: (){},child: Text(
                                  latestArticle.Name,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
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
                ),
              ),
            ),
            */
        ],
          ),
      ),

    );
  }
}
