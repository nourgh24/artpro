// ignore_for_file: avoid_print

import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/config/server_config.dart';
import 'package:untitled5/models/artist_profile_model.dart';
import 'package:untitled5/models/user_profile_model.dart';
// import 'package:dio/dio.dart';


class ArtistProfileService {
  // Dio dio = Dio();

  //String artistToken ='eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2FydGlzdC9yZWdpc3RlciIsImlhdCI6MTcxOTE1NjQxMCwiZXhwIjoxNzUwMjYwNDEwLCJuYmYiOjE3MTkxNTY0MTAsImp0aSI6IjdLUjJjWXV5OXpMWHJvUHUiLCJzdWIiOiI2IiwicHJ2IjoiOTYzOTU3NDA3MzUxNWFiNjhjYTg3MzYzOTVmMDgwMjRjNjY0MmEwNyJ9.UHmcUgq_3tP0DV7v9PfgnOzMOSooZgYdu5qt62Vu27s';
  //String userToken ='eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL3VzZXIvbG9naW4iLCJpYXQiOjE3MTkzMTAyOTQsImV4cCI6MTc1MDQxNDI5NCwibmJmIjoxNzE5MzEwMjk0LCJqdGkiOiJ6bzRXZmxFazEycmxzdUVVIiwic3ViIjoiMSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.kccqnn7BERgpWYnMWPIgxwukrVGSWo-T8KWUwdZOfIk';
 

 /* Future<ArtistProfileModel> getArtistProfile() async {
    String urlArtistProfile;
  if (AppSharedPreferences.getRole == 0){
   urlArtistProfile = SreverConfig.domainNameServer + SreverConfig.artistProfileServer;
      }else{
      }
      
    var artistResponse = await http.get( urlArtistProfile,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AppSharedPreferences.getToken}',
      },
    );
      
    if (artistResponse.statusCode == 200) {
      var jsonData = artistResponse.body;
      // print(jsonData);
      return artistProfileModelFromJson(jsonData);
    } else {
      return throw Exception('fiald to load artist profile ');
    }
  }

  Future<UserProfileModel> getUserProfile() async {
     String urlUserProfile;
  if (AppSharedPreferences.getRole == 1){
       urlUserProfile = SreverConfig.domainNameServer + SreverConfig.userProfileServer;
      }else{
      }


    var response = await http.get(
      urlUserProfile,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer${AppSharedPreferences.getToken}',
      },
    );
    if (response.statusCode == 200) {
      var jsonData = response.body;
      print(jsonData);
      return userProfileModelFromJson(jsonData);
    } else {
      return throw Exception('fiald to load user profile ');
    }
  }*/


Future<ArtistProfileModel> getArtistProfile() async {
  String urlArtistProfile;
  if (AppSharedPreferences.getRole == 0) {
    urlArtistProfile = SreverConfig.domainNameServer + SreverConfig.artistProfileServer;
  } else {
    return throw Exception('Invalid role for artist profile');
  }
  var artistResponse = await http.get(
    Uri.parse(urlArtistProfile),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppSharedPreferences.getToken}',
    },
  );
  if (artistResponse.statusCode == 200) {
  var jsonData = artistResponse.body;
  if (jsonData != null) {
    return artistProfileModelFromJson(jsonData);
  } else {
    throw Exception('Received null data');
  }
} else {
  throw Exception('Failed to load artist profile');
}

}
Future<UserProfileModel> getUserProfile() async {
  String urlUserProfile;
  if (AppSharedPreferences.getRole == 1) {
    urlUserProfile = SreverConfig.domainNameServer + SreverConfig.userProfileServer;
  } else {
    return throw Exception('Invalid role for user profile');
  }

  var response = await http.get(
    Uri.parse(urlUserProfile),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppSharedPreferences.getToken}',
    },
  );

if (response.statusCode == 200) {
  var jsonData = response.body;
  if (jsonData != null) {
        print(jsonData);
    return userProfileModelFromJson(jsonData);
  } else {
    throw Exception('Received null data');
  }
} else {
  throw Exception('Failed to load user profile');
}
}

}
