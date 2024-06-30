import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/modules/painting%20details/painting%20_details.dart';
import 'package:untitled5/modules/painting%20details/painting_details_service.dart';
import 'package:untitled5/modules/painting_home_page/page_home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:untitled5/modules/profile/profile_view.dart';

class HomePage extends StatefulWidget {
   
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final HomePageController _controller = Get.put(HomePageController());
  @override
  void initState() {
    super.initState();
    _controller.getAllPainting();
    _controller.loadArtworks();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body:
           Column(
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
                child:  Text("Painting of art",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontSize: 20,
                color: Colors.orange[200],
                ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.toNamed('/Filter');
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.black54,
                        size: 20,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        //Get.toNamed('/Filter');
                      },
                      icon: Icon(
                        Icons.notifications_none,
                        color: Colors.black54,
                        size: 20,
                      ),
                    ),
                    SizedBox(
                      width: screenwidth * 0.40,
                    ),
                    IconButton(
                      onPressed: () {
                        //Get.toNamed('/Filter');
                      },
                      icon: Icon(
                        Icons.telegram,
                        color: Colors.black54,
                        size: 20,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Get.to(ProfileView());
                      },
                      icon: Icon(
                        Icons.person,
                        color: Colors.black54,
                        size: 20,
                      ),
                    ),
                    
                    SizedBox(
                      width: screenwidth * 0.005,
                    ),
                  ],
                ),
              ),
            
            ],
            ),
            ),
              SizedBox(
                height: screenheight * 0.01,
              ),
              Expanded(
                child: Obx(() {
                  if (_controller.paintingState.value ==
                      PaintingState.loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (_controller.paintingState.value == PaintingState.error) {
                    return MaterialButton(
                      onPressed: () {
                        _controller.getAllPainting();
                      },
                      child: Center(child: Container(
                        color: Colors.orange[100],
                        child: Text("Try agein"))),
                    );
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, 
                      mainAxisSpacing: 2, 
                      crossAxisSpacing: 2, 
                      childAspectRatio: 0.8, 
                    ),
                    itemCount: _controller.homePageModel!.paintings!.length,
                    shrinkWrap: true, 
                    itemBuilder: (context, index) {
                      final artwork = _controller.artworks[index];
                       // String baseimageUrl = 'http://192.168.193.85:8080/';

                      return GestureDetector(
                        onTap: () {
                          Get.to(()=> PaintingDetails(
                            paintingcomplaint:AddPaintingComplaint(Description:""),
                              paintingId: _controller
                                  .homePageModel!.paintings![index].id!));
                        },
                        child: Card(
                          surfaceTintColor: Colors.blue,
                          elevation: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              /*SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    scrollDirection: ,
                                    itemCount: 5, // عدد الصور العشوائية داخل البطاقة
                                    itemBuilder: (context, i) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          artwork.imageUrl,
                                          width: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                ),*/
                              // عرض الصورة
                              CachedNetworkImage(
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.5),
                                  highlightColor: Colors.grey,
                                  child: Container(
                                    height: screenheight * 0.1,
                                    width: screenwidth * 0.1,
                                  ),
                                ),
                                imageBuilder: (context, imageProvider) => Image(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  height: screenheight * 0.22,
                                ),
                                fadeInDuration: const Duration(milliseconds: 4),
                                fadeOutDuration:
                                    const Duration(milliseconds: 4),

                                imageUrl: UrlsApi.baseimageUrl+_controller.homePageModel!.paintings![index].url!,
                                
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  _controller.artworks[0].imageUrl,
                                  fit: BoxFit.cover,
                                  height: screenheight * 0.1,
                                ),
                                fit: BoxFit.cover,
                              ),

                              // اسم اللوحة
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _controller
                                      .homePageModel!.paintings![index].title!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      
    );
  }
}
