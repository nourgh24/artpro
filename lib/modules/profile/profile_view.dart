// ignore_for_file: library_prefixes
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:school_project/models/artist_profile_model.dart' as ArtistModel;
//import 'package:school_project/models/user_profile_model.dart' as UserModel;
import 'package:untitled5/compomnt/custom_circle.dart';
import 'package:untitled5/config/server_config.dart';
import 'package:untitled5/models/artist_profile_model.dart'as ArtistModel;
import 'package:untitled5/models/user_profile_model.dart' as UserModel;
import 'package:untitled5/modules/follow/follow_controller.dart';
import 'profile_controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  //final ProfileController controller = Get.find();
  final FollowController followController = Get.put(FollowController());
    final ProfileController controller = Get.put(ProfileController());


  @override
  Widget build(BuildContext context) {
    // Replace with your logic to determine if it's an artist or user

    if (controller.isArtist.value) {
      controller.fetchArtistProfile();
    } else {
      controller.fetchUserProfile();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.isArtist.value &&
            controller.artistProfile.value.success) {
          ArtistModel.ResultClass profile = ArtistModel.ResultClass.fromJson(
              controller.artistProfile.value.result[0]);
          return ArtistProfileDetails(profile: profile);
        } else if (!controller.isArtist.value &&
            controller.userProfile.value.success) {
          UserModel.ResultClass profile = UserModel.ResultClass.fromJson(
              controller.userProfile.value.result[0]);
          return UserProfileDetails(profile: profile);
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Failed to load profile'),
                if (!controller.isArtist.value &&
                    !controller.userProfile.value.success)
                  const Text('User profile fetch failed.'),
                if (controller.isArtist.value &&
                    !controller.artistProfile.value.success)
                  const Text('Artist profile fetch failed.'),
              ],
            ),
          );
        }
      }),
    );
  }
}

class ArtistProfileDetails extends StatelessWidget {
  final ArtistModel.ResultClass profile;
  final FollowController followController =
      Get.find(); // Get the instance of FollowController
  final String artistToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2FydGlzdC9yZWdpc3RlciIsImlhdCI6MTcxOTE1NjQxMCwiZXhwIjoxNzUwMjYwNDEwLCJuYmYiOjE3MTkxNTY0MTAsImp0aSI6IjdLUjJjWXV5OXpMWHJvUHUiLCJzdWIiOiI2IiwicHJ2IjoiOTYzOTU3NDA3MzUxNWFiNjhjYTg3MzYzOTVmMDgwMjRjNjY0MmEwNyJ9.UHmcUgq_3tP0DV7v9PfgnOzMOSooZgYdu5qt62Vu27s';
  final String userToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL3VzZXIvbG9naW4iLCJpYXQiOjE3MTkzMTAyOTQsImV4cCI6MTc1MDQxNDI5NCwibmJmIjoxNzE5MzEwMjk0LCJqdGkiOiJ6bzRXZmxFazEycmxzdUVVIiwic3ViIjoiMSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.kccqnn7BERgpWYnMWPIgxwukrVGSWo-T8KWUwdZOfIk';

