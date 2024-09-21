import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled5/Services/Network/urls_api.dart';

import 'gallery_display_view_controller.dart';
import 'page_view_holder.dart';

class GalleryDisplayView extends StatefulWidget {
  const GalleryDisplayView({super.key});

  @override
  State<GalleryDisplayView> createState() => _GalleryDisplayViewState();
}

class _GalleryDisplayViewState extends State<GalleryDisplayView> {
  final GalleryDisplayViewController galleryController = Get.put(GalleryDisplayViewController());

  late PageViewHolder holder;
  late PageController _controller;
  double fraction = 0.5;
  //late final double number;

  @override
  void initState() {
    super.initState();
    holder = PageViewHolder(value: 2.0);
    _controller = PageController(initialPage: 2, viewportFraction: fraction);
    _controller.addListener(() {
      holder.setValue(_controller.page);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    final args = Get.arguments ?? {};
    final String title = args['title'] ?? 'No Title';
    final String description = args['description'] ?? 'No Description';
    final List<File> images = args['images'] ?? [];

    double value = Provider.of<PageViewHolder>(context).value;
    double diff = (images.length - value);
    //double diff = (number - value);


    //Matrix for Elements
    final Matrix4 pvMatrix = Matrix4.identity()
      ..setEntry(3, 3, 1.3 / 1.1) // Increasing Scale by 90%
      ..setEntry(1, 1, fraction) // Changing Scale Along Y Axis
      ..setEntry(3, 0, 0.002 * -diff); // Changing Perspective Along X Axis

    //Matrix for Shadow
    final Matrix4 shadowMatrix = Matrix4.identity()
      ..setEntry(3, 3, 1 / 1.6) // Increasing Scale by 60%
      ..setEntry(3, 1, -0.004) //Changing Perspective along Y-Axis
      ..setEntry(3, 0, 0.002 * diff) // Changing Perspective along X Axis
      ..rotateX(1.309); //Rotating Shadow along X Axis


    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: screenwidth,
            height: screenheight ,
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: 0.2,
                fit: BoxFit.cover,
                image: AssetImage("images/5.jpg"),
              ),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Text(
                      "Art Gallery",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      height: screenheight * 0.02,
                    ),
                    Expanded(
                      child: Obx(() {
                       if (galleryController.getgalleryedetailsState.value == getGalleryDetailsState.loading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (galleryController.getgalleryedetailsState.value == getGalleryDetailsState.error) {
                          return SizedBox();
                        }
                        return Container(
                          width: screenwidth,
                        
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: screenwidth * 0.01),

                              /*    CachedNetworkImage(
                                    placeholder: (context, url) => Shimmer.fromColors(
                                    baseColor: Colors.grey.withOpacity(0.5),
                                    highlightColor: Colors.grey,
                                    child: Container(
                                    width: double.maxFinite,
                                    height: screenheight * 0.5,
                                    color: Colors.grey,
                                         ),
                                        ),
                                    imageBuilder: (context, imageProvider) => Container(
                                    width: double.maxFinite, 
                                    height: screenheight * 0.5,
                                    decoration: BoxDecoration(
                                    image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                      ),
                                       ),
                                       ),
                                    fadeInDuration: const Duration(milliseconds: 4),
                                    fadeOutDuration: const Duration(milliseconds: 4),
                                    imageUrl: galleryController.gallerydisplaymodel!.gallerys![0].paintings![0].artist?.image != null
                                   ? UrlsApi.baseimageUrl + galleryController.gallerydisplaymodel!.gallerys![0].paintings![0].artist!.image!
                                   : 'https://via.placeholder.com/150', 
                                   errorWidget: (context, url, error) => Container(
                                   width: double.maxFinite,
                                     height: screenheight * 0.5,
                                     decoration: BoxDecoration(
                                    image: DecorationImage(
                                   image: AssetImage('assets/images/default_image.png'),
                                     fit: BoxFit.cover,
                                    ),
                                 ),
                             ),
                            fit: BoxFit.cover,
                           ),*/
                           ////////////////
                           CircleAvatar(
                                 radius: 25,
                                 backgroundImage: AssetImage('images/7.jpg'),
                                          ),
                                          

                                   Column(
                                    children: [

                                   /*   TextButton(
  onPressed: () {},
  child: Text(
    // التحقق من وجود البيانات قبل الوصول إليها
    galleryController.gallerydisplaymodel != null &&
    galleryController.gallerydisplaymodel!.gallerys != null &&
    galleryController.gallerydisplaymodel!.gallerys!.isNotEmpty &&
    galleryController.gallerydisplaymodel!.gallerys![0].paintings != null &&
    galleryController.gallerydisplaymodel!.gallerys![0].paintings!.isNotEmpty &&
    galleryController.gallerydisplaymodel!.gallerys![0].paintings![0].artist != null
        ? galleryController.gallerydisplaymodel!.gallerys![0].paintings![0].artist!.name ?? 'Unknown Artist'
        : 'Unknown Artist',
        

    style: TextStyle(
      color: Colors.black,
      fontSize: 13,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
    ),
  ),
),*/

                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          "Reman",
                                      //    galleryController.gallerydisplaymodel!.gallerys![0].paintings![0].artist?.name ?? 'Unknown Artist',

                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 0.01),
                                      Text(
                                        "1 Day ago",
                                       // galleryController.gallerydisplaymodel!.gallerys![0].creationDate ?? 'Unknown date',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 8,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                              
                                ],
                              ),
                              SizedBox(height: screenheight * 0.03),
                              SingleChildScrollView(
                                child: Center(
                                  child: Container(
                                    color: Colors.white70,
                                    height: screenheight * 0.1,
                                    width: screenwidth * 0.8,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                         child: 
                                          Text(
                                           "النحت المعاصر",
                                           // galleryController.gallerydisplaymodel!.gallerys![0].name ?? 'Unknown Title',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.black45,
                                            ),
                                          ),
                                        ),
                                        
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Text(
                                            " النحت حالة حسية تقول سرها في بؤر الوجود",
                                         //   galleryController.gallerydisplaymodel!.gallerys![0].details ?? 'Unknown Title',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.black26,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                             
                       Container(
          child: Center(
            child: AspectRatio(
              aspectRatio: 0.7,
              child: ChangeNotifierProvider<PageViewHolder>.value(
                value: holder,
                child: PageView.builder(
                    controller: _controller,
                    itemCount: 5,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                     // return MyPageApp(number: index.toDouble(), fraction: fraction);

                   return   Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: <Widget>[
        if(diff<=1.0 && diff >= -1.0) ... [
          AnimatedOpacity(
            duration: Duration(milliseconds: 100),
            opacity: 1-diff.abs(),
            child: Transform(
              transform: shadowMatrix,
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10.0, spreadRadius: 1.0)
                ]),
              ),
            ),
          ),
        ],
        Transform(
          transform: pvMatrix,
          alignment: FractionalOffset.center,
          child: Container(
            child:
            
        GestureDetector(
          onTap: () {
      // عرض الصورة بملء الشاشة عند النقر عليها
      Get.dialog(
        Dialog(
          backgroundColor: Colors.transparent, // لضمان أن الخلفية شفافة
          insetPadding: EdgeInsets.zero, // لإزالة الحواف حول الصورة
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: InteractiveViewer(
              boundaryMargin: EdgeInsets.all(0), // لضبط الحواف للتكبير والتحريك
              minScale: 1.0, // أقل نسبة تكبير
              maxScale: 7.0, // أقصى نسبة تكبير
              child: CachedNetworkImage(
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.5),
                  highlightColor: Colors.grey,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey,
                  ),
                ),
                imageBuilder: (context, imageProvider) => Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover, // لجعل الصورة تملأ الشاشة بالكامل
                    ),
                  ),
                ),
                fadeInDuration: const Duration(milliseconds: 4),
                fadeOutDuration: const Duration(milliseconds: 4),
                imageUrl:  "images/13.jpg",// UrlsApi.baseimageUrl + galleryController.gallerydisplaymodel!.gallerys![0].paintings![0].artist?.image!,
                errorWidget: (context, url, error) => Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage( "images/13.jpg"),
                      //image: AssetImage('${galleryController.imageUrl}'),
                      fit: BoxFit.cover, // لضمان عرض الصورة الاحتياطية بشكل كامل
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
    child: CachedNetworkImage(
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.5),
        highlightColor: Colors.grey,
        child: Container(
          width: double.maxFinite,
          height: screenheight * 0.5,
          color: Colors.grey,
        ),
      ),
      imageBuilder: (context, imageProvider) => Container(
        width: double.maxFinite,
        height: screenheight * 0.5,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover, // لضمان تغطية الصورة للصندوق
          ),
        ),
      ),
      fadeInDuration: const Duration(milliseconds: 4),
      fadeOutDuration: const Duration(milliseconds: 4),
      imageUrl:  "images/13.jpg",// UrlsApi.baseimageUrl + galleryController.gallerydisplaymodel!.gallerys![0] .paintings![0].artist?.image!,
      errorWidget: (context, url, error) => Container(
        width: double.maxFinite,
        height: screenheight * 0.5,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:  AssetImage( "images/13.jpg"),//AssetImage('${galleryController.imageUrl}'),
            fit: BoxFit.cover, // لضمان عرض الصورة الاحتياطية بشكل كامل
          ),
        ),
      ),
    ),
  ),
            
            /* CachedNetworkImage(
                                                placeholder: (context, url) => Shimmer.fromColors(
                                                  baseColor: Colors.grey.withOpacity(0.5),
                                                  highlightColor: Colors.grey,
                                                  child: Container(
                                                    width: double.maxFinite,
                                                    height: screenheight * 0.5,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                imageBuilder: (context, imageProvider) => Container(
                                                  width: double.maxFinite,
                                                  height: screenheight * 0.5,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                fadeInDuration: const Duration(milliseconds: 4),
                                                fadeOutDuration: const Duration(milliseconds: 4),
                                                imageUrl:
                                                UrlsApi.baseimageUrl + galleryController.gallerydisplaymodel!.gallerys![0]
                                                    .paintings![0].artist?.image!,
                                                errorWidget: (context, url, error) => Container(
                                                  width: double.maxFinite,
                                                  height: screenheight * 0.5,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage('${galleryController.imageUrl}'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                fit: BoxFit.cover,
                                             
                                              ),
                                              */
          ),
        )
      ],
    );
                    }),
              ),
            ),
          ),
        ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
///////////////////////////////////////////////////////////
///////////////////////////

