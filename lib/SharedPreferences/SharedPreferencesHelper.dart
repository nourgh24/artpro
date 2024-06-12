import 'SharedPreferencesProvider.dart';

class AppSharedPreferences {
  static SharedPreferencesProvider? sharedPreferencesProvider;
  static init() async {
    sharedPreferencesProvider = await SharedPreferencesProvider.getInstance();
  }

  //token
  static String get getToken =>
      sharedPreferencesProvider!.read("token") ?? '';
  static saveToken(String value) =>
      sharedPreferencesProvider!.save("token", value);
  static bool get hasToken =>
      sharedPreferencesProvider!.contains("token");
  static removeToken() => sharedPreferencesProvider!.remove("token");

  //Role
  static int get getRole =>
      sharedPreferencesProvider!.read("role") ?? -1;
  static saveRole(int value) =>
      sharedPreferencesProvider!.save("role", value);
  static bool get hasRole =>
      sharedPreferencesProvider!.contains("role");
  static removeRole() => sharedPreferencesProvider!.remove("role");


    //userId
  static int get getId =>
      sharedPreferencesProvider!.read("Id") ?? -1;
  static saveId(int value) =>
      sharedPreferencesProvider!.save("Id", value);
  static bool get hasId =>
      sharedPreferencesProvider!.contains("Id");
  static removeId() => sharedPreferencesProvider!.remove("Id");

}
