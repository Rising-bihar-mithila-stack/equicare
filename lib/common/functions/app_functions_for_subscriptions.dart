import 'dart:developer';

import '../../features/profile/models/profile_model.dart';
import '../../repo/app_preferences.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/urls/app_urls.dart';

class AppFunctionForSubscriptions {
  static final AppFunctionForSubscriptions _singleton =
      AppFunctionForSubscriptions._internal();

  factory AppFunctionForSubscriptions() {
    return _singleton;
  }

  AppFunctionForSubscriptions._internal();

  Future<ProfileModel?> getUserProfile() async {
    ProfileModel? profile;
    try {
      var res =
          await appNetworkClient.createGetRequestWithHeader(url: getProfileUrl);
      if (res.data['status'] == 1 && res.statusCode == 200) {
        ProfileModel? userData = ProfileModel.fromJson(res.data['user']);
        if (userData.id != null) {
           profile = userData;
        }
      }
    } catch (e) {
      log("getUserProfile ---> $e");
    }
    return profile;
  }

  Future<bool?> grantOrRevokeFullAccess({bool? isGrant}) async {
    try {
      await appNetworkClient
          .createPostRequestWithHeader(url: grantAccessUrl, data: {
        "has_full_access":  isGrant ?? true,
      });
      return true;
    } catch (e) {
      log("grantFullAccess ---> $e");
    }
  }

  // final eventRef = FirebaseFirestore.instance.collection('Events').doc(userId);
}