  ArtistProfileDetails({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(children: [
                      Center(
                        child:
                        CircleAvatar(
  radius: isMobile ? 60 : 100,
  backgroundImage: profile.image != null
      ? NetworkImage(SreverConfig.domainNameServerforImage + profile.image)
      : null,
  child: profile.image == null ? Icon(Icons.person, size: isMobile ? 50 : 100) : null,
),

                        /* CircleAvatar(
                          radius: isMobile ? 60 : 100,
                          backgroundImage: profile.image != null
                              ? NetworkImage(
                                  SreverConfig.domainNameServerforImage +
                                      profile.image)
                              : null,
                          child: profile.image == null
                              ? Icon(Icons.person, size: isMobile ? 50 : 100)
                              : null,
                        ),*/
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child:
                          Text(profile.name ?? "", style:
                           TextStyle(fontSize: isMobile ? 24 : 32, fontWeight: FontWeight.bold)),

                        /* Text(profile.name,
                            style: TextStyle(
                                fontSize: isMobile ? 24 : 32,
                                fontWeight: FontWeight.bold)),*/
                      ),
                      Center(
                        child: Text(profile.email,
                            style: TextStyle(
                                fontSize: isMobile ? 16 : 24,
                                color: Colors.grey)),
                      ),
                    ]),
                    CustomCircle(
                        number: profile.followersNumber,
                        typeOfPerson: 'followers'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      RatingBarIndicator(
                        rating: profile.ratesNumber.toDouble(),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: isMobile ? 40.0 : 50.0,
                        direction: Axis.horizontal,
                      ),
                      const SizedBox(height: 8),
                      Text('(${profile.ratesNumber} ratings)',
                          style: TextStyle(fontSize: isMobile ? 16 : 20)),
                    ],
                  ),
                ),
                const Divider(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(() {
                      return _buildActionButton(
                        followController.isFollowing.value
                            ? Icons.person_remove
                            : Icons.person_add,
                        followController.isFollowing.value
                            ? 'Unfollow'
                            : 'Follow',
                        isMobile,
                        () {
                          followController.toggleFollowArtist('5',
                              artistToken); // Replace with the actual token
                        },
                      );
                    }),
                    _buildActionButton(Icons.message, 'Message', isMobile, () {
                      // Message action
                    }),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                        Icons.panorama_outlined, 'Painting', isMobile, () {
                      // Follow action
                    }),
                    _buildActionButton(
                        Icons.article_outlined, 'articales', isMobile, () {
                      // Message action
                    }),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: _buildProfileCard(
                          'Expertise:', profile.expertise, isMobile),
                    ),
                    _buildProfileCard(
                        'Specialization:', profile.specialization, isMobile),
                    _buildProfileCard(
                        'Biography:', profile.biography, isMobile),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

 Widget _buildProfileCard(String title, String content, bool isMobile) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: isMobile ? 18 : 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(content, style: TextStyle(fontSize: isMobile ? 16 : 20)),
          ],
        ),
      ),
    );
  }

   Widget _buildActionButton(
      IconData icon, String label, bool isMobile, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: isMobile ? 20 : 30),
      label: Text(label, style: TextStyle(fontSize: isMobile ? 16 : 20)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            vertical: isMobile ? 12 : 18, horizontal: isMobile ? 20 : 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class UserProfileDetails extends StatelessWidget {
  final UserModel.ResultClass profile;

  const UserProfileDetails({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: isMobile ? 50 : 100,
                    
                    backgroundImage: profile.image != null
                        ? NetworkImage(profile.image)
                        : null,
                    child: profile.image == null
                        ? Icon(Icons.person, size: isMobile ? 50 : 100)
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(profile.name,
                      style: TextStyle(
                          fontSize: isMobile ? 24 : 32,
                          fontWeight: FontWeight.bold)),
                ),
                Center(
                  child: Text(profile.email,
                      style: TextStyle(
                          fontSize: isMobile ? 16 : 24, color: Colors.grey)),
                ),
                const Divider(height: 32),
                _buildProfileCard('Gender:', profile.gender ?? 'N/A', isMobile),
              ],
            ),
          ),
        );
      },
    );
  }

   Widget _buildProfileCard(String title, String content, bool isMobile) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: isMobile ? 18 : 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(content, style: TextStyle(fontSize: isMobile ? 16 : 20)),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:school_project/compomnt/rating_artist.dart';
// import 'package:school_project/compomnt/custom_botton.dart';
// import 'package:school_project/compomnt/custom_circle.dart';
// import 'package:school_project/models/artist_profile_model.dart' as ArtistModel;
// import 'package:school_project/models/user_profile_model.dart' as UserModel;

