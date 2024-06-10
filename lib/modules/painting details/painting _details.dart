import 'package:untitled5/modules/painting%20details/painting_details_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaintingDetails extends StatefulWidget {
  const PaintingDetails({super.key});

  @override
  State<PaintingDetails> createState() => _PaintingDetailsState();
}

class _PaintingDetailsState extends State<PaintingDetails> {

  final PaintingDetailsController _controller = Get.put(PaintingDetailsController());
  static const favoritedKey='favorited_Key';
  static const likedKey='likedKey';
  static const dislikedKey='dislikedKey';
  late bool Favorited=false;
  late bool Liked=false;
  late bool DisLiked=false;
  double rating = 0; // التقييم الابتدائي
  int Like_count=0;
  int DisLike_count=0;
  final int commentsCount = 15;
  final int interactionsCount = 20;


  @override
  void initState(){
    super.initState();
    _favorited();
    _liked();
    _disliked();
  }
  void _favorited()async{
    var preferences=await SharedPreferences.getInstance();
    var Favorited =preferences.getBool(favoritedKey);
    setState(()
    => this.Favorited=Favorited!
    );
  }

  void _favoritedPreference()async{
    setState(() {
      Favorited=!Favorited;
    });
    var preferences=await SharedPreferences.getInstance();
    preferences.setBool(favoritedKey,Favorited);
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
  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    return Scaffold(
    body: SingleChildScrollView(
      child: Container(
        width: screenwidth,
      height: screenheight*1.8,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: screenheight*0.70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('${_controller.imageUrl.value}'),
                      fit: BoxFit.cover),
                ),

              )),
          Positioned(
            left: 20,
              top:30,
              child:Row(
                children: [
                  IconButton(onPressed: (){},
                      icon: Icon(Icons.arrow_back_ios),
                  color: Colors.grey,
                  ),

                ],
              ),),
          Positioned(
            top: 30,
            right: 20,
            child:IconButton(
              onPressed:(){
                _favoritedPreference();
              },
              icon:Icon(
                Favorited?Icons.favorite:Icons.favorite_border,
                //  Favorited?Icons.favorite:Icons.favorite_border,
                color:  Favorited?Colors.red:Colors.grey,
                size: 25,
              ),
            ),

          ),
          Positioned(
            top:360,
                child:
                   SingleChildScrollView(
                     child: Container(
                       padding: const EdgeInsets.only(left: 20,right: 20,top: 40 ),
                       width: screenwidth,
                        height: screenheight*1.5,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                         ),
                        ),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                              //_controller.showDetails.value,
                              children: [
                                //visible: _controller.showDetails.value,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Image Details',style: TextStyle(color: Colors.orangeAccent,
                                      fontSize: 30,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  ],
                                ),
                                SizedBox(height: screenheight*0.05,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  /*  Text('Artist Name:',
                                      style: TextStyle(color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                          backgroundColor: Colors.black12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: screenheight*0.01,),
                                    TextButton(onPressed: (){},
                                        child: Text('${_controller.artist.value}',
                                          style: TextStyle(color: Colors.black87,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),),*/
                                    Row(
                                      children: [
                                        Positioned(
                                          top: 460,
                                          left: 30,
                                          child: CircleAvatar(
                                            radius: 27,
                                            backgroundImage: AssetImage('${_controller.authorImageUrl.value}'),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Positioned(
                                              top: 500,
                                              left: 100,
                                              child: TextButton(onPressed: (){},
                                                child: Text('${_controller.artist.value}',
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 510,
                                              left: 60,
                                              child:Text('${_controller.time.value}',
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.normal,
                                                ),

                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),

                                    SizedBox(height: screenheight*0.02,),
                                    Text('Title:',
                                      style: TextStyle(color: Colors.grey,
                                          fontStyle: FontStyle.italic,
                                        backgroundColor: Colors.black12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: screenheight*0.01,),
                                    Text('${_controller.title.value}',
                                      style: TextStyle(color: Colors.black87,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    SizedBox(height: screenheight*0.02,),
                                    Text('Type:',
                                      style: TextStyle(color: Colors.grey,
                                          fontStyle: FontStyle.italic,
                                        backgroundColor: Colors.black12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: screenheight*0.01,),
                                    Text(' ${_controller.imageType.value}',
                                      style: TextStyle(color: Colors.black87,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    SizedBox(height: screenheight*0.02,),
                                    Text('Size:',
                                      style: TextStyle(color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        backgroundColor: Colors.black12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height:screenheight* 0.01,),
                                    Text(' ${_controller.size.value}',
                                      style: TextStyle(color: Colors.black87,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    SizedBox(height:screenheight* 0.02,),
                                    Text('Price:',
                                      style: TextStyle(color: Colors.grey,
                                          fontStyle: FontStyle.italic,
                                        backgroundColor: Colors.black12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: screenheight*0.01,),
                                    Text(' ${_controller.imagePrice.value}',
                                      style: TextStyle(color: Colors.black87,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    SizedBox(height: screenheight*0.02,),
                                    Text('Description:',
                                      style: TextStyle(color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        backgroundColor: Colors.black12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Center(
                                          child: Container(
                                            height: screenheight*0.1,
                                            width: screenwidth*0.9,
                                            child: Text(' ${_controller.imageDescription.value}',
                                              style: TextStyle(color: Colors.black87,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: screenheight*0.02,),
                                    Row(
                                      children: [
                                        Text('Rate:',
                                          style: TextStyle(color: Colors.grey,
                                            fontStyle: FontStyle.italic,
                                            backgroundColor: Colors.black12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: screenwidth*0.01,),
                                        RatingBar.builder(
                                          initialRating: rating, // التقييم الابتدائي
                                          minRating: 1, // الحد الأدنى للتقييم
                                          direction: Axis.horizontal, // اتجاه التقييم
                                          allowHalfRating: true, // السماح بتقييم نصف نجمة
                                          itemCount: 5, // عدد النجوم
                                          itemSize: 30, // حجم النجوم
                                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0), // المسافة بين النجوم
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (newRating) {
                                            setState(() {
                                              rating = newRating; // تحديث التقييم عند تغييره
                                            });
                                            // هنا يمكنك استخدام newRating لحفظ التقييم في قاعدة البيانات
                                            // على سبيل المثال:
                                            // _controller.saveRatingToDatabase(newRating);
                                          },
                                        ),

                                      ],
                                    ),
                                    SizedBox(height: screenheight*0.01,),
                                    Row(
                                      children: [
                                        Text('Total Rate:',
                                          style: TextStyle(color: Colors.grey,
                                            fontStyle: FontStyle.italic,
                                            backgroundColor: Colors.black12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: screenwidth*0.01,),
                                        Obx(() => Column(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 25,
                                            ),
                                            Text(
                                              '${_controller.totalRating.value}',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        )),
                                        SizedBox(width: screenwidth*0.2,),
                                        ElevatedButton(
                                          onPressed: () {//Get.offNamed(PageHome());//Get.toNamed('/ChooseRole');
                                          },
                                          child: Text('Buy Now',
                                            style: TextStyle(
                                              fontSize:20,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.orangeAccent,
                                            padding: const EdgeInsets.only(left: 30,right: 30,top: 15,bottom: 15 ),
                                            elevation: 5,
                                            textStyle: TextStyle(fontStyle: FontStyle.italic),
                                          ),),
                                        SizedBox(width: screenwidth*0.01,),
                                        ElevatedButton(
                                          onPressed: () {//Get.offNamed(PageHome());//Get.toNamed('/ChooseRole');
                                          },
                                          child: IconButton(onPressed: (){},
                                            icon: Icon(
                                              Icons.shopping_bag,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.orangeAccent,

                                            padding: const EdgeInsets.only(left: 10,right: 10,top:12,bottom: 4 ),
                                            elevation: 5,
                                            textStyle: TextStyle(fontStyle: FontStyle.italic),
                                          ),),
                                      ],
                                    ),
                                    SizedBox(height: screenheight*0.01,),
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
                                                    ),
                                                  ),
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
                                        TextButton(onPressed: (){},
                                          child:  Text(
                                            '($interactionsCount)',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),),
                                      ],),],),],),),),),
        ],
                   ),
          ),
    ),
    );
  }
}




