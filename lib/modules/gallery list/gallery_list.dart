import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
        height: screenheight,
        width: screenwidth,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        SizedBox(height: screenheight*0.01,),

    Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
    SizedBox(width: screenwidth*0.05,),
    Text("Galleries of art",
    style: TextStyle(fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontSize: 20,
    color: Colors.blueGrey,
    ),
    ),

    ],
    ),
    SizedBox(height: screenwidth*0.08,),
    Column(
    children: [
    Center(
    child: Container(
    height: screenheight*0.67,
    width: screenwidth*0.95,
    child: Obx(
    () => ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: _controller.galleries.length,
    itemBuilder: (context, index) {
    final gallery_list gallery = _controller.galleries[index];
    return GestureDetector(
    onTap: () {
        },
    child: Container(
    width: screenwidth*0.58,
    height: screenheight*0.66,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    shadowColor: Colors.orange[700],
    elevation: 10,
    margin: EdgeInsets.all(10),
    child: Stack(
    children: [
    // صورة المقال
   Image.asset(
      //color: ColorFilters.greyscale,
      gallery.imageUrl,
    width: screenwidth*0.58, // عرض الصورة
    height:screenheight*0.66, // ارتفاع الصورة
    fit: BoxFit.cover,
    ),
     // Panorama(
     //
     //  interactive: true,
     //  minLatitude: -90,
     //  sensitivity: 1.0,
     //  animReverse: true,
     //  zoom: 1,
     //  animSpeed: 1.0,
     //  child:Image.asset('images/5.jpg'),
     //  ),

    Positioned.fill(
    child: Material(
    color: Colors.black12,
    child: InkWell(
    onTap: () {
    Get.toNamed('/GalleryDisplayView');
    },
    borderRadius: BorderRadius.circular(50),
    ),
    ),
    ),
    // صورة البروفايل
    Positioned(
    bottom: 10,
    left: 10,
    child: CircleAvatar(
    radius: 20,
    backgroundImage: AssetImage(gallery.authorImageUrl),
    ),
    ),
    // اسم الكاتب
    Positioned(
    bottom: 15,
    left: 50,
    child: TextButton(onPressed: (){},child: Text(
      gallery.authorName,
    style: TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.normal,
    ),
    ),
    ),
    ),

    Positioned(
    bottom: 30,
    left: 50,
    child: TextButton(onPressed: (){},child: Text(
      gallery.time,
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
    top: 10,
    left: 10,
    child: Text(
      gallery.title,
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
          ],
        ),
        ),

    );
  }
}
