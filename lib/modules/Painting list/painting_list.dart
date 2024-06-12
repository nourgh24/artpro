import 'package:untitled5/modules/Painting%20list/add_new_painting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'painting_list_controller.dart';
class PaintingList extends StatelessWidget {
  final PaintingListController imageController = Get.put(PaintingListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Painting List',
          style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),),
        leading:
      IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Get.toNamed('/Welcome');
        },
      ),
      ),
      body: Obx(() {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: imageController.paintings.length,
          itemBuilder: (context, index) {
            final painting = imageController.paintings[index];
            final isSelected = imageController.selectedImages.contains(painting);
            return GestureDetector(
              onTap: () {
                if (imageController.isSelecting.value) {
                  imageController.selectImage(painting.paintingImage!);
                }else{
                  // Get.to(()=>AddNewPainting(index: index,painting: painting));
                }
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.file(
                      painting.paintingImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (imageController.isSelecting.value)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Icon(
                        imageController.selectedImages.contains(painting.paintingImage)
                        ?Icons.check_circle
                        :Icons.radio_button_unchecked,
                        color:
                            imageController.selectedImages.contains(painting.paintingImage)
                        ? Colors.green
                            :Colors.white,
                      ),
                    ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: Obx(() {
        return FloatingActionButton(
            backgroundColor:Colors.orange[300],
          onPressed: () {
            if (imageController.isSelecting.value) {
              imageController.createGallery();
            } else {
              _showBottomSheet(context);
            }
          },
          child: Icon(imageController.isSelecting.value ? Icons.check : Icons.add),
        );
      }),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
            height: 100,
            child: Column(
                children: [
            ListTile(
            leading: Icon(Icons.photo),
            title: Text('Add Painting'),
              onTap: () {
              Get.toNamed('/AddNewPainting');
         // Get.back();
         // imageController.pickImage();
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
