import 'dart:developer';
import 'dart:typed_data';

import 'package:equicare/features/my_stable/models/horse_bio_data_model.dart';
import 'package:equicare/features/my_stable/models/horse_details_model.dart';
import 'package:equicare/features/my_stable/models/horse_event_model/horse_event_model.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';
import 'dart:math' as math;
import '../../../common/functions/fun.dart';
import '../../../utils/urls/app_urls.dart';
import '../../auth/presentation/screens/create_account_screen.dart';
import '../../my_calendar/models/event_data_model.dart';
import '../../my_calendar/models/event_types_with_category_model/event_types_with_category_model.dart';
import '../models/my_stable_model.dart';

class MyStableController extends GetxController {
  RxBool isLoading = false.obs;

  List<MyStableModel> myStableList = [];
  List<EventTypesWithCategoryModel> eventTypeListWithCategoryList = [];

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
      // Get.snackbar("Error", "$e");
      showMyDialogWithoutContext(e.toString());
    } finally {
      isLoading.value = false;
      update();
    }
  }

// ==========================================================

  Future<bool?> addAndEditHorse({
    required int? id,
    required String? selectedImage,
    required String horseName,
    required String dateOfBirth,
    required String height,
    required String sex,
    required String brand,
    required String breed,
    required String color,
    required String discipline,
    required String sire,
    required String dam,
    required String microchipNo,
    required String eANumber,
    required String aMFeed,
    required String pMFeed,
    required String weight,
    required String? profileImage,
    required List<String>? removeImagesIds,
    required List<Uint8List> galleryImage,
    required List<Uint8List>? galleryPdfU8,
    required String competitionNo,
    required String note,
  }) async {
    try {
      isLoading.value = true;
      update();
      Map<String, dynamic> data = {
        "name": horseName,
        "date_of_birth": dateOfBirth,
        "height": height,
        "sex": sex,
        "brand": brand,
        "breed": breed,
        "horse_color": color,
        "descipline": discipline,
        "sire": sire,
        "dam": dam,
        "microchip_number": microchipNo,
        "ea_number": eANumber,
        "am_feed": aMFeed,
        "pm_feed": pMFeed,
        "colour": color,
        "weight": weight,
        "notes": note,
      };
      if (id == null && profileImage != null) {
        int fName = math.Random().nextInt(9990);
        var file = {
          "profile": await dio.MultipartFile.fromFile(profileImage,
              filename: "${fName}.png", contentType: MediaType('image', 'png')),
        };
        data.addEntries(file.entries);
      } else {
        data.addAll({"horse_id": id});
      }
      if (removeImagesIds != null) {
        data.addAll({
          "remove_file_ids[]": removeImagesIds,
        });
      }

      if (selectedImage != null && id != null) {
        int fName = math.Random().nextInt(99930);
        var file = {
          "profile": await dio.MultipartFile.fromFile(selectedImage,
              filename: "${fName}.png", contentType: MediaType('image', 'png')),
        };
        data.addEntries(file.entries);
      }

      var u8List = await createUniqueMultipartFiles(galleryImage);
      var u8PdfList = await createUniquePdfMultipartFiles(galleryPdfU8!);
      var files = {"files[]": u8List + u8PdfList};
      data.addEntries(files.entries);
      var formData = dio.FormData.fromMap(data);
      log("message fileList ---> ${u8List}  \n fields  --> ${formData.fields}  || \n  files ---> ${formData.files}");
      var res = await appNetworkClient.createPostRequestWithHeader(
          url: id != null ? updateHorseUrl : addHorseUrl, data: formData);
      if (res.data["status"] == 1) {
        if (id != null) {
          getHorseDetail(horseId: id);
        }
        return true;
      } else {
        throw ["error ===>>> ${res.data["message"]}"];
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
      update();
    }
  }

// ==========================================================

  // Future<bool?> updateHorse({
  //   required String horseName,
  //   required String dateOfBirth,
  //   required String height,
  //   required String sex,
  //   required String brand,
  //   required String breed,
  //   required String color,
  //   required String discipline,
  //   required String sire,
  //   required String dam,
  //   required String microchipNo,
  //   required String eANumber,
  //   required String aMFeed,
  //   required String pMFeed,
  //   required String weight,
  //   required String profileImage,
  //   required List<String> galleryImage,
  //   required String competitionNo,
  // }) async {
  //   try {
  //     isLoading.value = true;
  //     update();
  //     int fName = math.Random().nextInt(9990);
  //     var file = {
  //       "profile": await dio.MultipartFile.fromFile(profileImage,
  //           filename: "${fName}.png", contentType: MediaType('image', 'png')),
  //     };
  //     var files = {"files": await createUniqueMultipartFiles(galleryImage)};
  //     Map<String, dynamic> data = {
  //       "name": horseName,
  //       "date_of_birth": dateOfBirth,
  //       "height": height,
  //       "sex": sex,
  //       "brand": brand,
  //       "breed": breed,
  //       "horse_color": color,
  //       "descipline": discipline,
  //       "sire": sire,
  //       "dam": dam,
  //       "microchip_number": microchipNo,
  //       "ea_number": eANumber,
  //       "am_feed": aMFeed,
  //       "pm_feed": pMFeed,
  //       "weight": weight,
  //       "files": await createUniqueMultipartFiles(galleryImage),
  //     };
  //     data.addEntries(file.entries);
  //     // data.addEntries(files.entries);
  //     var formData = dio.FormData.fromMap(data);
  //     // print("data =======>>>>>  ${formData.fields.toString()}");
  //     var res = await appNetworkClient.createPostRequestWithHeader(
  //         url: up, data: formData);
  //
  //     if (res.data["status"] == 1) {
  //       return true;
  //     } else {
  //       throw ["${res.data["message"]}"];
  //     }
  //   } catch (e) {
  //     rethrow;
  //   } finally {
  //     isLoading.value = false;
  //     update();
  //   }
  // }

  // ==========================================================

  HorseDetailsModel? horseDetails;
  List<HorseBioDataModel> horseBioDataList = [];
  Future<void> getHorseDetail({required int horseId}) async {
    try {
      isLoading.value = true;
      update();
      var res = await appNetworkClient.createPostRequestWithHeader(
          url: horseDetailsUrl, data: {"horse_id": horseId});
      if (res.data["status"] == 1) {
      } else {
        throw ["${res.data["message"]}"];
      }
      var detailsJson = res.data["data"];
      horseDetails = HorseDetailsModel.fromJson(detailsJson);
      addDataInHorseBioList(horseDetails);
    } catch (e) {
      showMyDialogWithoutContext(e.toString());
      // log("getHorseDetaill ---> $e");
      // Get.snackbar("Error", "$e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void addDataInHorseBioList(HorseDetailsModel? horseDetail) {
    /**
      {"icon": appIcons.horseFaceIconSvg, "title": "Age", "info": "13 Years Old"},
    {"icon": appIcons.horseHeightIconSvg, "title": "Height", "info": "15 HH"},
    {"icon": appIcons.horseBrandIconSvg, "title": "Brand", "info": "14654"},
    {"icon": appIcons.horseBrownIconSvg, "title": "Color", "info": "Brown"},
   */

    horseBioDataList = [
      HorseBioDataModel(
          title: "Age",
          icon: appIcons.horseFaceIconSvg,
          info: horseDetail?.dateOfBirth != null
              ? "${DateTime.now().year - int.parse(horseDetail?.dateOfBirth?.split('-')[0] ?? "2023")}"
              : "------"),
      HorseBioDataModel(
          icon: appIcons.horseHeightIconSvg,
          title: "Height",
          info: horseDetail?.height != null
              ? "${horseDetail?.height} HH"
              : '------'),
      HorseBioDataModel(
          icon: appIcons.horseBrandIconSvg,
          title: "Brand",
          info: "${horseDetail?.brand ?? "-------"}"),
      HorseBioDataModel(
          icon: appIcons.horseBrownIconSvg,
          title: "Colour",
          info: "${horseDetail?.colour ?? "-------"}"),
      HorseBioDataModel(
          icon: appIcons.horseDisciplineIconSvg,
          title: "Discipline",
          info: "${horseDetail?.descipline ?? "-------"}"),
      HorseBioDataModel(
          icon: appIcons.horseWeightIconSvg,
          title: "Weight",
          info: "${horseDetail?.weight ?? '-------'}"),
      HorseBioDataModel(
          icon: appIcons.horseSireIconSvg,
          title: "Sire",
          info: "${horseDetail?.sire ?? "-------"}"),
      HorseBioDataModel(
          icon: appIcons.horseDamIconSvg,
          title: "Dam",
          info: "${horseDetail?.dam ?? "-------"}"),
      HorseBioDataModel(
          icon: appIcons.horseMicrochipNumberIconSvg,
          title: "Microchip Number",
          info: "${horseDetail?.microchipNumber ?? "-------"}"),
      HorseBioDataModel(
          icon: appIcons.horseEANumberIconSvg,
          title: "EA(Competition) Number",
          info: "${horseDetail?.eaNumber ?? "-------"}"),
      // HorseBioDataModel(
      //     icon: appIcons.horseCompetitionIconSvg,
      //     title: "Competition No.",
      //     info: "${horseDetail?.eaNumber??'-------'}"),
      // HorseBioDataModel(
      //     icon: null,
      //     title: "",
      //     info: ""),
      HorseBioDataModel(
          icon: appIcons.horseAMFeedIconSvg,
          title: "AM Feed",
          info: "${horseDetail?.amFeed ?? "-------"}"),
      HorseBioDataModel(
          icon: appIcons.horsePMFeedIconSvg,
          title: "PM Feed",
          info: "${horseDetail?.pmFeed ?? '-------'}"),
    ];
  }
// ==========================================================

  Future<bool?> deleteHorse({
    required int horseId,
  }) async {
    try {
      isLoading.value = true;
      update();
      var res = await appNetworkClient.createPostRequestWithHeader(
          url: deleteHorseUrl, data: {"horse_id": horseId});
      if (res.data["status"] == 1) {
        Get.back();
        // Get.snackbar("Success", "Horse deleted successfully.");
        return true;
      } else {
        throw ["${res.data["message"]}"];
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<bool> deleteImageById(
      {required int horseId, required String ids}) async {
    try {
      var res = await appNetworkClient.createPostRequestWithHeader(
          url: deleteImageByIdUrl,
          data: {"remove_file_ids": ids, 'id': horseDetails});
      if (res.statusCode == 200 && res.data['status'] == 1) {
        print('data delete == >> true');
        return true;
      } else {
        print('data delete == >> false');
        return false;
      }
    } catch (e) {
      throw 'error ===>>> $e';
    }
  }

  // ==========================================================

  Future<bool> getEventTypes() async {
    try {
      isLoading.value = true;
      update();

      var res = await appNetworkClient.createGetRequestWithHeader(
          url: getEventTypeUrl);
      if (res.statusCode == 200 && res.data['status'] == 1) {
        var eventTypeJson = res.data["message"] as List;
        eventTypeListWithCategoryList.clear();
        for (var event in eventTypeJson) {
          var eventType = EventTypesWithCategoryModel.fromJson(event);
          eventTypeListWithCategoryList.add(eventType);
          print("ledddd ==>> ${eventTypeListWithCategoryList.length}");
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw 'error ==>> $e';
    } finally {
      isLoading.value = false;
      update();
    }
  }

  int firstTabSelectedIndex = 0;
  int secondTabSelectedIndex = 0;

  List<EventDataModel> horseEventList = [];
  Future<bool> getHorseEventByCategories(
      {required int horseId,
      int? categoriesId,
      required int eventTypeId}) async {
    try {
      isLoading.value = true;
      update();
      var res = await appNetworkClient.createPostRequestWithHeader(
          url: getEventByCategoriesIdUrl,
          data: {
            "horse_id": horseId,
            "category_id": categoriesId,
            "event_type_id": eventTypeId
          });
      if (res.statusCode == 200 && res.data['status'] == 1) {
        // horseEventListModel = HorseEventListModel.fromJson(res.data);
        horseEventList = (res.data['data'] as List)
            .map(
              (e) => EventDataModel.fromJson(e),
            )
            .toList();

        print("data ==>> ${horseEventList.length}");
        update();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw 'error ==>> $e';
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
