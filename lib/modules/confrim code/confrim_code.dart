import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/certificate%20of%20reliability/certificate.dart';
import 'package:untitled5/modules/confrim%20code/confrim_code_controller.dart';
import 'package:untitled5/modules/navpar/navpar.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Otp extends StatelessWidget {
  const Otp({
    Key?key,
    required this.otpController,
  }): super(key: key);
  final TextEditingController otpController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value){
          if(value.length==1){
            FocusScope.of(context).nextFocus();
          }
          if(value.isEmpty){
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: const InputDecoration(
          hintText: ('0'),
        ),
        onSaved: (value){

        },
      ),
    );
  }
}
class ConfrimCode extends StatefulWidget {
   final int role;
  final String   apiUrl;
   ConfrimCode({Key? key, required this.apiUrl, required this.role,required this.email}):super(key: key);
  final String email;
  final EmailOTP myauth=EmailOTP();

  @override
  State<ConfrimCode> createState() => _ConfrimCodeState();
}
class _ConfrimCodeState extends State<ConfrimCode> {
  TextEditingController otp1Controller=TextEditingController();
  TextEditingController otp2Controller=TextEditingController();
  TextEditingController otp3Controller=TextEditingController();
  TextEditingController otp4Controller=TextEditingController();
  TextEditingController otp5Controller=TextEditingController();
  TextEditingController otp6Controller=TextEditingController();

  final ComfirmController _controller = Get.put(ComfirmController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Stack(
            children:[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(31, 253, 251, 251),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 40,
                        width: 10,
                      ),
                      IconButton(onPressed: (){
                        Get.back();
                      }, icon: Icon(Icons.arrow_back_outlined)),
                    ],
                  ),
                  SizedBox(height: 50,),
                  Container(
                    width: 450,
                    height: 280,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/13.jpg"),
                        opacity:0.12,
                        fit: BoxFit.fitHeight,
                      ),
                      color: Colors.black12,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(70, 70),
                          bottom:Radius.elliptical(70, 70)),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        const Icon(Icons.dialpad_rounded,size: 50,),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Enter Code",
                          style: TextStyle(fontSize: 35),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Otp(otpController: otp1Controller),
                            Otp(otpController: otp2Controller),
                            Otp(otpController: otp3Controller),
                            Otp(otpController: otp4Controller),
                            Otp(otpController: otp5Controller),
                            Otp(otpController: otp6Controller),
                          ],
                        ),
                       
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Rider can`t find a pin",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
               Obx((){
                 if(_controller.comfirmState.value==ComfirmState.loading){
                   return CircularProgressIndicator();
                 }
                 if(_controller.comfirmState.value==ComfirmState.error){
                   Get.snackbar('Error', _controller.message ?? 'ops, trey again',
                   snackPosition: SnackPosition.BOTTOM, 
                   backgroundColor: Color.fromARGB(255, 219, 232, 233));
                 }
                  
                 if(_controller.comfirmState.value==ComfirmState.succsesful){
                   if (AppSharedPreferences.getRole == 0) {
                    /* Get.offAll(Navpar(  
                               role: 0,
                               apiUrl: UrlsApi.homeApi,
                              ));*/
                      Get.to(ArtistView(
                            role: 0,
                            apiUrl: UrlsApi.CertificateApi,
                    ));
                       }else {
                             Get.offAll(Navpar(  
                              // role: 1,
                               apiUrl: UrlsApi.homeApi,
                              ));
                              }
                 }
                 return    ElevatedButton(
                   onPressed:() async{
                     _controller.comfirm(otp: otp1Controller.text +
                         otp2Controller.text +
                         otp3Controller.text +
                         otp4Controller.text +
                         otp5Controller.text +
                         otp6Controller.text, email: widget.email);
                     
                   },
                   child: const Text("Confirm",
                     style: TextStyle(fontSize: 20,color: Colors.black87),
                   ),
                   style: ElevatedButton.styleFrom(
                     backgroundColor:Colors.orange[200],
                     padding: EdgeInsets.fromLTRB(60,20,60,20),
                  
                   ),
                 );
               })
                ],
              ),
            ),
          ),
        ),
            ],
      ),
      ),
    );
  }
}

