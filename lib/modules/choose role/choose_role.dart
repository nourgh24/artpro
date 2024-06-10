

import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/modules/register/registerr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'choose_role_controller.dart';
import 'choose_role_service.dart';


class ChooseRole extends StatefulWidget {
  @override
  State<ChooseRole> createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {

  final ChooseRoleController _controller = Get.put(ChooseRoleController());
  final ChooseRoleService _service = ChooseRoleService();
  List<bool> selected=[false,false];
  List<String> image=["images/7.jpg","images/4.jpg"];
  List<String> title=["artist","intersted in art"];
  int activeIndex=0;
  // bool click_artist=false;
  // bool click_intersted=false;

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    return Scaffold(
      body:Form(
        child:Stack(
          children:[
            SizedBox(height: 50,),
            Container(
              width: screenwidth,
              height: screenheight,
              decoration: BoxDecoration(image:DecorationImage(
                opacity:0.1,
                fit: BoxFit.fitHeight,
                image:AssetImage("images/4.jpg"),
              ),
              ),
            ),

            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenheight*0.1,),
                  Text('Please Choose',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: screenheight*0.06,),

                  Column(children: List.generate(selected.length, (index) =>  InkWell(
                    onTap: (){
                      setState((){
                        for(int buttonIndex=0;buttonIndex<selected.length;buttonIndex++){
                          if(buttonIndex==index){

                            selected[buttonIndex]=true;
                            activeIndex=buttonIndex;
                          }else{
                            selected[buttonIndex]=false;

                          }


                        }


                      });
                    },
                    child:  Container(
                      width: screenwidth*0.5,
                      height: screenheight*0.2,
                      padding:EdgeInsets.only(left:20,right:20, top:10),
                      margin:EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                      decoration: BoxDecoration(
                        color: (selected[index])?  Colors.greenAccent[100]:Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:Column(
                        children:[
                          Image(
                            image:
                            AssetImage(image[index]),
                            // color: Colors.blueAccent,
                            height: 80,
                            width: 160,
                          ),
                          Text(title[index],
                            style:TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                    ),
                  ),),),

                  SizedBox(height: 40,),

                  // InkWell(
                  //   onTap: (){
                  //     setState((){
                  //       click_intersted =!click_intersted;
                  //     });
                  //   },
                  //   child:  Container(
                  //     width: screenwidth*0.5,
                  //     height: screenheight*0.2,
                  //     padding:EdgeInsets.only(left:20,right:20, top:10),
                  //     margin:EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                  //     decoration: BoxDecoration(
                  //       color: (click_intersted==false )? Colors.white :Colors.greenAccent[100],
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //     child:Column(
                  //       children:[
                  //         ImageIcon(
                  //           AssetImage("images/4.jpg"
                  //           ),
                  //           color: Colors.blueAccent,
                  //           size: 80,
                  //         ),
                  //          Text('intersted in art',
                  //           style:TextStyle(
                  //             color: Colors.black54,
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //
                  //   ),
                  // ),

                  //  SizedBox(width: 3,),

                  SizedBox(
                    height: screenheight*0.1,
                  ),

                  Row(
                    children: [
                      SizedBox(width: screenwidth*0.1,),
                      ElevatedButton(
                        onPressed: () { //
                          //  _controller.filteredData();
                          Get.toNamed('/Welcome');
                        },
                        child: Text('Back',
                          style: TextStyle(
                            fontSize:17,
                          ),
                        ),
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:Colors.orangeAccent ,

                          // primary: Colors.orangeAccent,
                          // onPrimary: Colors.white,
                          // onSurface: Colors.red,
                          padding:
                          EdgeInsets.fromLTRB(40,20,40,20),
                          foregroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(width:screenwidth*0.12,),
                      ElevatedButton(
                        onPressed: () { //
                          //  _controller.filteredData();
                          if(activeIndex==1){

                            Get.to(Registerr(
                              apiUrl: UrlsApi.registerUserApi,
                            ));

                          }else{
                            Get.to(Registerr(
                              apiUrl: UrlsApi.registerArtistApi,
                            ));
                          }

                          //Get.offNamed(PageHome());
                        },
                        child: Text('Next',
                          style: TextStyle(
                            fontSize:17,
                          ),
                        ),
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:Colors.orangeAccent ,

                          // primary: Colors.orangeAccent,
                          // onPrimary: Colors.white,
                          // onSurface: Colors.red,
                          padding:
                          EdgeInsets.fromLTRB(40,20,40,20),
                          foregroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(width: screenwidth*0.1,)
                    ],
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PictureWidget extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return new ImageIcon(new AssetImage("images/intersted in art.jpg"),
      color: Colors.blueAccent,
      size: 30,
    );
  }
}