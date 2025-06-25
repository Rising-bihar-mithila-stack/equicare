import 'dart:developer';
import 'dart:io';

import 'package:equicare/utils/constants/app_constants.dart';
import 'package:get/get.dart';

import '../../../utils/urls/app_urls.dart';

class SubscriptionController extends GetxController {
  bool isLoading = false;
  Future<String?> useCoupon(
      {required String couponCode,
      required bool redeemTrueOnSubscribe,
      required String? productName}) async {
    try {
      isLoading = true;
      update();
      var data = {
        "coupon_code": couponCode,
        "user": 3, // user Id,
        "device": Platform.isAndroid ? "Android" : "iOS",
        "product": productName ?? "Full Membership",
        "redeem": redeemTrueOnSubscribe,
      };
       var res = await appNetworkClient.createPostRequestWithHeader(
          url: couponUsageUrl, data: data);
          return res.data["data"]["percentage"].toString();
    } catch (e) {
      log("useCouponn ---> $e");
    } finally {
      isLoading = false;
      update();
    }
  }
}
