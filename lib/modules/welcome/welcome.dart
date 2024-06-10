import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/navpar/navpar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'welcome_controller.dart';

class Welcome extends GetView<WelcomeController> {
  final WelcomeController _controller = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: screenwidth,
            height: screenheight,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SingleChildScrollView(scrollDirection: Axis.vertical),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.8,
                      fit: BoxFit.fitHeight,
                      image: AssetImage("images/4.jpg"),
                    ),
                  ),
                ),

                /*  Panorama(
                      interactive: true,
                     minLatitude: -90,
                      sensitivity: 1.0,
                      animReverse: true,
                      zoom: 0,
                      animSpeed: 1.0,
                      child: controller.selectedImagePath.value != ''
                          ? Image.file(
                        File(controller.selectedImagePath.value),
                        fit: BoxFit.cover, // تحديد كيفية تناسب الصورة داخل المساحة المخصصة لها
                      )
                          : Image.asset(
                        'images/4.jpg',
                        fit: BoxFit.cover, // تحديد كيفية تناسب الصورة داخل المساحة المخصصة لها
                      ),
                    ),*/
                /*Panorama(

                      interactive: true,
                     minLatitude: -90,
                      sensitivity: 1.0,
                      animReverse: true,
                      zoom: 1,
                      animSpeed: 1.0,
                      child: controller.selectedImagePath.value!=''
                      ?Image.file(File(controller.selectedImagePath.value))
                      :Image.asset('images/5.jpg'),
                    ),*/

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 180),
                    Row(
                      children: [
                        SizedBox(width: 25),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dope Art ',
                              style: TextStyle(
                                color: Colors.red,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 45,
                                backgroundColor: Colors.white54,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              ' Collections ',
                              style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                backgroundColor: Colors.white54,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              ' Creativity is intelligence having fun. ',
                              style: TextStyle(
                                color: Colors.black54,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                backgroundColor: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenheight * 0.25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //Get.offNamed(PageHome());
                    
                        if (AppSharedPreferences.hasToken) {
                          Get.to(Navpar());
                        } else {
                          Get.toNamed('/ChooseRole');
                        }
                      },
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo[400],
                        padding: EdgeInsets.fromLTRB(60, 20, 60, 20),
                        elevation: 5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: (){
         // controller.getImage(ImageSource.gallery);
        },
        child: Icon(Icons.panorama),
      ),*/
    );
  }
}
