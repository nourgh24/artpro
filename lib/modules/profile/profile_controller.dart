// import 'package:get/get.dart';
// import 'package:school_project/models/artist_profile_model.dart';
// import 'package:school_project/modules/profile/artist_profile_service.dart';
// import 'package:school_project/models/user_profile_model.dart';
// class ArtistController extends GetxController {
//   // var artistImage = '';
//   // var artistName = 'picaso picas';
//   // var artistUserName = 'picaso';
//   // var followersNumber = 10;
//   // var postNumber = 11;
//   // var followeingNumber = 100;
//   // var specialization = 'specialization';
//   // var expertise = 'expertise';
//   // var biography = 'biography';
//   // var rating = 2;
//   var isLoading = true.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     showArtistProfile();
//   }

//   changeFollowFromUser() {}
//   changeFollowFromArtist() {}
// }

import 'package:get/get.dart';
import 'package:untitled5/models/artist_profile_model.dart';
import 'package:untitled5/models/user_profile_model.dart';
import 'package:untitled5/modules/profile/profile_service.dart';


class ProfileController extends GetxController {
  var artistProfile =
      ArtistProfileModel(success: false, result: [], code: 0).obs;
  var userProfile = UserProfileModel(success: false, result: [], code: 0).obs;
  var isLoading = true.obs;

  ////need the logic
  var isArtist = true.obs;

  ArtistProfileService service = ArtistProfileService();

  void fetchArtistProfile() async {
    var getAprofile = await service.getArtistProfile();

    if (getAprofile.success) {
      artistProfile.value = getAprofile;
    } else {
      throw Exception('faild to load artist data ');
    }
    isLoading.value = false;
  }

  void fetchUserProfile() async {
    var getUprofile = await service.getUserProfile();

    if (getUprofile.success) {
      userProfile.value = getUprofile;
    } else {
      throw Exception('faild to load data ');
    }
    isLoading.value = false;
  }
}
