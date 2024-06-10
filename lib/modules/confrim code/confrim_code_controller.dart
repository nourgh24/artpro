//class ConfrimController extends GetxController{

//}
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/modules/register/registerr_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart'as g;
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../Services/Network/dio_api_service.dart';
import 'package:untitled5/Services/Helper/error_api_handler.dart';
import 'package:untitled5/Services/Network/dio_api_service.dart';

class ComfirmController extends g.GetxController {


  DioApiService dioApiService=DioApiService();
  String? message;
  Rx<ComfirmState> comfirmState=ComfirmState.init.obs;
  Future comfirm({required String otp,required String email}) async {
    try{
      comfirmState(ComfirmState.loading);
      Response response=await dioApiService.postData( UrlsApi.verifyApi,
          data: {'email': email,
            'code':otp });
      if(response.data!=null&&response.statusCode==200){
        comfirmState(ComfirmState.succsesful);
      }
    }catch(error){
      if (error is DioException){
        message=ErrorApiHandler.getErrorMessage(error);
        comfirmState(ComfirmState.error);
      }
      else{
        message=error.toString();
        comfirmState(ComfirmState.error);
      }
    }


  }

  @override
  void dispose() {

    super.dispose();
  }
}
enum ComfirmState{
  init,
  succsesful,
  error,
  loading,
}