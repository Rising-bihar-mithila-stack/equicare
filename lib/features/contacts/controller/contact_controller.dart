import 'dart:math' as math;

import 'package:equicare/features/contacts/model/contact_model.dart';
import 'package:equicare/utils/urls/app_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import '../../../repo/network_client.dart';
import 'package:dio/dio.dart' as dio;

class ContactController extends GetxController {
  NetworkClient networkClient = NetworkClient();
  RxBool isLoading = false.obs;
  List<String> categoryList = [];
  List<ContactModel> contactList = [];
  ContactModel singleContact = ContactModel();

  @override
  void onInit() {
    // TODO: implement onInit
    getCategoryList();
    // getAllContacts();
    super.onInit();
  }

  TextEditingController contactNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  Future<bool?> addContact(String? selectedImage) async {
    isLoading.value = true;
    try {

      Map<String, dynamic> data = {
        "full_name": contactNameController.text,
        "phone_no": phoneNumberController.text,
        "email_address": emailAddressController.text,
        "company": companyNameController.text,
        "profession": categoryNameController.text,
        "address": addressController.text
      };
      if(selectedImage != null){
        int fName = math.Random().nextInt(999);
        var file = {
          'profile': await dio.MultipartFile.fromFile(selectedImage,
              filename: "${fName}.png", contentType: MediaType('image', 'png')),
        };
        data.addEntries(file.entries);
      }
      var formData = dio.FormData.fromMap(data);
      var res = await networkClient.createPostRequestWithHeader(
        url: addContactUrl,
        data: formData,
      );
      if (res.statusCode == 200) {
        if (res.data['status'] == 1) {
          // clearTextField();
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

  Future<bool> getAllContacts() async {
    contactList.clear();
    isLoading.value = true;
    try {
      var res =
          await networkClient.createGetRequestWithHeader(url: allContactsUrl);
      if (res.data['status'] == 1) {
        List<dynamic> data = res.data['data'];
        contactList = data
            .map(
              (contactModel) => ContactModel.fromJson(contactModel),
            )
            .toList();
        update();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw 'error =================>>>>>>>>>>>>> $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getSingleContact(int id) async {
    singleContact = ContactModel();
    isLoading.value = true;
    try {
      Map data = {"id": id};
      var res = await networkClient.createPostRequestWithHeader(
        url: viewSingleContactUrl,
        data: data,
      );
      if (res.data['status'] == 1) {
        singleContact = ContactModel.fromJson(res.data['data']);
      }
    } catch (e) {
      throw 'error =================>>>>>>>>>>>>> $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCategoryList() async {
    try {
      categoryList.clear();
      var res = await networkClient.createGetRequestWithHeader(
          url: healthCategoryUrl);
      if (res.statusCode == 200) {
        List data = res.data['data'];
        categoryList = data.map((e) => e['name'] as String).toSet().toList();
      }
    } catch (e) {
      throw 'error  === ????? $e';
    }
  }

  Future<bool> deleteContact(int id) async {
    isLoading.value = true;
    try {
      Map data = {
        "id": id,
      };
      var res = await networkClient.createPostRequestWithHeader(
        url: deleteContactUrl,
        data: data,
      );
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

  Future<bool> updateContact(int id, String? selectedImage) async {
    isLoading.value = true;

    try {
      Map<String, dynamic> data = {
        "id": id,
        "full_name": contactNameController.text,
        "phone_no": phoneNumberController.text,
        "email_address": emailAddressController.text,
        "company": companyNameController.text,
        "profession": categoryNameController.text,
        "address": addressController.text,
      };

      if (selectedImage != null && selectedImage.isNotEmpty) {
        int fName = math.Random().nextInt(999);
        var file = await dio.MultipartFile.fromFile(
          selectedImage,
          filename: "${fName}.png",
          contentType: MediaType('image', 'png'),
        );

        data['profile'] = file;
      }
      var formData = dio.FormData.fromMap(data);
      var res = await networkClient.createPostRequestWithHeader(
        url: addContactUrl,
        data: formData,
      );
      if (res.statusCode == 200 && res.data['status'] == 1) {
        await getSingleContact(id);
        getAllContacts();
        // clearTextField();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
