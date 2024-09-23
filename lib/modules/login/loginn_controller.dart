import 'package:untitled5/Services/Helper/error_api_handler.dart';
import 'package:untitled5/Services/Network/dio_api_service.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/confrim%20code/confrim_code.dart';
import 'package:untitled5/modules/login/loginn_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as g;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/utils.dart';
import 'package:untitled5/modules/navpar/navpar.dart';

class LoginnController extends g.GetxController {
  DioApiService dioApiService = DioApiService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Rx<LogInState> logInState = LogInState.init.obs;
  String? message;
  int activeIndex=0;


  Future loginn({required String apiUrl, required int role}) async {
    try {
      logInState(LogInState.loading);
      Response response = await dioApiService.postData(apiUrl, data: {
        'email': emailController.text,
        'password': passwordController.text
      });
      if (response.data != null && response.statusCode == 200) {
        if (response.data!["success"]) {
            if (activeIndex == 1) {

          AppSharedPreferences.saveToken(response.data!['result'][0]['token']);
          AppSharedPreferences.saveId(response.data["result"][0]['id']);
          AppSharedPreferences.saveRole(role);
          print("what is the token  ${AppSharedPreferences.getToken}");
          print("wpppppppppp  ${AppSharedPreferences.getToken}");

         /*  Get.to(ConfrimCode(
        role: 1,
         apiUrl: UrlsApi.verifyUserApi,
         email:"${emailController.text}" ,
          ));*/
           Get.offAll(Navpar(  
                              // role: 1,
                               apiUrl: UrlsApi.homeApi,
                              ));


          logInState(LogInState.succsesful);
            }
          if (activeIndex == 0) {
          AppSharedPreferences.saveToken(response.data!['result'][0]['token']);
          AppSharedPreferences.saveId(response.data["result"][0]['id']);
          AppSharedPreferences.saveRole(role);
          print("what is the token  ${AppSharedPreferences.getToken}");
          print("wpppppppppp  ${AppSharedPreferences.getToken}");

           Get.to(ConfrimCode(
        role: 0,
         apiUrl: UrlsApi.verifyArtistApi,
         email:"${emailController.text}" ,
          ));
           Get.offAll(Navpar(  
                              // role: 0,
                               apiUrl: UrlsApi.homeApi,
                              ));

            logInState(LogInState.error);
          }
        } else {

          message = response.data!["data"];
          Get.snackbar('Error', message!);
        }
      }
    } catch (error) {
      if (error is DioException) {
        message = ErrorApiHandler.getErrorMessage(error);
        Get.snackbar('Error', message!);
      } else {
        message = error.toString();
        logInState(LogInState.error);
        Get.snackbar('Error', message!);
      }
    }

    print('Email: ${emailController.text}');
    print('Password: ${passwordController.text}');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
enum LogInState {
  init,
  succsesful,
  error,
  loading,
}
