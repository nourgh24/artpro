import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/Account/account_screen.dart';
import 'package:untitled5/modules/Painting%20list/add_new_painting.dart';
import 'package:untitled5/modules/Painting%20list/painting_list.dart';
import 'package:untitled5/modules/profiles/profiles.dart';

import '../article comments/article_comments.dart';
import '../articles/articles.dart';
import '../articles_details/articles_details.dart';
import '../gallery list/gallery_list.dart';
import '../painting details/painting _details.dart';
import '../painting_home_page/page_home.dart';

class Navpar extends StatefulWidget {
   //final int role;
  final String   apiUrl;
  const Navpar({required this.apiUrl,
  //required this.role,
  super.key});
  

  @override
  State<Navpar> createState() => _NavparState();
}

class _NavparState extends State<Navpar> {
  List Screens=[
    HomePage(),
    Articles(),
    GalleryList(),
   //Profiles(),
    Profiles(artistId: AppSharedPreferences.getId,),
    AccountScreen(),

  ];
  int _selectedIndex=0;

  final List<Widget> _navigationItem=[
    const Icon(Icons.home,color: Colors.orangeAccent,),
    // const Icon(Icons.dashboard_outlined,color: Colors.orangeAccent,),
    const Icon(Icons.edit_note,color: Colors.orangeAccent,),
    const Icon(Icons.photo_library_outlined,color: Colors.orangeAccent,),
    const Icon(Icons.person,color: Colors.orangeAccent,),
    const Icon(Icons.favorite,color: Colors.orangeAccent,),

  ];

  Color bgColor=Colors.orange.shade200;

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
         // color: bgColor,
        bottomNavigationBar: CurvedNavigationBar(
          // height: screenheight*0.1,
          buttonBackgroundColor: Colors.white,
          color: Colors.white,
          backgroundColor: bgColor,
          items: _navigationItem,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index){
    
    setState(() {
      _selectedIndex=index;
    });
    },
    ),
        body:  Screens[_selectedIndex],
      ),
    );
  }
}
