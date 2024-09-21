import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/Painting%20list/painting_list.dart';
import 'package:untitled5/modules/Profile%20Edit/profile_edit.dart';
import 'package:untitled5/modules/articles%20list/articles_list.dart';
import 'package:untitled5/modules/certificate%20of%20reliability/certificate.dart';
import 'package:untitled5/modules/profiles/profiles_controller.dart';
import 'package:untitled5/modules/welcome/welcome.dart';

class Profiles extends StatefulWidget {
final int artistId;
  const Profiles({
   required this.artistId, 
    super.key});


  @override
  State<Profiles> createState() => _ProfileState();
}

class _ProfileState extends State<Profiles> {
  final GlobalKey<ScaffoldState> key =GlobalKey();
  final ProfilesController _controller = Get.put(ProfilesController());

  @override
  void initState() {
    super.initState();
   _controller.GetProfile(artistId: widget.artistId);

  }
  int id=AppSharedPreferences.getId ;
  double rating = 1.5; 
  bool click_folow = false;


  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        key: key,
         endDrawer: Container(
          height: screenheight* 0.7,
          width: screenwidth *0.55,
          color: const Color.fromARGB(255, 227, 222, 214),
          child:ListView(
            children: [
              Container(
                width: screenwidth*0.5,
                height: screenheight *0.1,
                decoration: BoxDecoration(color:Colors.black12 ),
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text("Edit Profile"),
                onTap: () {
                 Get.to( ProfileEdit());
                  
                }
                ),
                 ListTile(
                leading: const Icon(Icons.post_add_outlined),
                title: const Text("Add Certificate"),
                onTap: () {
                Get.to(ArtistView( role: 0,apiUrl: UrlsApi.CertificateApi, ));
                }
                ),
                 ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text("Log out"),
                onTap: () {
                  AppSharedPreferences.removeToken();
                 AppSharedPreferences.removeRole();
                 AppSharedPreferences.removeId();
                 Get.offAll(Welcome());
                      
                }
                ),
                ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Setting"),
                onTap: () {
                  
                }
                ),
            ],
              ),
          ),
        appBar: AppBar(
          backgroundColor: Colors.orange[200],
          title: Text("Profile", style: TextStyle(color: Colors.white, fontSize: 23),),
        ),
       
        body:Padding(
          padding: EdgeInsets.all(2.0),
          child: SingleChildScrollView(
            child: SizedBox(
            height: screenheight*0.93,
            width: screenwidth,
              child: Column(
                children: [
                  Expanded(
                    child:Obx((){
                       if (_controller.getprofileState.value == GetProfileState.loading) {
                        return Center(child: CircularProgressIndicator());
                      }
                  
                      if (_controller.getprofileState.value == GetProfileState.error) {
                        return SizedBox();
                      }
                      return  Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 220, 215, 215),

                      ),
                      height: screenheight*0.9,
                      width: screenwidth,
                      child: 
                          Stack(
                            children: [
                               Container(
                                height: screenheight *0.35,
                                 decoration: BoxDecoration(
                                  color:Color.fromARGB(255, 204, 214, 220),
                                 borderRadius: BorderRadius.only(
                                 bottomLeft: Radius.circular(60),
                                 bottomRight: Radius.circular(60),
                                 topLeft: Radius.circular(20), 
                                 topRight: Radius.circular(20), 
                                        ),
                                        boxShadow: [
                                      new BoxShadow(
                                     color: Color.fromARGB(255, 219, 194, 163),
                                     offset: new Offset(20.0, 20.0),
                                      blurRadius: 20,
                                      spreadRadius: 1.0,
                                        ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.only(
                                        left: 30,
                                        top: 30,
                                        bottom: 60,
                                      ),
                               ),
                          
                               Positioned(
                                 top: 55,
                                 left: screenwidth*0.1,
                                 child: Container(
                                  width: screenheight *0.2,
                                  height: screenheight*0.2,
                                  child: ClipOval(
                                     child: CachedNetworkImage(
                                       placeholder: (context, url) => Center(
                                         child: Shimmer.fromColors(
                                           baseColor: Colors.grey.withOpacity(0.5),
                                           highlightColor: Colors.grey,
                                           child: const CircleAvatar(
                                             radius: 60,
                                           ),
                                         ),
                                       ),
                                       imageUrl: (_controller.getprofilesmodel?.Profiles?.image?.isNotEmpty ?? false)
                                           ? UrlsApi.baseimageUrl + _controller.getprofilesmodel!.Profiles!.image!
                                           : "", 
                                       errorWidget: (context, url, error) => const CircleAvatar(
                                         radius: 60,
                                         backgroundImage: AssetImage('images/10.jpg'),
                                       ),
                                       imageBuilder: (context, imageProvider) => CircleAvatar(
                                         radius: 60,
                                         backgroundImage: imageProvider,
                                       ),
                                       fit: BoxFit.cover,
                                     ),
                                   ),
                                 ),
                                 /* child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: AssetImage('images/10.jpg'),
                                 // NetworkImage( _controller.articlesModel!.articles![index].artist!.image??""),
                                     ),*/
                                 ),
                                 SizedBox(
                                  height: screenheight *0.1,
                                 ),
                                  Positioned(
                                 top: 80,
                                 left: screenwidth*0.55,
                                  child: Container(
                                    height: screenheight*0.03,
                                    width: screenwidth *0.33,
                                    child: Center(child: Text( '${_controller.getprofilesmodel!.Profiles!.name??""}'
                                     , style: TextStyle(fontSize: screenwidth *0.05,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87
                                    ),
                                    ),),),
                                 ),
                                  Positioned(
                                 top: 110,
                                 left: screenwidth*0.55,
                                  child:  Container(
                                    height: screenheight*0.03,
                                    width: screenwidth *0.33,
                                    child: Center(child: Text('${_controller.getprofilesmodel!.Profiles!.specialization??""}' ,
                                     style: TextStyle(fontSize: screenwidth *0.04,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black45,
                                    ),
                                    ),),),
                                 ),
                                 Positioned(
                                 top: 238,
                                 left: screenwidth*0.3,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                       click_folow = !click_folow;
                                      });
                                  },
                                
                                    child: Text(
                                      click_folow == false ? 'Following' : 'Followed',
                                      
                                     style: TextStyle(
                                      fontSize:20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                             ),
                                        ),
                                  
                                style: ElevatedButton.styleFrom(
                                backgroundColor: click_folow ? Color.fromARGB(255, 134, 131, 126) : Color.fromARGB(255, 240, 192, 121),                             
                                padding: EdgeInsets.fromLTRB(30,9,30,9),
                                   ),
                                 ),
                                 ),
                                 Positioned(
                                 top: 320,
                                 left: screenwidth*0.30,
                                  child: RatingBar.builder(
                                                initialRating:
                                                    rating, // التقييم الابتدائي
                                                minRating: 1, // الحد الأدنى للتقييم
                                                direction:
                                                    Axis.horizontal, // اتجاه التقييم
                                                allowHalfRating:
                                                    true, // السماح بتقييم نصف نجمة
                                                itemCount: 5, // عدد النجوم
                                                itemSize: 20, // حجم النجوم
                                                itemPadding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        4.0), // المسافة بين النجوم
                                                itemBuilder: (context, _) => Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (newRating) {
                                                  setState(() {
                                                    rating =
                                                        newRating; 
                                                  });
                                                },
                                              ),
                                 ),
                                  Positioned(
                                     top: 318,
                                     left: screenwidth*0.75,
                                    child: Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 25,
                                                ),
                                  ),
                               /* Text('${_controller.paintingsModel!.painting!.ratesNumber}',
                                style: TextStyle(fontSize: 16),
                               ),
                               */
                                 Positioned(
                                 top: 360,
                                 left: screenwidth*0.08,
                                  child: ElevatedButton(
                                                        onPressed: () {
                                                       Get.to(PaintingList(artistId:id ),);
                    
                                                        },
                                                        child: Text('Paintings',
                                                          style: TextStyle(
                                                            fontSize:15,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: Color.fromARGB(255, 246, 201, 133),
                                                    
                                                          padding: EdgeInsets.fromLTRB(15,5,15,5),
                                                        ),
                                                      ),
                                 ),
                                 Positioned(
                                 top: 360,
                                 left: screenwidth*0.6,
                                  child: ElevatedButton(
                                                        onPressed: () {
                                                 Get.to(ArticlesList(artistId:id ,key: ValueKey("${UrlsApi.ArtistArticleApi}$id "),));
                    
                                                        },
                                                        child: Text('ِArticles',
                                                          style: TextStyle(
                                                            fontSize:15,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: Color.fromARGB(255, 246, 201, 133),
                                                    
                                                          padding: EdgeInsets.fromLTRB(15,5,15,5),
                                                        ),
                                                      ),
                                 ),
                                 Positioned(
                                  top: 430,
                                  left: 30,
                                  child:Text('About The Artist :', style: TextStyle(color: Colors.orangeAccent,
                                 fontStyle: FontStyle.italic,
                                 fontWeight: FontWeight.bold,
                                 fontSize: 18,
                                 ),) ),
                                  Positioned(
                                  top: 460,
                                  left: 30,
                                  child:Text('biography:',
                                   style: TextStyle(color: Color.fromARGB(255, 248, 195, 125),
                                 fontStyle: FontStyle.italic,
                                 fontWeight: FontWeight.w400,
                                 fontSize: 15,
                                 ),) ),
                                  Positioned(
                                    top: 480,
                                   left: 30,
                                    child:Container(
                                      width: screenwidth *0.8,
                                      height: screenheight *0.15,
                                      child: Text(
                                      '${_controller.getprofilesmodel!.Profiles!.biography??""}'
                                      , style: TextStyle(color: Colors.white,
                                         fontStyle: FontStyle.italic,
                                     fontWeight: FontWeight.bold,
                                       fontSize: 15,
                                        ),),
                                    ), ),
                                      Positioned(
                                  top: 570,
                                  left: 30,
                                  child:Text('expertise:', style: TextStyle(color: Color.fromARGB(255, 248, 195, 125),
                                 fontStyle: FontStyle.italic,
                                 fontWeight: FontWeight.w400,
                                 fontSize: 15,
                                 ),) ),
                    
                                  Positioned(
                                    top: 600,
                                   left: 30,
                                    child:Container(
                                      width: screenwidth *0.8,
                                      height: screenheight *0.1,
                                      child: Text(
                                      '${_controller.getprofilesmodel!.Profiles!.expertise??""}'
                                      , style: TextStyle(color: Colors.white,
                                         fontStyle: FontStyle.italic,
                                     fontWeight: FontWeight.bold,
                                       fontSize: 15,
                                        ),),
                                    ), ),
                    
                            
                        ],
                      ),
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