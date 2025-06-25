import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:equicare/features/auth/models/country_model.dart';
import 'package:equicare/repo/app_preferences.dart';
import 'package:equicare/repo/network_client.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:equicare/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart' as dio;
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../../repo/notification_services.dart';
import '../../../utils/constants/json_constants.dart';
import '../../../utils/urls/app_urls.dart';
import '../../profile/models/profile_model.dart';

class AuthController extends GetxController {
  NetworkClient networkClient = NetworkClient();
  AppPreferences appPreferences = AppPreferences();
  RxBool isLoading = false.obs;
  String selectedImage = '';
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController forgotEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController newConfirmPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  String countryController = '';
  // String timeZoneController = '';
  String otpSentId = '';
  String sexController = '';
  List<CountryModel> countryList = [];
  // List<CountryModel> timeZoneList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    getCountryList();
    super.onInit();
  }

  Future<bool> createAccount() async {
    isLoading.value = true;
    try {
      appPreferences.deleteToken();
      Map<String, dynamic> data = {
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "gender": sexController.isEmpty ? null : sexController,
        "country": countryController,
        // "timezone": timeZoneController,
        "date_of_birth": dateController.text.convertDateFormatToYYYYMMDD(),
      };
      if (invitationIdConstant != null) {
        data.addAll({"invitationId": invitationIdConstant});
        isUserSubUserConstant = true;
        appPreferences.setIsSubUser(true);
      }

      if (selectedImage.isNotEmpty) {
        int fName = math.Random().nextInt(999027);
        var file = await dio.MultipartFile.fromFile(
          selectedImage,
          filename: "${fName}.png",
          contentType: MediaType('image', 'png'),
        );
        data.addAll({"profile_image": file});
      }
      log("createAccountt ---> $data");
      var formData = dio.FormData.fromMap(data);
      var res = await networkClient.createPostRequestWithHeader(
          url: createUserUrl, data: formData);
      if (res.data['status'] == 1) {
        if (res.data is Map) {
          Map resM = res.data;
          if (resM.containsKey("access_token")) {
            await appPreferences.setToken(res.data["access_token"]);
          }
          Purchases.setEmail(emailController.text.trim());
          Purchases.setDisplayName(
              "${firstNameController.text.trim()} ${lastNameController.text.trim()}");
          revenueCatConfigurationConstant?.appUserID = "${res.data["user_id"]}";
        }
        return true;
      } else {
        log("formData ---> ${formData.fields}");
        return false;
      }
    } catch (e) {
      // throw 'error ====== >>>> $e';
      // Get.snackbar(
      //   "Error",
      //   "$e",
      // );
      //
      // Get.dialog(Text('data'));
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> loginAccount() async {
    isLoading.value = true;
    try {
      Map data = {
        "email": loginEmailController.text,
        "password": loginPasswordController.text,
        // "fcm_token": "kjhg",
        "fcm_token": await NotificationServices().getDeviceToken(),
        "device_type": Platform.isAndroid ? "Android" : "iOS",
        "device_id": "device_id",
        // "timezone": "timezone"
      };

      var res = await networkClient.createPostRequestWithoutHeader(
          url: loginUserUrl, data: data);
      if (res.statusCode == 200) {
        if (res.data['status'] == 1) {
          await appPreferences.setToken(res.data["access_token"]);
          var user = await getProfile();
          bool? isSubUser = user?.role?.contains("sub");
          isUserSubUserConstant = isSubUser;
          appPreferences.setIsSubUser(isSubUser);
          revenueCatConfigurationConstant?.appUserID = user?.id.toString();
          Purchases.setEmail(user?.email ?? emailController.text.trim());
          Purchases.setDisplayName(
              // "${firstNameController.text.trim()} ${lastNameController.text.trim()}",
              "${user?.firstName} ${user?.lastName}");
          if (user?.hasFullAccess == true) {
            isUserHaveActiveSubscriptionConstant = true;
          }
          return true;
        } else {
          throw res.data["message"];
        }
      } else {
        return false;
      }
    } catch (e) {
      log("loginAccountt ---> $e");
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<ProfileModel?> getProfile() async {
    ProfileModel? userData;
    try {
      var res =
          await appNetworkClient.createGetRequestWithHeader(url: getProfileUrl);
      if (res.data['status'] == 1 && res.statusCode == 200) {
        userData = ProfileModel.fromJson(res.data['user']);
      }
    } catch (e) {
      log(" $e");
    } finally {}
    return userData;
  }

  void getCountryList() {
    // isLoading.value = true;
    try {
      // var res =
      //     await networkClient.createGetRequestWithHeader(url: getCountriesUrl);
      List data = countriesListJsonConstant['data'];
      var countryModelList = data.map((e) => CountryModel.fromJson(e)).toList();
      countryModelList.forEach(
        (element) {
          countryList.add(element);
        },
      );
      // isLoading.value = false;
      update();
    } catch (e) {
      throw 'error  === ????? $e';
    }
  }

  // Future<void> getCountryTimeZoneById(int id) async {
  //   isLoading.value = true;
  //   try {
  //     var res = await networkClient.createGetRequestWithHeader(
  //         url: "${baseUrl}country/$id/timezones");
  //     List data = res.data['data'];
  //     var countryModelList = data.map((e) => CountryModel.fromJson(e)).toList();
  //     for (var element in countryModelList) {
  //       timeZoneList.add(element);
  //     }
  //     isLoading.value = false;
  //     update();
  //   } catch (e) {
  //     throw 'error  === ????? $e';
  //   }
  // }

  Future<bool> forgotPassword() async {
    isLoading.value = true;
    try {
      Map data = {
        "email": forgotEmailController.text,
      };
      var res = await networkClient.createPostRequestWithHeader(
          url: forgotPasswordUrl, data: data);
      if (res.statusCode == 200) {
        if (res.data['status'] == 1) {
          otpSentId = res.data['id'].toString();
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> verifyOTP() async {
    isLoading.value = true;
    try {
      Map data = {
        "id": otpSentId,
        "otp": otpController.text,
      };
      var res = await networkClient.createPostRequestWithHeader(
          url: verifyOtpUrl, data: data);
      if (res.statusCode == 200) {
        if (res.data['status'] == 1) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> changePassword() async {
    isLoading.value = true;
    try {
      Map data = {
        "id": otpSentId,
        "password": newPasswordController.text,
      };
      var res = await networkClient.createPostRequestWithHeader(
          url: changePasswordUrl, data: data);
      if (res.statusCode == 200) {
        if (res.data['status'] == 1) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> isEmailAllReadExist()async{

    try {
      isLoading.value = true;
      update(['authController'],);
      Map data = {"email": emailController.text};
      var res = await networkClient.createPostRequestWithHeader(url: checkEmailExistUrl, data: data);
      // if (res.statusCode == 200 && res.data['status'] == 1) {
        return res.data['isExists'];
      // } else {
      //   emailController.clear();
      //   return res.data['isExists'];
      // }
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
      update(['authController']);
    }
  }

  clearTextField() {
    // isLoading = false.obs;
    // selectedImage = '';
    // loginEmailController.clear();
    // loginPasswordController.clear();
    // emailController.clear(); 
    // forgotEmailController.clear();
    // passwordController.clear(); 
    // firstNameController.clear();
    // lastNameController.clear();
    // dateController.clear();
    // otpController.clear();
    // newConfirmPasswordController.clear();
    // newPasswordController.clear();
    // countryController = '';
    // otpSentId = '';
    // sexController = '';
  }
}
