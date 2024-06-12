
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';
import 'package:untitled5/modules/Account/Widgets/menu_item.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/welcome/welcome.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:  SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 4.h,
            ),
          
            MenuItemm(
              title: "Basic Info",
              tap: () {
            
              },
              // image: AppAssets.profileIcon,
            ),
        
          
         
            MenuItemm(
              title: "Security",
              tap: () {
            
              },
              // image: AppAssets.lockIcon,
            ),
            Column(
                  children: [
                    MenuItemm(
                      title: "Log Out",
                      tap: () {
                 AppSharedPreferences.removeToken();
                 AppSharedPreferences.removeRole();
                     AppSharedPreferences.removeId();
                 Get.offAll(Welcome());
                      
                      },
                      // image: AppAssets.logoutIcon,
                    ),
                    // MenuItemm(
                    //   title: "Delete your account".tr(context),
                    //   tap: () {
                    //     showConfirmDialog(context,
                    //         title:
                    //             "Are you sure you want to delete your account ? "
                    //                 .tr(context), onPressed: () {

                    //     });
                    //   },
                    //   image: AppAssets.deleteIcon,
                    // ),
               
                  
                  ],
                )
          ]),
        ),),
    );
  }
}
