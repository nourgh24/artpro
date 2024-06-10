
import 'package:http/http.dart' as http;
import '../../config/server_config.dart';

class LoginnService{
 var url = Uri.parse(SreverConfig.domainNameServer + SreverConfig.login);

  loginn(var emailController, var passwordController ) async{
   var response = await http.post(
    url,
    headers: {
     'Accept': 'application/json',
   },
   body: {
    'email':'emailController',
    'password':'passwordController',
   },
   );
   print(response.statusCode);
  }
}