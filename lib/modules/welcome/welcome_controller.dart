import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

class WelcomeController extends GetxController {
  var selectedImagePath= ''.obs;

  @override
  void onInit(){
    super.onInit();
  }
  @override
  void onReady(){
    super.onReady();
  }
  @override
  void onClose(){
  }

  // void getImage(ImageSource imageSource) async{
  //   final pickedFile= await ImagePicker().pickImage(source: imageSource);
  //   if(pickedFile!=null)
  //     {
  //       selectedImagePath.value=pickedFile.path;
  //     }
  //   else{
  //     print("No image selected");
  //   }
  // }
}