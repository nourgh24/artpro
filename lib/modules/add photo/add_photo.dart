import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
import 'add_photo_controller.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({super.key});

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}
class _AddPhotoState extends State<AddPhoto> {
Uint8List?_image;
File? selectedImage;
  final AddPhotoController controller = Get.put(AddPhotoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
                child:
                   Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 80,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 20,),
                          Text("Set a photo of yourself",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 30,),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 20,),
                          Text("photo make your profile engaging",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                    height: 220.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        _image !=null
                         ?CircleAvatar(
                            radius: 100.0,
                            backgroundImage:MemoryImage(_image!))
                          :const CircleAvatar(
                          radius: 200.0,
                          backgroundImage:
                          NetworkImage(
                              'https://www.pngarts.com/files/10/Default-Profile-Picture-Transparent-Image.png'
                          ),
                        ),
                        Positioned(
                          bottom: -0,
                          left: 240,
                          child:  IconButton(
                            onPressed: () {
                              showImagePickerOption(context);
                            },
                          icon: const  Icon(
                              Icons.add_a_photo,
                              size: 30.0,
                            color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                      Row(
                        children:[
                          SizedBox(width: 120,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[300],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(200),
                        ),
                        height: 40,
                        width: 250,
                        child: Center(
                          child: TextButton(
                            onPressed: (){},
                            child: Text("Add a Photo",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight:FontWeight.w300,
                              fontStyle: FontStyle.normal,
                            ),
                            ),
                          ),
                        ),
                      ),
                      ],
                      ),
                      SizedBox(
                        width: 10,
                        height: 40,
                      ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(),
                              TextButton(onPressed: (){
                                Get.toNamed('/Filter');
                              }, child: Text("Skip..",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 20,
                                  color: Colors.blueGrey[300],
                                ),
                              ),
                              ),
                              SizedBox(width: 20,),
                            ],
                          ),
                      SizedBox(width: 20,
                      height: 150,
                      ),

                    ],
            ),
                ),
          ),
    );
  }
}

void showImagePickerOption(BuildContext context){
  showModalBottomSheet(
    backgroundColor: Colors.white70,
      context: context, builder:(builder){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height/5,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: (){
                  var controller;
                  // controller.getImage(ImageSource.gallery);
                  Get.back();
                  //controller: _pickerImageFromeGallery();
                  },
                child: const
                SizedBox(
                  child: Column(
                    children: [
                      Icon(Icons.image_outlined,
                      size: 70,
                      ),
                      Text("Gallery")
                    ],
                  ),
                ),
              ),
            ),
           Expanded(
             child:InkWell(
              onTap: (){
                var controller;
                // controller.getImage(ImageSource.camera);
                Get.back();

                //AddPhotoController.to.pickerImageFromeCamera();
              },
              child: const
              SizedBox(
                child: Column(
                  children: [
                    Icon(Icons.camera_alt_outlined,
                    size: 70,
                    ),
                    Text("Camera")
                  ],
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  });
 /* Future _pickerImageFromeGallery() async{
    final returnImage= await ImagePicker().pickImage(source:ImageSource.gallery);
    if(returnImage==null)return;
    setState((){
      selectedIMage=File(returnImage.path);
      _image=File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

  Future _pickerImageFromeCamera() async{
    final returnImage= await ImagePicker().pickImage(source:ImageSource.camera);
    if(returnImage==null)return;
    setState((){
      selectedIMage=File(returnImage.path);
      _image=File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }*/
}