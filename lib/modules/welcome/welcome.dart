import 'package:untitled5/Services/Network/urls_api.dart';
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
                        if (AppSharedPreferences.hasToken) {
                          if(AppSharedPreferences.getRole==0){
                          Get.to(Navpar(
                           //role: 0,
                           apiUrl: UrlsApi.homeApi,
                          ));
                          }if(AppSharedPreferences.getRole==1) {
                          Get.to(Navpar(
                           //role: 1,
                           apiUrl: UrlsApi.homeApi,
                          ));
                          }
                        } else {
                          Get.toNamed('/ChooseRole');
                        }
                      },
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 221, 159, 66),
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
      
    );
  }
}
