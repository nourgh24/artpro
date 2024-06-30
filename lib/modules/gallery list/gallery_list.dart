import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/modules/gallery/gallery_display_view.dart';
// import 'package:panorama/panorama.dart';

import 'gallery_list_controller.dart';
import 'gallery_list_services.dart';

class GalleryList extends StatefulWidget {
  const GalleryList({super.key});

  @override
  State<GalleryList> createState() => _GalleryListState();
}

class _GalleryListState extends State<GalleryList> {
  final GalleryListController _controller = Get.put(GalleryListController());
  
  @override
    void initState(){
    super.initState();
   _controller.getAllGalleryes();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
        body: Column(
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
                child:  Text("Galleries of art",
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

               SizedBox(height: screenheight*0.02,),
               Expanded(
                child:MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                   child: Obx((){
                   if (_controller.galleryliststate.value ==GalleryListState.loading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (_controller.galleryliststate.value == GalleryListState.error) {
                        return MaterialButton(
                          onPressed: () {
                            _controller.getAllGalleryes();
                          },
                          child: Center(child: Container(
                            color: Colors.orange[100],
                            child: Text("Try agein to view the galleries"))),
                        );
                      }
                  return  ListView.builder(
                     scrollDirection: Axis.vertical,
               itemCount: _controller.gallerylistmodel!.Gallerys!.length,
               itemBuilder: (context, index) {
               final gallery_list gallery = _controller.galleries[index];
               return GestureDetector(
               onTap: () {
                Get.toNamed('/GalleryDisplayView');
                  Get.to(() => GalleryDisplayView(
                             ));
              },
              child: Container(
                child: Column(
                    children: [
                      Container(
                         decoration: BoxDecoration(
                          color:Color.fromARGB(255, 185, 197, 205),
                         borderRadius: BorderRadius.only(
                         bottomLeft: Radius.circular(100),
                                ),
                                boxShadow: [
                              new BoxShadow(
                             color: Color.fromARGB(255, 219, 194, 163),
                             offset: new Offset(-10.0, 0.0),
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
                  
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                   Row(
                     children: [
                    CircleAvatar(
                          radius: 20,
                          backgroundImage: _controller.gallerylistmodel!.Gallerys![index].artist?.image != null
                         ? NetworkImage(UrlsApi.baseimageUrl + _controller.gallerylistmodel!.Gallerys![index].artist!.image)
                          : AssetImage('assets/images/default_image.png') as ImageProvider,
                          ),


                         TextButton(onPressed: (){},child: Text(
                            _controller.gallerylistmodel!.Gallerys![index].artist!.name!,
                            style: TextStyle(
                           color: Colors.black54,
                           fontSize: 15,
                           fontWeight: FontWeight.bold,
                                 ),
                                 ),
                                 ),
                                 
                                Text(
                                   _controller.gallerylistmodel!.Gallerys![index].creationDate!,
                                 style: TextStyle(
                                 color: Colors.black54,
                                 fontSize: 8,
                                 fontWeight: FontWeight.bold,
                                 ),  
                                 ),
                   
                     ],
                   ),
                  
                     SizedBox(height: screenheight*0.03,),
                    Text(
                       _controller.gallerylistmodel!.Gallerys![index].name!,  
                              style: TextStyle(
                                 color: Colors.blueGrey,
                                 fontWeight: FontWeight.bold,
                                 fontSize: 22,
                                 ),
                                 ),
                  
                  SizedBox(height: screenheight*0.01,),
                  Center(
                    child: Text(
                       _controller.gallerylistmodel!.Gallerys![index].details!,
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontWeight: FontWeight.bold,
                                   ),
                                   ),
                  ),
                                ],
                              ),
                      ),
                      SizedBox(height: screenheight*0.015),
                  ],
                  
                  ),
                  ),
                  );
                },
                );
                },
),      


                   
                   ),
               
),
],
),
);
}
}