// import 'profile_controller.dart';

// class ProfileView extends StatelessWidget {
//   ProfileView({super.key});
// final ProfileController controller = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     // Replace with your logic to determine if it's an artist or user
//     bool isArtistLoggedIn = true; // Example condition

//     if (isArtistLoggedIn) {
//       controller.fetchArtistProfile();
//     } else {
//       controller.fetchUserProfile();
//     }

//     // double screenwidth = MediaQuery.of(context).size.width;
//     // double screenheight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Get.toNamed('/ArtistPersonalAccount');
//           },
//           icon: const Icon(
//             Icons.person,
//             size: 30,
//           ),
//         ),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         } else if (controller.isArtist.value &&
//             controller.artistProfile.value.success) {
//           ArtistModel.ResultClass profile = ArtistModel.ResultClass.fromJson(
//               controller.artistProfile.value.result[0]);
//           return ArtistProfileDetails(profile: profile);
//         } else if (!controller.isArtist.value &&
//             controller.userProfile.value.success) {
//           UserModel.ResultClass profile = UserModel.ResultClass.fromJson(
//               controller.userProfile.value.result[0]);
//           return UserProfileDetails(profile: profile);
//         } else {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Failed to load profile'),
//                 if (!controller.isArtist.value &&
//                     !controller.userProfile.value.success)
//                   Text('User profile fetch failed.'),
//                 if (controller.isArtist.value &&
//                     !controller.artistProfile.value.success)
//                   Text('Artist profile fetch failed.'),
//               ],
//             ),
//           );
//         }
//       }),
//     );
//   }
// }

// class ArtistProfileDetails extends StatelessWidget {
//   final ArtistModel.ResultClass profile;

//   ArtistProfileDetails({required this.profile});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ListView(
//         children: [
//           profile.image != null
//               ? Image.network(profile.image)
//               : Placeholder(fallbackHeight: 200),
//           SizedBox(height: 10),
//           Text('Name: ${profile.name}', style: TextStyle(fontSize: 18)),
//           Text('Email: ${profile.email}', style: TextStyle(fontSize: 18)),
//           Text('Expertise: ${profile.expertise}',
//               style: TextStyle(fontSize: 18)),
//           Text('Specialization: ${profile.specialization}',
//               style: TextStyle(fontSize: 18)),
//           Text('Biography: ${profile.biography}',
//               style: TextStyle(fontSize: 18)),
//           Text('Followers: ${profile.followersNumber}',
//               style: TextStyle(fontSize: 18)),
//           Text('Rates: ${profile.ratesNumber}', style: TextStyle(fontSize: 18)),
//           Text('Gender: ${profile.gender}', style: TextStyle(fontSize: 18)),
//           Text('Joined: ${profile.createdAt.toLocal()}',
//               style: TextStyle(fontSize: 18)),
//           Text('Last Updated: ${profile.updatedAt.toLocal()}',
//               style: TextStyle(fontSize: 18)),
//         ],
//       ),
//     );
//   }
// }

// class UserProfileDetails extends StatelessWidget {
//   final UserModel.ResultClass profile;

//   UserProfileDetails({required this.profile});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ListView(
//         children: [
//           profile.image != null
//               ? Image.network(profile.image)
//               : Placeholder(fallbackHeight: 200),
//           SizedBox(height: 10),
//           Text('Name: ${profile.name}', style: TextStyle(fontSize: 18)),
//           Text('Email: ${profile.email}', style: TextStyle(fontSize: 18)),
//           Text('Gender: ${profile.gender ?? 'N/A'}',
//               style: TextStyle(fontSize: 18)),
//           Text('Joined: ${profile.createdAt.toLocal()}',
//               style: TextStyle(fontSize: 18)),
//           Text('Last Updated: ${profile.updatedAt.toLocal()}',
//               style: TextStyle(fontSize: 18)),
//         ],
//       ),
//     );
//   }
// }