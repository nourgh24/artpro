import 'package:untitled5/Services/Helper/error_api_handler.dart';
import 'package:untitled5/Services/Network/dio_api_service.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/login/loginn_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as g;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/utils.dart';

class LoginnController extends g.GetxController {
  DioApiService dioApiService = DioApiService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginnService service = LoginnService();

  Rx<LogInState> logInState = LogInState.init.obs;
  String? message;

  Future loginn({required String apiUrl, required int role}) async {
    try {
      logInState(LogInState.loading);
      Response response = await dioApiService.postData(apiUrl, data: {
        'email': emailController.text,
        'password': passwordController.text
      });
      if (response.data != null && response.statusCode == 200) {
        if (response.data!["success"]) {
          AppSharedPreferences.saveToken(response.data!['result'][0]['token']);
          AppSharedPreferences.saveId(response.data["result"][0]['id']);

          AppSharedPreferences.saveRole(role);
          print("what is the token  ${AppSharedPreferences.getToken}");

          logInState(LogInState.succsesful);
        } else {
          logInState(LogInState.error);

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

    service.loginn(emailController, passwordController);
    // يمكنك هنا إضافة المنطق الخاص بتسجيل الدخول
    print('Email: ${emailController.text}');
    print('Password: ${passwordController.text}');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

////////forgetPassword Firebase
  /*void sendpasswordresetemail(String email)async{
    await _auth.sendPasswordResentEmail(email:email).then((value){
      Get.offAll('/Loginn');
      Get.snackbar("Password Reset email link is been sent", "Success");
    }).catchError((onError)=> Get.snackbar("Error In Email Reset", onError.massage));
    }*/
  /*
    validateEmail(String? email) {//////////////////validation
      if (!GetUtils.isEmail(email ?? '')) {
        return 'Email is not valid';
      }
      return null;
    }

    validatePassword(String? pass) {
      if (GetUtils.isNullOrBlank(pass ?? '') == null) {
        return 'password is not valid';
      }
      return null;
    }
    Future onLogin() async {
      if (formKey.currentState!.validate()) {
        Get.snackbar('Success', 'Login Successful',
          snackPosition: SnackPosition.BOTTOM,
          colorText: CupertinoColors.secondarySystemGroupedBackground,
          backgroundColor: CupertinoColors.systemGreen,
        );
        return;
      }
      Get.snackbar('Error', 'Login Validation failed',
        snackPosition: SnackPosition.BOTTOM,
        colorText: CupertinoColors.secondarySystemGroupedBackground,
        backgroundColor: CupertinoColors.destructiveRed,
      );
    }*/
}

enum LogInState {
  init,
  succsesful,
  error,
  loading,
}
