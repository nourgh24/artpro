import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled5/modules/painting%20details/painting%20_details.dart';
import 'package:untitled5/modules/painting_home_page/page_home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController _controller = Get.put(HomePageController());

  @override
  void initState() {
    // TODO: implement initState
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back_ios, size: 15),
                color: Colors.orangeAccent,
              ),
              Text(
                "Boards",
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.toNamed('/Filter');
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      //Get.toNamed('/Filter');
                    },
                    icon: Icon(
                      Icons.notifications_none,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    width: screenwidth * 0.60,
                  ),
                  IconButton(
                    onPressed: () {
                      //Get.toNamed('/Filter');
                    },
                    icon: Icon(
                      Icons.telegram,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Get.toNamed('/Filter');
                    },
                    icon: Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    width: screenwidth * 0.005,
                  ),
                ],
              ),
              SizedBox(
                height: screenheight * 0.0005,
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
                      child: Text("Try agein"),
                    );
                  }

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // عدد الأعمدة في الشبكة
                      mainAxisSpacing: 3, // التباعد الرأسي بين العناصر
                      crossAxisSpacing: 3, //// التباعد الأفقي بين العناصر
                      childAspectRatio: 0.8, // نسبة عرض العنصر إلى ارتفاعه
                    ),
                    itemCount: _controller.homePageModel!.paintings!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final artwork = _controller.artworks[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(PaintingDetails(
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
                                  height: screenheight * 0.1,
                                ),
                                fadeInDuration: const Duration(milliseconds: 4),
                                fadeOutDuration:
                                    const Duration(milliseconds: 4),
                                imageUrl: _controller
                                    .homePageModel!.paintings![index].url!,
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
      ),
    );
  }
}
