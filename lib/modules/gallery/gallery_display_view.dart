import 'dart:typed_data';
import 'package:untitled5/modules/gallery/page_view_holder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'gallery_display_view_controller.dart';
import 'gallery_display_view_service.dart';

class GalleryDisplayView extends StatefulWidget {
  const GalleryDisplayView({super.key});
  @override
  State<GalleryDisplayView> createState() => _GalleryDisplayViewState();
}

class _GalleryDisplayViewState extends State<GalleryDisplayView> {
  final GalleryDisplayViewController galleryController = Get.put(GalleryDisplayViewController());

  late PageViewHolder holder;
  late PageController _controller;
  double fraction = 0.20;

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
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;

    final args = Get.arguments;
    final String title = args['title'];
    final String description = args['description'];
    final List<Uint8List> images = args['images'];

    double value = Provider.of<PageViewHolder>(context).value;
    double diff = (images.length - value);

    final Matrix4 pvMatrix = Matrix4.identity()
      ..setEntry(3, 3, 1 / 1.6)
      ..setEntry(3, 1, -0.004)
      ..setEntry(3, 0, 0.002 * -diff)
      ..rotateX(1.309);

    final Matrix4 shadowMatrix = Matrix4.identity()
      ..setEntry(3, 3, 1 / 0.9)
      ..setEntry(1, 1, fraction)
      ..setEntry(3, 0, 0.004 * -diff);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: screenwidth,
            height: screenheight*1.5,
            decoration: BoxDecoration(image:DecorationImage(
                opacity:0.2,
                fit: BoxFit.cover,
                image:AssetImage("images/5.jpg")
            ),
            ),
            child: Stack(
              children: [
              Column(
                children: [
                  Text("Art Gallery",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black87)),
                  SizedBox(
                    height:screenheight*0.02,
                  ),
                  Container(
                    height: screenheight*0.3,
                    child: Obx(
                          () => ListView.builder(
                            scrollDirection: Axis.values.first,
                            itemCount: galleryController.gallery_details.length,
                            itemBuilder: (context, index) {
                              final Gallery_Details gallery_detaile = galleryController.gallery_details[index];

                          return GestureDetector(
                            onTap: () {
                            },
                            child:
                            Container(
                              width: screenwidth*0.9,
                              child:Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                      SizedBox(width: screenwidth*0.01,),
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundImage: AssetImage(
                                            gallery_detaile.authorImageUrl),
                                      ),

                                      Column(
                                        children: [
                                          TextButton(
                                            onPressed: () {}, child: Text(
                                            gallery_detaile.authorName,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                          ),
                                          SizedBox(height: 0.01,),
                                          Text(
                                            gallery_detaile.time,
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
                                  SizedBox(height: screenheight*0.03,),
                                  SingleChildScrollView(
                                    child: Center(
                                      child: Container(
                                        color:Colors.white70,
                                        height: screenheight*0.15,
                                        width: screenwidth *0.8,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:Text('${title}',
                                                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic,color: Colors.black45)),
                                            ),
                                              Padding(
                                              padding: const EdgeInsets.all(8.0),
                                                child:Text('${description}',
                                                  style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic,color: Colors.black26),
                                                ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      alignment: Alignment.center,
                      children: <Widget>[
                        if (diff <= 1.0 && diff >= -1.0)
                          AnimatedOpacity(
                            duration: Duration(milliseconds: 100),
                            opacity: 1 - diff,
                            child: Transform(
                              transform: shadowMatrix,
                              alignment: FractionalOffset.bottomCenter,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        description,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        Transform(
                          transform: pvMatrix,
                          alignment: FractionalOffset.center,
                          child: PageView.builder(
                            controller: _controller,
                            itemCount: images.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.memory(
                                      images[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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