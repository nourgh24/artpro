import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/compomnt/custom_screen_mover.dart';

class ArtistPersonalAccount extends StatelessWidget {
  const ArtistPersonalAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'images/d.jpeg',
                    ),
                  ),
                ),
                child: const SizedBox(
                  width: 92.1,
                  height: 110.1,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Pablo Picasso',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'zainma9901@gmail.com',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            ),
            CustomScreenMover(
              icon: Icons.person,
              screenName: 'Edit Profil',
              screenMover: () => Get.toNamed('/ArtistProfile'),
            ),
            CustomScreenMover(
              icon: Icons.add_circle,
              screenName: 'add panit',
              screenMover: () => Get.toNamed('/ArtistProfile'),
            ),
            CustomScreenMover(
              icon: Icons.article,
              screenName: 'add articale',
              screenMover: () => Get.toNamed('/ArtistProfile'),
            ),
            CustomScreenMover(
              icon: Icons.favorite,
              screenName: 'favorite',
              screenMover: () => Get.toNamed('/ArtistProfile'),
            ),
            CustomScreenMover(
              icon: Icons.settings,
              screenName: 'settings',
              screenMover: () => Get.toNamed('/ArtistProfile'),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'sign out',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
