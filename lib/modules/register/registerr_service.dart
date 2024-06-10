
import 'package:http/http.dart' as http;
import '../../config/server_config.dart';

class RegisterrService{
 var url = Uri.parse(SreverConfig.domainNameServer + SreverConfig.register);

  registerr(var fullnameController, var emailController, var passwordController,var confirmPasswordController ) async{
   var response = await http.post(
    url,
    headers: {
     'Accept': 'application/json',
   },
   body: {
     'name':'fullnameController',
    'email':'emailController',
    'password':'passwordController',
    'confirm password':'confirmPasswordController',
   },
   );
   print(response.statusCode);
  }
}