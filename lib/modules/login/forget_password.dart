import 'package:untitled5/modules/login/loginn_controller.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'loginn_controller.dart';

class ForgetPassword extends StatelessWidget {

  final LoginnController _controller = Get.put(LoginnController());
  EmailOTP myauth=EmailOTP();
  final GlobalKey<FormState> form_Key=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Padding(
        padding: const EdgeInsets.all(4.0),
        child: Scaffold(
          body:Form(
            child:Stack(
              children:[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                        scrollDirection: Axis.vertical),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(image:DecorationImage(
                    opacity:0.3,
                    fit: BoxFit.fitHeight,
                    image:AssetImage("images/4.jpg"),
                  ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(onPressed:(){
                      Get.toNamed('/ConfrimCode');                    },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 40,),
                        Text("Reset Password ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 35,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.lerp(FontWeight.bold, FontWeight.w100, 10),
                          ),),
                      ],
                    ),
                    SizedBox(height: 40,),
                    TextFormField(
                      controller: _controller.emailController,
                      validator: (input) {
                        if(input!.isEmpty  || input==null){
                          return "Email cant be empty";
                        }
                        else if(!RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]'
                            r'+(\.[^<>()[\]\\.,;:\s@\"]'
                            r'+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)'
                            r'+[a-zA-Z]{2,}))$').hasMatch(input!)){
                          return "Enter Correct Email";
                        }else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        icon:Icon(
                          Icons.email_outlined,
                          color:Colors.black54,
                          size: 20,
                        ),
                        helperMaxLines: 10,
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontSize:17,
                        ),
                      ),
                      style: TextStyle(color: Colors.black54),
                    ),

                    SizedBox(
                      height: 100,
                      width: 10,
                    ),

                    ElevatedButton(
                      onPressed: ()
                      async{
                      /*  _controller.loginn();
                        if(form_Key.currentState!.validate()){
                          return form_Key.currentState!.save();}*/
                        myauth.setConfig(
                            appEmail: "contact@hdevcoder.com",
                            appName: "Email OTP",
                            userEmail: _controller.emailController.text,
                            otpLength: 6,
                            otpType: OTPType.digitsOnly
                        );
                        if(await myauth.sendOTP()==true){
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Password Reset email link is been sent"),
                          ));
                          Get.toNamed('/ConfrimCode');
                        }else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Oops,Error In Email Reset"),
                          ));
                          Get.toNamed('/ConfrimCode');
                        }
                      },

                      child: Text('SEND',
                        style: TextStyle(
                          fontSize:20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  Colors.amber,

                        padding: EdgeInsets.fromLTRB(80,20,80,20),
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
