import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/Painting%20list/add_new_painting.dart';
import 'package:untitled5/modules/gallery/gallery_display_view_controller.dart';
import 'painting_list_service.dart';
import 'painting_list_controller.dart';

class PaintingList extends StatefulWidget {
  final int artistId;
  const PaintingList({Key? key, required this.artistId}) : super(key: key);

  @override
  State<PaintingList> createState() => _PaintingListState();
}

class _PaintingListState extends State<PaintingList> {
  final PaintingListController imageController = Get.put(PaintingListController());
  final GalleryDisplayViewController galleryController = Get.find<GalleryDisplayViewController>();

  @override
  void initState() {
    super.initState();
    int currentArtistId = widget.artistId;
    print("AppSharedPreferences.getId: ${AppSharedPreferences.getId}");
    print("Current Artist ID: $currentArtistId");
    imageController.getPaintingList(artistId: currentArtistId);
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    bool isCurrentArtist =  AppSharedPreferences.getRole==0 ;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Painting List',
          style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        if (imageController.paintinglistState.value == PaintingListState.loading) {
          return Center(child: CircularProgressIndicator());
        }
        if (imageController.paintinglistState.value == PaintingListState.error) {
          return MaterialButton(
            onPressed: () {
              imageController.getPaintingList(artistId: widget.artistId);
            },
            child: Center(
              child: Container(
                color: Colors.orange[100],
                child: Text("Try again"),
              ),
            ),
          );
        }
        if (imageController.paintinglistmodel == null ||
            imageController.paintinglistmodel!.Paintings == null ||
            imageController.paintinglistmodel!.Paintings!.isEmpty) {
          return Center(child: Text('No articles available.'));
        }
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: imageController.paintinglistmodel!.Paintings!.length,
          itemBuilder: (context, index) {
            final painting = imageController.paintinglistmodel!.Paintings![index];
            return GestureDetector(
              onTap: () {
                if (imageController.isSelecting.value) {
                  imageController.selectImage(UrlsApi.baseimageUrl + painting.url!);
                } else {
                  Get.to(() => AddNewPainting(
                    index: index,
                    painting: Addpainting(
                      paintingTiltle: painting.title!,
                      paintingDescription: painting.description!,
                      paintingSize: painting.size!,
                      paintingPrice: "",
                      paintingType: "",
                      paintingImage: File(UrlsApi.baseimageUrl + painting.url!),
                    ),
                  ));
                }
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      UrlsApi.baseimageUrl + painting.url!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (imageController.isSelecting.value)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Obx(() {
                        final isSelected = imageController.selectedImages.any(
                            (selectedImage) => selectedImage.path == (UrlsApi.baseimageUrl + painting.url!));
                        return Icon(
                          isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: isSelected ? Colors.green : Colors.white,
                        );
                      }),
                    ),
                ],
              ),
            );
          },
        );
      }),


    
      floatingActionButton: isCurrentArtist
         ? FloatingActionButton(
            backgroundColor: Colors.orange[300],
            onPressed: () {
              if (imageController.isSelecting.value) {
                imageController.createGallery();
              } else {
                _showBottomSheet(context);
              }
            },
            child: Icon(imageController.isSelecting.value ? Icons.check : Icons.add),
          ):null
      
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 130,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Add Painting'),
                onTap: () {
                  Get.toNamed('/AddNewPainting');
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Create Gallery'),
                onTap: () {
                  Get.back();
                  imageController.toggleSelectionMode();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
