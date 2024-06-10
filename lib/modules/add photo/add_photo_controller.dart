

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:untitled5/modules/add%20photo/add_photo_controller.dart';

class AddPhotoController extends GetxController {
  var selectedImagepath=''.obs;
  var selectedImagesize=''.obs;

  // void getImage (ImageSource imageSource)async{
    /*final pickedFile=await ImagePicker().getImage(source:imageSource);
    if(pickedFile!=null){
      selectedImagepath.value=pickedFile.path;
      var selectedImagePath;
      //selectedImagesize.value=((File(selectedImagePath.value)).lengthSync()/1024/1024).toStringAsFixed(2)+"Mb";
    }
    else{
      Get.snackbar('Error','No image selected');
      snackPosition:SnackPosition.BOTTOM;
    backgroundColor:Colors.red;
    colorText:Colors.white;
    }*/
 // }
}