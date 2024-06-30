import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/modules/certificate%20of%20reliability/certificate.dart';
import 'package:untitled5/modules/confrim%20code/confrim_code.dart';
import 'package:untitled5/modules/login/loginn.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/modules/navpar/navpar.dart';
import 'package:untitled5/modules/painting_home_page/page_home.dart';
import 'registerr_controller.dart';
import 'package:email_otp/email_otp.dart';

class Registerr extends StatefulWidget {
  final int role;
  final String   apiUrl;
  const Registerr({required this.apiUrl,required this.role,super.key});
  
  @override
  State<Registerr> createState() => _RegisterrState();
}

class _RegisterrState extends State<Registerr> {
  final RegisterrController _controller = Get.put(RegisterrController());
  bool _obscuretext =true;
  EmailOTP myauth=EmailOTP();
  String errorTextVal='';
  final GlobalKey<FormState> form_Key=GlobalKey<FormState>();

  int activeIndex=0;

  @override
  Widget build(BuildContext context) {
     double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body:Form(
        key: form_Key,
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child:Stack(
            children:[
             
              Container(
                decoration: BoxDecoration(image:DecorationImage(
                    opacity:0.2,
                    fit: BoxFit.fitHeight,
                    image:AssetImage("images/4.jpg")
                ),
                ),
              ),

              Row(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(onPressed:(){
                    Get.toNamed('/Loginn');
                  },
                    icon: Icon(Icons.arrow_back),
                  ),
                ],
              ),

              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenheight*0.1,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: screenwidth*0.05,),
                        Text("REGISTER",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 35,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.lerp(FontWeight.bold, FontWeight.w100, 10),
                          ),),
                      ],
                    ),
                    SizedBox(height: screenheight*0.04,),
                    TextFormField(
                      controller: _controller.fullnameController,
                      validator: (input) {
                        if(input!.isEmpty  || input==null){
                          return "Name cant be empty";
                        }
                        else if(!RegExp(r'^[a-zA-Z\s]+$').hasMatch(input!)){
                          return "Enter Correct Name";
                        }else {
                          return null;
                        }
                      },
                
                      decoration: InputDecoration(
                        errorText:errorTextVal.isEmpty?null:errorTextVal,
                        icon:Icon(
                          Icons.person,
                          color:Colors.black54,
                          size: 20,
                        ),
                        helperMaxLines: 10,
                        labelText: 'Full Name ',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontSize:17,
                        ),
                      ),
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(
                      height: screenheight*0.02,
                      width: screenwidth *0.01,
                    ),
                
                
                    TextFormField(
                      controller: _controller.emailController,
                      validator: (input) {
                        if(input!.isEmpty  || input==null){
                          return "Email can't be empty";
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
                      height: screenheight*0.02,
                      width: screenwidth *0.01,
                    ),
                
                    TextFormField(
                      obscureText: _obscuretext,
                      controller: _controller.passwordController,
                      validator:  (input) {
                        if(input!.isEmpty || input==null){
                          return "Password can't be empty";
                        }else if(input.length<8){
                          return "Password must be of 8 characters";
                        }else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        icon:Icon(
                          Icons.lock_outline_sharp,
                          color:Colors.black54,
                          size: 20,
                        ),
                        labelText:'Password',
                        labelStyle: TextStyle(color: Colors.black,
                          fontSize:17,
                          fontStyle: FontStyle.italic,
                        ),
                        suffixIcon: GestureDetector(
                          onTap:(){
                            setState(() {
                              _obscuretext= !_obscuretext;
                            });
                          },
                          child: Icon(
                            _obscuretext ? Icons.visibility_off :Icons.visibility,
                          ),
                        ),
                      ),
                      style: TextStyle(color: Colors.black54),
                
                    ),
                
                    SizedBox(
                      height: screenheight*0.02,
                      width: screenwidth *0.01,
                    ),
                
                    TextFormField(
                      obscureText: _obscuretext,
                      controller: _controller.confirmPasswordController,
                      validator:  (input) {

                        if(input!.isEmpty || input==null){
                          return "Password can't be empty";
                        }else if(input.length<8){
                          return "Password must be of 8 characters";
                        }else if(input!=_controller.passwordController.text){
                          return "Passwords do not match";
                        }
                        else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        icon:Icon(
                          Icons.lock_outline_sharp,
                          color:Colors.black54,
                          size: 20,
                        ),
                        labelText:'Confirm Password',
                        labelStyle: TextStyle(color: Colors.black,
                          fontSize:17,
                          fontStyle: FontStyle.italic,
                        ),
                        suffixIcon: GestureDetector(
                          onTap:(){
                            setState(() {
                              _obscuretext= !_obscuretext;
                            });
                          },
                          child: Icon(
                            _obscuretext ? Icons.visibility_off :Icons.visibility,
                          ),
                        ),
                      ),
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(
                      height: screenheight*0.02,
                      width: screenwidth *0.01,
                    ),
                
                    Obx((){
                      if (_controller.registerState.value==RegisterState.loading){
                        return CircularProgressIndicator();
                      }
                   
                      return ElevatedButton(
                        onPressed: () {
                          /* async{
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
                              content: Text("OTP has been sent"),
                          ));
                          Get.toNamed('/ConfrimCode');
                        }else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Oops,OTP send failed"),
                          ));
                        }*/
                         

                          if(form_Key.currentState!.validate()) {

                            _controller.register(
                              role: widget.role,
                              apiUrl: widget.apiUrl
                            );
                            return form_Key.currentState!.save() ;
                          }
                          //Get.offNamed(PageHome());
                        },
                        child: Text('Register',
                          style: TextStyle(
                            fontSize:20,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  Colors.orange[300],
                          padding: EdgeInsets.fromLTRB(80,20,80,20),
                        ),
                      );
                    }    ),

                    SizedBox(height: 10,),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text('Already Have An Account ??',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight:FontWeight.normal,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if(widget.apiUrl==UrlsApi.registerUserApi){

                              Get.to(Loginn(role: widget.role,apiUrl:UrlsApi.loginUserApi ));

                            }else{
                              Get.to(Loginn(role:  widget.role,apiUrl:UrlsApi.loginArtistApi ));

                            }

                          },
                          child: Text("Login",
                            style: TextStyle(
                              color: Colors.black12,
                              fontStyle:FontStyle.italic,
                              fontWeight:FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

