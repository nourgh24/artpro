// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:untitled5/config/server_config.dart';

class FollowController extends GetxController {
  var isFollowing = false.obs; // Observable to track follow status
  var isLoading = false.obs; // Observable to track loading state

  var urlchangeFollowFromUser =
      SreverConfig.domainNameServer + SreverConfig.changeFollowFromUser;

  var urlchangeFollowFromArtist =
      SreverConfig.domainNameServer + SreverConfig.changeFollowFromArtist;

  Future<void> toggleFollowArtist(String artistId, String token) async {
    isLoading.value = true;
    try {
      var url = Uri.parse('$urlchangeFollowFromArtist+$artistId');
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        // Update follow status
        isFollowing.value = !isFollowing.value;
      } else {
        // Handle API error
        Get.snackbar('Error', 'Failed to follow/unfollow the artist');

        print('Failed to follow artist: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception occurred: $e');
    } finally {
      isLoading.value = false;
    }
    // return '';
  }
}
