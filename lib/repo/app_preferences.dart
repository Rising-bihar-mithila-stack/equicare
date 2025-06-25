import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants/app_constants.dart';

class AppPreferences {
  static final AppPreferences _singleton = AppPreferences._internal();

  factory AppPreferences() {
    return _singleton;
  }

  AppPreferences._internal();

  Future<void> setToken(String token) async {
    var pref = await SharedPreferences.getInstance();
    authToken = token;
    await pref.setString("token", token);
  }

  Future<String?> getToken() async {
    var pref = await SharedPreferences.getInstance();
    authToken = pref.getString("token");
    return authToken;
  }

  Future<void> deleteToken() async {
    var pref = await SharedPreferences.getInstance();
    await deleteIsSubUser();
    await pref.remove("token");
  }


  // Future<void> setUserId(String userId) async {
  //   var pref = await SharedPreferences.getInstance();
  //   await pref.setString("useId", userId);
  // }

  // Future<String?> getUserId() async {
  //   var pref = await SharedPreferences.getInstance();
  //   return pref.getString("useId");
  // }

  // Future<void> deleteUserId() async {
  //   var pref = await SharedPreferences.getInstance();
  //   await pref.remove("useId");
  // }

  // 
    Future<void> setIsSubUser(bool ?  val) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setBool("isSubUser", val ?? false);
  }

  Future<bool?> getIsSubUser() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool("isSubUser");
  }

  Future<void> deleteIsSubUser() async {
    var pref = await SharedPreferences.getInstance();
    await pref.remove("isSubUser");
  }
  // 
    Future<void> setIsNotification(bool ?  val) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setBool("isNotification", val ?? false);
  }

  Future<bool?> getIsNotification() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool("isNotification");
  }

  Future<void> deleteIsNotification() async {
    var pref = await SharedPreferences.getInstance();
    await pref.remove("isNotification");
  }


}
