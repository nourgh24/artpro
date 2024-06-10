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
  }
  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){},
                    icon: Icon(Icons.arrow_back_ios,size: 15),
                    color: Colors.orangeAccent,
                  ),
                  Text("Boards",
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
                      IconButton(onPressed: (){
                        Get.toNamed('/Filter');
                      },
                          icon: Icon(Icons.search,
                          color: Colors.grey,
                            size: 20,
                          ),
                      ),
                      IconButton(onPressed: (){
                        //Get.toNamed('/Filter');
                      },
                        icon: Icon(Icons.notifications_none,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),

                      SizedBox(
                        width: screenwidth*0.60,
                      ),
                      IconButton(onPressed: (){
                        //Get.toNamed('/Filter');
                      },
                        icon: Icon(Icons.telegram,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                      IconButton(onPressed: (){
                       // Get.toNamed('/Filter');
                      },
                        icon: Icon(Icons.person,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                      SizedBox(
                        width: screenwidth*0.005,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenheight*0.0005,
                  ),
                  Container(
                    width: screenwidth,
                    height: screenheight*0.63,
                    color: Colors.white,
                    child:SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                          child:Column(
                      children:[
                          // Obx(

                          //       () {

                          //         if(_controller.paintingState.value==PaintingState.loading){
                          //           return CircularProgressIndicator();
                          //         }
                          //         if(_controller.paintingState.value==PaintingState.error){
                          //           return SizedBox();
                          //         }


                          //         return GridView.builder(
                          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //       crossAxisCount: 3, // عدد الأعمدة في الشبكة
                          //       mainAxisSpacing: 3, // التباعد الرأسي بين العناصر
                          //       crossAxisSpacing: 3, //// التباعد الأفقي بين العناصر
                          //       childAspectRatio: 1.0, // نسبة عرض العنصر إلى ارتفاعه
                          //     ),
                          //     itemCount: _controller.artworks.length,
                          //     shrinkWrap: true,
                          //     itemBuilder: (context, index) {
                          //       final artwork = _controller.artworks[index];
                          //       return GestureDetector(
                          //         onTap: () {
                          //           Get.toNamed('/PaintingDetails');
                          //         },
                          //         child: Card(
                          //           surfaceTintColor: Colors.blue,
                          //           elevation: 3,
                          //           child: Column(
                          //             crossAxisAlignment: CrossAxisAlignment.stretch,
                          //             children: [
                          //               /*SizedBox(
                          //                 height: 200,
                          //                 child: ListView.builder(
                          //                   scrollDirection: ,
                          //                   itemCount: 5, // عدد الصور العشوائية داخل البطاقة
                          //                   itemBuilder: (context, i) {
                          //                     return Padding(
                          //                       padding: const EdgeInsets.all(8.0),
                          //                       child: Image.asset(
                          //                         artwork.imageUrl,
                          //                         width: 150,
                          //                         fit: BoxFit.cover,
                          //                       ),
                          //                     );
                          //                   },
                          //                 ),
                          //               ),*/
                          //               // عرض الصورة

                          //              Image.asset(
                          //                 artwork.imageUrl,
                          //                 fit: BoxFit.cover,
                          //                 height: screenheight*0.2,
                          //               ),
                          //               // اسم اللوحة
                          //               Padding(
                          //                 padding: const EdgeInsets.all(8.0),
                          //                 child: Text(
                          //                   artwork.name,
                          //                   style: TextStyle(
                          //                     fontSize: 12,
                          //                     fontWeight: FontWeight.bold,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //   );}
                          // ),
                        ],
                      ),
                    ),
    ],
                      ),
                  ),
                  ),
          ],
              ),
            ),
          ),
        ),
    );
  }
}
