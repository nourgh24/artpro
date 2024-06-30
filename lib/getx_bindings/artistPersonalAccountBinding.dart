// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:untitled5/modules/artist_personal_account/artist_personal_account_controller.dart';

class ArtistPersonalAccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ArtistPersonalAccountController>(ArtistPersonalAccountController());
  }
}
