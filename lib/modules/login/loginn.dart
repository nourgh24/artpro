import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/navpar/navpar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/modules/login/loginn_controller.dart';
import 'package:flutter/src/widgets/framework.dart';

class Loginn extends StatefulWidget {
  final String apiUrl;
  final int role;
  const Loginn({required this.apiUrl,super.key, required this.role});
  @override
  State<Loginn> createState() => _LoginnState();
}
class _LoginnState extends State<Loginn> {

  final LoginnController _controller = Get.put(LoginnController());
bool _obscuretext =true;

final GlobalKey<FormState> form_Key=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(4.0),
          child: Scaffold(
            body:Form(
              key: form_Key,
            child:Stack(
              children:[
            
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
                      Get.toNamed('/Welcome');
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
                        children: [
                          SizedBox(width: screenwidth*0.05,),
                          Text("LOG_IN ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 35,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.lerp(FontWeight.bold, FontWeight.w100, 10),
                          ),),
                        ],
                      ),
                      SizedBox(height:screenheight*0.04,),
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
                      height: screenheight*0.05,
                      width: screenwidth *0.01,
                    ),
                      TextFormField(
                        obscureText: _obscuretext,
                        controller: _controller.passwordController,
                        onSaved: (input){
                         // controller.email=input!;
                        },
                        validator:  (input) {
                  
                          if(input!.isEmpty || input==null){
                            return "Password can't be empty";
                          }else if(input.length<6){
                            return "Password must be of 6 characters";
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
                      height: screenheight*0.03,
                    
                      ),
                      GestureDetector(onTap: (){
                        Get.toNamed('/ForgetPassword');
                      },
                        child: Text("Forget Password ? Reset Now",
                        style: TextStyle(
                          color: Colors.indigo[800],
                        ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                  
                        ],
                      ),
                  
                     SizedBox(
                      height: screenheight*0.12,
                    ),
                  Obx((){
                    if(_controller.logInState.value==LogInState.loading){
                      return CircularProgressIndicator();
                    }
                    if(_controller.logInState.value==LogInState.error){
                  
                    }
                    if(_controller.logInState.value==LogInState.succsesful){
                  
                      Get.toNamed('/Navpar');
                    }
                    return  ElevatedButton(
                      onPressed: () {
                        if(form_Key.currentState!.validate()){
                          _controller.loginn(role: widget.role,apiUrl:widget. apiUrl );
                        }
                        //Get.offNamed(PageHome());
                      },
                      child: Text('Login',
                        style: TextStyle(
                          fontSize:20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[300],
                  
                        padding: EdgeInsets.fromLTRB(80,20,80,20),
                      ),
                    );
                  }),
                  
                      SizedBox(
                        height: 10,
                  
                      ),
                  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text('Dont Have An Account ??',
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
                              Get.back();
                            },
                            child: Text("Create one",
                              style: TextStyle(
                                color: Colors.indigo[800],
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
