
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/navpar/navpar.dart';
import 'package:untitled5/modules/register/registerr_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart'as g;
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../Services/Network/dio_api_service.dart';
import 'package:untitled5/Services/Helper/error_api_handler.dart';
import 'package:untitled5/Services/Network/dio_api_service.dart';

class RegisterrController extends g.GetxController {
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RegisterrService service =RegisterrService();
  DioApiService dioApiService=DioApiService();
  String? message;
  Rx<RegisterState> registerState=RegisterState.init.obs;
  Future register({required String apiUrl,required int role}) async {
    try{
      registerState(RegisterState.loading);
      Response response=await dioApiService.postData( apiUrl,
          data: {'name': fullnameController.text,
        'email':emailController.text, 'password':passwordController.text,
            'c_password':confirmPasswordController.text});
      if(response.data!=null&&response.statusCode==200){
if(response.data!['success']){
   AppSharedPreferences.saveToken(response.data["result"][0]['token']) ;
   
     AppSharedPreferences.saveRole(role) ;
       AppSharedPreferences.saveId(response.data["result"][0]['id']) ;
          g.  Get.to(Navpar());
        registerState(RegisterState.succsesful);


}else{
   message=response.data!['date'];
  registerState(RegisterState.error);
  g.Get.snackbar('Error',message!);

}
     
      }
    }catch(error){
      if (error is DioException){
        message=ErrorApiHandler.getErrorMessage(error);
        registerState(RegisterState.error);
      }
      else{
        message=error.toString();
        registerState(RegisterState.error);
      }
    }
    service.registerr(fullnameController, emailController, passwordController, confirmPasswordController);
    // يمكنك هنا إضافة المنطق الخاص بتسجيل الدخول
    print('Full Name: ${fullnameController.text}');
    print('Email: ${emailController.text}');
    print('Password: ${passwordController.text}');
    print('Confirm Password: ${confirmPasswordController.text}');
  }

  @override
  void dispose() {
    fullnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
enum RegisterState{
  init,
  succsesful,
  error,
  loading,
}