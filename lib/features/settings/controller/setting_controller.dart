import 'dart:io';

import 'package:equicare/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../../repo/app_preferences.dart';
import '../../../utils/urls/app_urls.dart';

class SettingController extends GetxController {
  RxBool isLoading = false.obs;

  Future<bool> logoutAccount() async {
    try {
      isLoading.value = true;
      var data = {
        "device_type": Platform.isAndroid ? "Android" : "IOS",
        "device_id": "459f94f95ab276c4",
      };
      var res = await appNetworkClient.createPostRequestWithHeader(
          url: logoutAccountUrl, data: data);
      if (res.data['status'] == 1 && res.statusCode == 200) {
        AppPreferences().deleteToken();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw 'error ==>> $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      isLoading.value = true;
      var data = {
        "old_password": oldPassword,
        "password": newPassword,
      };
      var formData = dio.FormData.fromMap(data);
      var res = await appNetworkClient.createPostRequestWithHeader(
          url: updatePasswordUrl, data: formData);
      if (res.data['status'] == 1 && res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
      throw 'error ==>> $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteAccount() async {
    try {
      isLoading.value = true;
      var res = await appNetworkClient.createGetRequestWithHeader(
          url: deleteAccountUrl);
      if (res.data['status'] == 1 && res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
