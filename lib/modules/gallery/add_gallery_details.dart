import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Painting list/painting_list_controller.dart';

class AddGalleryDetails extends StatelessWidget {
  final PaintingListController imageController = Get.find<PaintingListController>();

  @override
  Widget build(BuildContext context) {
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
                    height: 100,
                    child: Obx(() {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imageController.selectedImages.length,
                        itemBuilder: (context, index) {
                          final image = imageController.selectedImages[index];
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.file(image),
                          );
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    onChanged: (value) {
                      imageController.title.value = value;
                    },
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(labelText: 'Description'),
                    onChanged: (value) {
                      imageController.description.value = value;
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: imageController.saveGallery,
              child: Text('Save Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}