import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/certificate%20of%20reliability/certificate_controller.dart';
import 'package:untitled5/modules/certificate%20of%20reliability/certificate_model.dart';
import 'package:untitled5/modules/navpar/navpar.dart';

class ArtistView extends StatefulWidget {
  final int role;
  final String apiUrl;

  const ArtistView({required this.apiUrl, required this.role,
   super.key});

  @override
  State<ArtistView> createState() => _ArtistViewState();
}

class _ArtistViewState extends State<ArtistView> {
  final ArtistController controller = Get.put(ArtistController());

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Certificate of Reliability'),
          backgroundColor: Colors.orange[300],
          actions: [
            TextButton(onPressed: (){
               WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.offAll(Navpar(  
               //  role: 1,
                 apiUrl: UrlsApi.homeApi,
                              ));
               });
            }, child:Text('Skip', style: TextStyle(color: Colors.white),)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: screenwidth,
            height: screenheight ,
            child: Obx(() {
              if (controller.certificateState.value == CertificateState.loading) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                        'Enter First Image...',
                        style: TextStyle(color: Colors.grey),
                      ),
                  buildImagePickerField(1, 'image 1 (إجباري)', controller.imagePath1),
                  Text(
                        'Enter Personal Image...',
                        style: TextStyle(color: Colors.grey),
                      ),
                  buildImagePickerField(2, 'image 2 (إجباري)', controller.imagePath2),
                  Text(
                        'Enter Another Image...',
                        style: TextStyle(color: Colors.grey),
                      ),
                  buildImagePickerField(3, 'image 3 (اختياري)', controller.imagePath3),
                  SizedBox(height: screenheight * 0.05),
                  Center(
                    child: ElevatedButton(
                      onPressed: 
                      () async {
                         if (controller.imagePath1.value.isEmpty ||
                            controller.imagePath2.value.isEmpty) {
                          Get.snackbar('Error', 'Please provide all required images',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red[300]);
                          return;
                        }
                         final certificate = Certificate(
                          image: File(controller.imagePath1.value),
                          personalImage: File(controller.imagePath2.value),
                          anotherImage: File(controller.imagePath3.value),
                          sendDate: DateTime.now().toString(),
                          artistId: AppSharedPreferences.getRole, // This should be dynamic based on the artist's ID
                          updatedAt: DateTime.now().toString(),
                          createdAt: DateTime.now().toString(),
                          id: 1, // This should be dynamic based on the certificate ID
                        );
          
                        await controller.addCertificate(certificate: certificate);
                        if (controller.certificateState.value == CertificateState.succsesful) {
                          Get.snackbar('Success', 'Certificate added successfully', snackPosition: SnackPosition.BOTTOM,
                           backgroundColor: Color.fromARGB(255, 212, 243, 213));
                            Get.offAll(Navpar(  
                               //role: 0,
                               apiUrl: UrlsApi.homeApi,
                              ));
                        
                        } else if (controller.certificateState.value == CertificateState.error) {
                          Get.snackbar('Error', controller.message ?? 'Error occurred', snackPosition: SnackPosition.BOTTOM, backgroundColor: Color.fromARGB(255, 255, 158, 151));
                        }
                      },
                      child: Text('Send Certificate', style: TextStyle(color: Colors.black87),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[300],
                        padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                        elevation: 5,
                      ),
                    ),
                  ),
                   
                ],
              );
            }),
          ),
        ),
      ),
    );
  }




  Widget buildImagePickerField(int fieldNumber, String label, RxString imagePath) {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.pickImage(fieldNumber),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              imagePath.value.isEmpty
                  ? Text(label)
                  : Image.file(File(imagePath.value), height: 60, width: 70),
              Spacer(),
              Icon(Icons.add_a_photo),
            ],

          ),
        ),
      ),
    );
  }
}
