import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/Painting%20list/painging_avatar_widget.dart';
import 'package:untitled5/modules/Profile%20Edit/profile_edit_controller.dart';
import 'package:untitled5/modules/Profile%20Edit/profile_edit_service.dart';
import 'package:untitled5/modules/profiles/profiles_controller.dart';


class ProfileEdit extends StatelessWidget {
  final Editprofile? editprofile;
  final int? index;
   ProfileEdit({ this.index,this.editprofile ,super.key});
 
  final GlobalKey<ScaffoldState> key =GlobalKey();
  final ProfileEditController _controllerEdit = Get.put(ProfileEditController());
    final ProfilesController _controller = Get.put(ProfilesController());


  int id=AppSharedPreferences.getId ;

  final ProfileUserNameController = TextEditingController();
  final ProfileBiographyController = TextEditingController();
  final ProfilegenderController = TextEditingController();
  final ProfilespecializationController = TextEditingController();
  final ProfileexpertiseController = TextEditingController();

 
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

     if (editprofile != null) {
      ProfileUserNameController.text = editprofile!.user_name;
      ProfileBiographyController.text = editprofile!.biography;
      ProfilespecializationController.text = editprofile!.specialization;
      ProfileexpertiseController.text = editprofile!.expertise;
      _controllerEdit.immage = editprofile!.image;
    }  
    return SafeArea(
      child: Scaffold(
         appBar: AppBar(
          backgroundColor: Colors.orange[200],
          title: Text("Edit Profile", style: TextStyle(color: Colors.white, fontSize: 23),),
          actions: [
              Obx((){
                  if (_controllerEdit.profileditState.value == ProfileEditState.loading ){
           
                     return CircularProgressIndicator();
                     }

                     return TextButton(
                    onPressed: () {
                      final neweditProfile = Editprofile(
                        user_name:ProfileUserNameController.text,
                        biography:ProfileBiographyController.text,
                        specialization:ProfilespecializationController.text ,
                        expertise:ProfileexpertiseController.text,
                        image: _controllerEdit.immage!,

                      );
                      if (index !=null || index ==null) {
                        _controllerEdit.EditProfile(editprofile:  neweditProfile).then((_){
                           Get.snackbar(
                'Success',
                'Profile Edit successfully',
                backgroundColor: Color.fromARGB(255, 194, 236, 196),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
              Get.back(); 
                        }).catchError((error) {
            /*  Get.snackbar(
                'Error',
                'Failed to add article: $error',
                backgroundColor: Color.fromARGB(255, 229, 185, 181),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );*/
            });
                      }
                    },
                    child: Text('Done'),
                     );
              }
              ),
          ],
        ),
       
        body:Padding(
          padding: EdgeInsets.all(2.0),
          child: SingleChildScrollView(
            child: SizedBox(
            height: screenheight*0.93,
            width: screenwidth,
              child: Column(
                children: [
                  Expanded(child: Obx((){
                     if (_controllerEdit.profileditState.value == ProfileEditState.loading) {
                        return Center(child: CircularProgressIndicator());
                      }
                  
                      if (_controllerEdit.profileditState.value == ProfileEditState.error) {
                        return SizedBox();
                      }
                    return Container(
                       decoration: BoxDecoration(
                        color: Color.fromARGB(255, 220, 215, 215),

                      ),
                      height: screenheight*0.9,
                      width: screenwidth,
                      child: 
                          Column(
                            children: [
                              Stack(
                                children: [
                                   Container(
                                    height: screenheight *0.3,
                                     decoration: BoxDecoration(
                                      color:Color.fromARGB(255, 204, 214, 220),
                                     borderRadius: BorderRadius.only(
                                     bottomLeft: Radius.circular(60),
                                     bottomRight: Radius.circular(60),
                                     topLeft: Radius.circular(20), 
                                     topRight: Radius.circular(20), 
                                            ),
                                            boxShadow: [
                                          new BoxShadow(
                                         color: Color.fromARGB(255, 219, 194, 163),
                                         offset: new Offset(20.0, 20.0),
                                          blurRadius: 20,
                                          spreadRadius: 1.0,
                                            ),
                                            ],
                                          ),
                                          padding: const EdgeInsets.only(
                                            left: 30,
                                            top: 30,
                                            bottom: 60,
                                          ),
                                   ),
                              if (_controllerEdit.immage != null)
                           /*   Positioned(
                                     top: 55,
                                     left: screenwidth*0.33,
                                     child: CachedNetworkImage(
                              placeholder: (context, url) => Center(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.5),
                                  highlightColor: Colors.grey,
                                  child: const CircleAvatar(
                                    radius: 60,
                                  ),
                                ),
                              ),
                              imageUrl:UrlsApi.baseimageUrl+ _controllerEdit.immage!.path,
                              // _controller.getprofilesmodel!.Profiles!.image ?? "",
                              errorWidget: (context, url, error) => CircleAvatar(
                                radius: 60,
                                backgroundImage: AssetImage('images/10.jpg'),
                              ),
                              fit: BoxFit.cover,
                                                      ),
                                   ),*/
                                /*   Positioned.fill(
                                child: PaingingAvatarWidget(
                              fileImage: _controllerEdit.immage!,
                            )),*/

                            Positioned.fill(
                              top: 40,
                              left: screenwidth*0.1,
                              right: screenwidth*0.1 ,
                              bottom: 40,
                                child: PaingingAvatarWidget(
                              fileImage: _controllerEdit.immage!,
                            )),
                          Positioned(
                            top: 160,
                            right: screenwidth *0.15,
                            child: IconButton(
                              onPressed: () {
                                _controllerEdit.pickImage().then((_) {
                                  _controllerEdit.update();
                                });
                              },
                              icon: Icon(
                              Icons.add_a_photo,
                                  size: 35.0,
                                color: Color.fromARGB(255, 250, 249, 249),
                              ),
                            ),
                          ),
                                                     
                                ],
                              ),
                          
                          
                      SizedBox(height: screenheight*0.03,),
                         Container(
                           child: Expanded(
                             child: TextFormField(
                              decoration: InputDecoration(labelText: 'User Name',
                              border: OutlineInputBorder(),
                              ),
                               controller: ProfileUserNameController,
                              ),
                           ),
                         ),

                         Expanded(
                           child: TextFormField(
                            decoration: InputDecoration(labelText: 'Biography',
                            border: OutlineInputBorder(),
                            ),
                             controller: ProfileBiographyController,
                            ),
                         ),
                        
                         Expanded(
                           child: TextFormField(
                            decoration: InputDecoration(labelText: 'Specialization',
                            border: OutlineInputBorder(),
                            ),
                             controller: ProfilespecializationController,
                            ),
                         ),
                         
                         Expanded(
                           child: TextFormField(
                            decoration: InputDecoration(labelText: 'Expertise',
                            border: OutlineInputBorder(),
                            ),
                             controller: ProfileexpertiseController,
                            ),
                         ),
                          
                            ],
                          ),
                      
                    );
                  })),
                ],
              ),
            ),
          ),
        ),
      ),);
  }
}