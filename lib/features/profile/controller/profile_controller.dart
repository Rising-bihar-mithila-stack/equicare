import 'dart:math';

import 'package:equicare/features/home/controllers/home_controller.dart';
import 'package:equicare/features/profile/models/profile_model.dart';
import 'package:equicare/repo/network_client.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';

import '../../../utils/constants/json_constants.dart';
import '../../../utils/urls/app_urls.dart';
import '../../auth/presentation/screens/create_account_screen.dart';
import '../../my_stable/models/my_stable_model.dart';

class ProfileController extends GetxController {
  NetworkClient networkClient = NetworkClient();
  RxBool isLoading = false.obs;
  ProfileModel userData = ProfileModel();
  List<String> countryList = <String>[];
  List<MyStableModel> myStableList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    init();
    super.onInit();
  }

  init()   {
    //  getProfile();
    getCountryList();
  }

  Future<bool> getProfile() async {
    isLoading.value = true;
    try {
      var res =
          await appNetworkClient.createGetRequestWithHeader(url: getProfileUrl);
      if (res.data['status'] == 1 && res.statusCode == 200) {
        HomeController controller = Get.put(HomeController());
        userData = ProfileModel.fromJson(res.data['user']);
        controller.userData = userData;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<bool> updateProfile(
      {required String firstName,
      required String lastName,
      required String dob,
      required String? image,
      required String sex,
      required String country}) async {
    isLoading.value = true;

    Map<String, dynamic> data = {
      "first_name": firstName,
      "last_name": lastName,
      "gender": sex,
      "date_of_birth": dob,
      "country": country,
    };

    if (image != null) {
      int fName = Random().nextInt(999027);
      var file = await dio.MultipartFile.fromFile(
        image,
        filename: "${fName}.png",
        contentType: MediaType('image', 'png'),
      );

      data.addAll({"profile_image": file});
    }
    var formData = dio.FormData.fromMap(data);

    try {
      var res = await appNetworkClient.createPostRequestWithHeader(
          url: updateProfileUrl, data: formData);
      if (res.data['status'] == 1 && res.statusCode == 200) {
        await getProfile();
        // Get.back();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // throw 'error === >>> $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void getCountryList()  {
    try {
      // var res =
      //     await networkClient.createGetRequestWithHeader(url: getCountriesUrl);
      List data = countriesListJsonConstant['data'];
      countryList = data.map((e) => e['value'] as String).toList();
       
    } catch (e) {
      throw 'error  === ????? $e';
    }
  }

  Future<void> updateProfileBgImage({required String bgImage})async {
    isLoading.value = true;
    int fName = Random().nextInt(9999);
    var file = await dio.MultipartFile.fromFile(bgImage, filename: "${fName}.png", contentType: MediaType('image', 'png'), );
    Map<String, dynamic> data = { "background_image": file };
    var formData = dio.FormData.fromMap(data);

    try {
      var res = await appNetworkClient.createPostRequestWithHeader(
          url: updateProfileBgImageUrl, data: formData);
      if (res.data['status'] == 1 && res.statusCode == 200) {
        await getProfile();
      }
    } catch (e) {
      throw 'error === >>> $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getMyStableList() async {
    try {
      isLoading.value = true;
      myStableList.clear();
      update();
      var res = await appNetworkClient.createGetRequestWithHeader(
          url: getMyStableUrl);
      List myStableListJson = res.data["data"] as List;
      for (var myStableM in myStableListJson) {
        var myStable = MyStableModel.fromJson(myStableM);
        myStableList.add(myStable);
      }
    } catch (e) {
      showMyDialogWithoutContext(e.toString());
      // Get.snackbar("Error", "$e");
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
