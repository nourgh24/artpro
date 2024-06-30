import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/Painting%20list/painting_list.dart';
import 'package:untitled5/modules/Painting%20list/painting_list_controller.dart';
import 'package:untitled5/modules/gallery/gallery_display_view_controller.dart';
import 'package:untitled5/modules/gallery/gallery_display_view_service.dart';



class AddGalleryDetails extends StatefulWidget {
  final Gallery_Details? gallerydetails;
  AddGalleryDetails({this.gallerydetails});

  @override
  State<AddGalleryDetails> createState() => _AddGalleryDetailsState();
}

class _AddGalleryDetailsState extends State<AddGalleryDetails> {
  final PaintingListController imageController = Get.find<PaintingListController>();
  final GalleryDisplayViewController galleryController = Get.find<GalleryDisplayViewController>();

  final galleryTitleController = TextEditingController();
  final galleryDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Gallery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    height: 150,
                    child: Obx(() {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imageController.selectedImages.length,
                        itemBuilder: (context, index) {
                          final image = imageController.selectedImages[index];
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                          child: Image.network(image.path),
                       // child:  Image.file(image),
                          );
                        },
                      );
                    }),
                  ),

                  SizedBox(height: 30),
                  Text(
                  "Add Gallery title ",
                  style: TextStyle(
                    fontSize: 15,
                    backgroundColor: Colors.orange[50],
                  ),
                ),
                    SizedBox(height: 18),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Title',
                    border: OutlineInputBorder(),

                    ),
                    controller: galleryTitleController,
                    onChanged: (value) {
                      imageController.title.value = value;
                    },
                  ),
                  SizedBox(height: 25),
                  Text(
                  "Add Gallery Description ",
                  style: TextStyle(
                    fontSize: 15,
                    backgroundColor: Colors.orange[50],
                  ),
                ),
                  SizedBox(height: 18),
                  TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(labelText: 'Description',
                     border: OutlineInputBorder(),
                    ),
                    controller: galleryDescriptionController,
                    onChanged: (value) {
                      imageController.description.value = value;
                    },
                  ),
                ],
              ),
            ),
            Obx((){
              if (galleryController.addgalleryeState.value == AddGalleryState.loading ){
         
                      return CircularProgressIndicator();
                  }
             /*   if (articleController.updatearticleState.value == updateArticleState.loading) {
                   return CircularProgressIndicator();
                       }*/

              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[200],
                        padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                      ),
                onPressed: () {
                  final galleryDetails = Gallery_Details(
                    title: galleryTitleController.text,
                    authorImageUrl: "",
                    time: "",
                    authorName:"",
                    desicription: galleryDescriptionController.text,
                    //images: imageController.selectedImages.map((image) => image).toList(),
                    images: imageController.selectedImages,
                  );
                  galleryController.addGallery(gallerydetails: galleryDetails);
                             
                            Get.snackbar(
                            'Success',
                         'Article added successfully',
              backgroundColor: Color.fromARGB(255, 194, 236, 196),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );

              Get.to(PaintingList(artistId:AppSharedPreferences.getId ),);
                           },
                             
              
               //onPressed: imageController.saveGallery,
                child: Text('Save Gallery'),
              );
            },
             
            ),
          ],
        ),
      ),
    );
  }
}