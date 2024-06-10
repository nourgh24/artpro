import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'certificate_controller.dart';

class ArtistView extends StatelessWidget {
  final ArtistController controller = Get.put(ArtistController());

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Certificate of Rrliability'),
        backgroundColor: Colors.orange[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: screenwidth,
          height: screenheight*1.1,
          child: Column(
            children: [
              buildImagePickerField(1, 'image 1 (إجباري)', controller.imagePath1),
              buildImagePickerField(2, 'image 2 (إجباري)', controller.imagePath2),
              buildImagePickerField(3, 'image 3 (اختياري)', controller.imagePath3),
              SizedBox(height:screenheight *0.1),
              ElevatedButton(
                onPressed: () {
                  if (controller.imagePath1.value.isNotEmpty && controller.imagePath2.value.isNotEmpty) {
                  } else {
                    Get.snackbar('خطأ', 'الرجاء إدخال الصور الإلزامية',
                        snackPosition:SnackPosition.BOTTOM,
                      colorText: Colors.red,
                    );
                  }
                },
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[300],
                  padding: EdgeInsets.fromLTRB(40,15,40,15),
                  elevation: 5,
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImagePickerField(int fieldNumber, String label, RxString imagePath) {
    return Obx(
          () => GestureDetector(
        // onTap: () => controller.pickImage(fieldNumber),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              imagePath.value.isEmpty
                  ? Text(label)
                  : Image.file(File(imagePath.value), height: 50, width: 50),
              Spacer(),
              Icon(Icons.add_a_photo),
            ],
          ),
        ),
      ),
    );
  }
}