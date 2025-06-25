import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:dio/dio.dart' as dio;
import 'package:equicare/features/my_calendar/models/event_data_model.dart';
import 'package:equicare/features/my_calendar/models/get_questions_model/get_health_questions_model.dart';
import 'package:equicare/features/my_calendar/models/new/edit_event_modal.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:equicare/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import '../../../common/functions/fun.dart' as fun;
import '../../../common/functions/fun.dart';
import '../../../utils/urls/app_urls.dart';
import '../../auth/presentation/screens/create_account_screen.dart';
import '../../contacts/model/contact_model.dart';
import '../../my_stable/models/my_stable_model.dart';
import '../models/event_types_with_category_model/event_types_with_category_model.dart';
import '../models/new/event_fields_model.dart';

class CalendarController extends GetxController {
  TextEditingController locationController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isMonth = false.obs;
  List<EventTypesWithCategoryModel> eventTypeWithCategoryList = [];
  List<MyStableModel> myStableList = [];
  List<ContactModel> contactList = [];
  List<EventDataModel> eventsByDateList = [];
  List<EventDataModel> completedEventList = [];
  List<int> assignedHorsesForEvent = [];
  RxList eventAvList = [].obs;
  RxList eventMonthAvList = [].obs;
  String mySelectedHorsesName = '';
  EditEventModel data=   EditEventModel();
  Rx<DateTime> monthYear = DateTime.now().obs;
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  List<TextEditingController> listOfTextEditingController = [];



  @override
  onInit(){
    super.onInit();
    // getEventFields(eventTypeId: "${1}",isFromTab: false);
    listOfTextEditingController = [textEditingController1,textEditingController2,textEditingController3];
  }

  Future<void> getAllEventsByDate({required String date}) async {
    try {
      isLoading.value = true;
      eventsByDateList.clear();
      update();

      var res = await appNetworkClient.createPostRequestWithHeader(
          url: getEventHealthByDateUrl, data: {"date": date});
      var eventsJson = res.data["data"] as List;
      // final userId = getUserID(); // Make sure to implement getUserID()
      // if (completedEventIdList.isEmpty) {
      // final eventRef =
      //     FirebaseFirestore.instance.collection('Events').doc(userId);
      //   var completeEventId = await eventRef.get();
      //   Map<String, dynamic> completedEventId =
      //       completeEventId.data() ?? {"events": []};
      //   List completedEventIdListJ = completedEventId["events"];
      //   completedEventIdList = completedEventIdListJ
      //       .map(
      //         (e) => int.parse("$e"),
      //       )
      //       .toList();
      // }
      completedEventList.clear();
      eventsByDateList.clear();
      for (var event in eventsJson) {
        var ev = EventDataModel.fromJson(event);
        // if (completedEventIdList.contains(ev.id)) {
        //   ev = ev.copyWith(isCompleted: true);
        // }
        // if comlete the adsd to complete list othewise eventsByDateList
        String? timeStatus = fun.getRemainingTimeOfEvent(
            startTime: 
            ev.startTime ??
             "12:25:00",
            endTime: 
            ev.endTime ?? 
            "13:25:00");
         ev = ev.copyWith(eventTimeStatus: timeStatus);
        if (ev.isCompleted == true) {
          completedEventList.add(ev);
        } else {
          eventsByDateList.add(ev);
        }
      }
    } catch (e) {
      log("getAllEventsByDatee $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> getEventType() async {
    try {
      isLoading.value = true;
      eventTypeWithCategoryList.clear();
      myStableList.clear();
      contactList.clear();
      update();
      var res = await Future.wait([
        appNetworkClient.createGetRequestWithHeader(url: getEventTypeUrl),
        appNetworkClient.createGetRequestWithHeader(url: getMyStableUrl),
        appNetworkClient.createGetRequestWithHeader(url: allContactsUrl)
      ]);
      var eventTypeJson = res[0].data["message"] as List;
      for (var eventType in eventTypeJson) {
        var eventTy = EventTypesWithCategoryModel.fromJson(eventType);
        eventTypeWithCategoryList.add(eventTy);
      }
      List myStableListJson = res[1].data["data"] as List;
      for (var myStableM in myStableListJson) {
        var myStable = MyStableModel.fromJson(myStableM);
        myStableList.add(myStable);
      }

      List<dynamic> data = res[2].data['data'];
      contactList = data
          .map(
            (contactModel) => ContactModel.fromJson(contactModel),
          )
          .toList();
    } catch (e) {
      log("getEventTypee $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void selectHorse({required int id, required bool val}) {
    mySelectedHorsesName = "";
    int i = 0;
    for (i = 0; i < myStableList.length; i++) {
      if (myStableList[i].id == id) {
        break;
      }
    }
    myStableList[i] = myStableList[i].copyWith(isSelected: val);
    int index = myStableList.indexWhere((model) => model.id == id);
    MyStableModel data = myStableList[index];
    if(val){
      if (index != -1) {
        myStableList.removeAt(index);
        myStableList.insert(0, data);
      }
    }else{
      myStableList.removeAt(index);
      myStableList.add(data);
    }
    assignedHorsesForEvent.clear();
    for (int j = 0; j < myStableList.length; j++) {
      if (myStableList[j].isSelected == true) {
        assignedHorsesForEvent.add(myStableList[j].id ?? 0);
        mySelectedHorsesName += "${myStableList[j].name}, ";
      }
    }
    update(["assignHorse"]);
  }
//
// //
//
// // ba
//   bool isBaFirstTextFieldVisible = false;
//   String bAFirstTextFieldHintText = "";
//   bool isBaSecondTextFieldVisible = false;
//   String bASecondTextFieldHintText = "";
//   bool isBaDropDownVisible = false;
//   List<QuestionBa> bAQuestionsDropdownList = [];
//   String bASelectedOption = "";
//
//   String? editBADropDownTitle;
//
//   String? bAQuestionId;
//
//   // bb
//
//   bool isBbDropdownVisible = false;
//   List<String> bBQuestionsDropdownList = [];
//   String bBSelectedOption = "";
//   String bBFirstTextFieldHintText = "";
//   String bBSecondTextFieldHintText = "";
//
//   // bc
//   bool isBcFirstTextFieldVisible = false;
//   String bCFirstTextFieldHintText = "";
//   bool isBcSecondTextFieldVisible = false;
//   String bCSecondTextFieldHintText = "";
//   bool isBcDropdownVisible = false;
//   List<String> bCQuestionsDropdownList = [];
//   String bCSelectedOption = "";
//
//   // bd
//
//   bool isBdFirstTextFieldVisible = false;
//   String bDFirstTextFieldHintText = "";
//   bool isBdSecondTextFieldVisible = false;
//   String bDSecondTextFieldHintText = "";
//
//   void setTextFieldsAndDropdownToFalse() {
//     isBaFirstTextFieldVisible = false;
//     bAFirstTextFieldHintText = "";
//     isBaSecondTextFieldVisible = false;
//     bASecondTextFieldHintText = "";
//     isBaDropDownVisible = false;
//     bAQuestionsDropdownList = [];
//     bASelectedOption = "";
//     bAQuestionId = null;
//
//     // bb
//
//     isBbDropdownVisible = false;
//     bBQuestionsDropdownList = [];
//     bBSelectedOption = "";
//     bBFirstTextFieldHintText = "";
//     bBSecondTextFieldHintText = "";
//     // bc
//     isBcFirstTextFieldVisible = false;
//     bCFirstTextFieldHintText = "";
//     isBcSecondTextFieldVisible = false;
//     bCSecondTextFieldHintText = "";
//     isBcDropdownVisible = false;
//     bCQuestionsDropdownList = [];
//     bCSelectedOption = "";
//
//     // bd
//
//     isBdFirstTextFieldVisible = false;
//     bDFirstTextFieldHintText = "";
//     isBdSecondTextFieldVisible = false;
//     bDSecondTextFieldHintText = "";
//   }
//
//   Future<void> getHealthQuestion({required int categoryId}) async {
//     try {
//       setTextFieldsAndDropdownToFalse();
//       isLoading.value = true;
//       // eventTypeWithCategoryList.clear();
//       update();
//       // subcategory id
//       var res = await appNetworkClient.createPostRequestWithHeader(
//           url: getHeathQuestionUrl, data: {"category_id": categoryId});
//       var healthQuestionsData = GetHealthQuestionsModel.fromJson(res.data);
//       var healthQuestions = healthQuestionsData.healthQuestions;
//       setQuestionTextFieldAndDropDowns(healthQuestions: healthQuestions);
//     } catch (e) {
//       log("getEventTypee $e");
//       rethrow;
//     } finally {
//       isLoading.value = false;
//       update();
//     }
//   }
//
//   void setQuestionTextFieldAndDropDowns(
//       {required HealthQuestions? healthQuestions}) {
//     // for question_b_a
//     if ((healthQuestions?.questionBA?.isNotEmpty ?? false)) {
//       setBaQuestionId(
//           healthQuestions?.questionBA?.first.bAQuestionId.toString());
//       if (healthQuestions?.questionBA?.length == 1) {
//         // =======================
//         if (healthQuestions?.questionBA?.first.question == "Name/Dose") {
//           log(" textfield ===================== double  ${healthQuestions?.questionBA?.first.question}"); // b_d name/dose
//           isBaFirstTextFieldVisible = true;
//           isBaSecondTextFieldVisible = true;
//           List<String> hintList = ["", ""];
//           if ((healthQuestions?.questionBA?.first.question?.contains("/") ??
//               false)) {
//             hintList =
//                 healthQuestions?.questionBA?.first.question?.split("/") ??
//                     hintList;
//           }
//           bAFirstTextFieldHintText = hintList[0];
//           bASecondTextFieldHintText = hintList[1];
//         } else if (healthQuestions?.questionBA?.first.question ==
//             "Name/Description") {
//           log(" textfield ===================== double  ${healthQuestions?.questionBA?.first.question}");
//           isBaFirstTextFieldVisible = true;
//           isBaSecondTextFieldVisible = true;
//           List<String> hintList = ["", ""];
//           if ((healthQuestions?.questionBA?.first.question?.contains("/") ??
//               false)) {
//             hintList =
//                 healthQuestions?.questionBA?.first.question?.split("/") ??
//                     hintList;
//           }
//           bAFirstTextFieldHintText = hintList[0];
//           bASecondTextFieldHintText = hintList[1];
//         } else if (healthQuestions?.questionBA?.first.question == "Other") {
//           isBaFirstTextFieldVisible = true;
//           isBaSecondTextFieldVisible = true;
//           bAFirstTextFieldHintText = "Name";
//           bASecondTextFieldHintText = "Dose";
//         } else if (healthQuestions?.questionBA?.first.question == "textbox") {
//           isBaFirstTextFieldVisible = true;
//           isBaSecondTextFieldVisible = false;
//           bAFirstTextFieldHintText = "Name";
//         } else {
//           isBaDropDownVisible = true;
//           bAQuestionsDropdownList = healthQuestions?.questionBA ?? [];
//           if (eventForEdit != null) {
//             editBADropDownTitle = healthQuestions?.questionBA?.first.question;
//           }
//         }
//       } else if ((healthQuestions?.questionBA?.length ?? 0) > 1) {
//         bAQuestionsDropdownList = healthQuestions?.questionBA ?? [];
//         if (eventForEdit != null) {
//           // editBADropDownTitle = healthQuestions?.questionBA?.firstWhere(
//           //       (element) {
//           //         return element.bAQuestionId.toString() ==
//           //             eventForEdit?.questionId;
//           //       },
//           //     ).question ??
//           //     "";
//           for (QuestionBa qBA in healthQuestions?.questionBA ?? []) {
//             if (qBA.bAQuestionId.toString() == eventForEdit?.questionId) {
//               editBADropDownTitle = qBA.question;
//               break;
//             }
//           }
//         }
//
//         isBaFirstTextFieldVisible = false;
//         isBaSecondTextFieldVisible = false;
//         isBaDropDownVisible = true;
//       }
//     }
//     // for question  bb
//     if (healthQuestions?.questionBB?.isNotEmpty ?? false) {
//       if (healthQuestions?.questionBB == "Name/Dose") {
//         bBFirstTextFieldHintText = "Name";
//         bBSecondTextFieldHintText = "Dose";
//       } else {
//         isBbDropdownVisible = true;
//         bBQuestionsDropdownList = healthQuestions?.questionBB?.split("/") ?? [];
//       }
//     }
//     // for question  bc
//     if (healthQuestions?.questionBC?.isNotEmpty ?? false) {
//       if (!(healthQuestions?.questionBC?.toLowerCase().contains("yes") ??
//           true)) {
//         isBcFirstTextFieldVisible = true;
//         isBcSecondTextFieldVisible = true;
//         List<String> hintList = ["", ""];
//         hintList = healthQuestions?.questionBC?.split("/") ?? hintList;
//         bCFirstTextFieldHintText = hintList[0];
//         bCSecondTextFieldHintText = hintList[1];
//       } else {
//         isBcDropdownVisible = true;
//         bCQuestionsDropdownList = healthQuestions?.questionBC?.split("/") ?? [];
//       }
//     }
//     // for question  bd
//     if (healthQuestions?.questionBD?.isNotEmpty ?? false) {
//       isBdFirstTextFieldVisible = true;
//       isBdSecondTextFieldVisible = true;
//       List<String> hintList = ["", ""];
//       hintList = healthQuestions?.questionBD?.split("/") ?? hintList;
//       bDFirstTextFieldHintText = hintList[0];
//       bDSecondTextFieldHintText = hintList[1];
//     }
//   }
//
//   void setBaQuestionId(String? id) {
//     bAQuestionId = id;
//   }
//   // add health/ event
//
//   EventDataModel? eventForEdit;
//
//   void setEventForEdit({required EventDataModel? event}) {
//     eventForEdit = event;
//   }

  Map<String, String> frequencyMap = {
  "Never" : "0 day",
  "Daily" : "1 day",
  "Twice a Day (8am &, 5pm)" : "2 times",
  "Three Times a Day (8am, 1pm & 5pm)" : "3 times",
  "Every Second Day" : "2 day",
  "Weekly" : "1 week",
  "Every 2 weeks" : "2 week",
  "Every 3 weeks" : "3 week",
  "Every 4 weeks" : "4 week",
  "Every 5 weeks" : "5 week",
  "Every 6 weeks" : "6 week",
  "Monthly" : "1 month",
  "Every 2 Months" : "2 month",
  "Every 3 Months" : "3 month",
  "Every 4 Months" : "4 month",
  "Every 5 Months" : "5 month",
  "Every 6 Months" : "6 month",
  "Once a Year" : "1 year"
  };

  // Future<bool?> addEditEvent({
  //   required String? id,
  //   required String? isUpdateAllZeroOne,
  //   required List<int>? horseId,
  //   required String? contactId,
  //   required String? location,
  //   required String? categoryId,
  //   required String? bAQuestionId,
  //   required String? questionBA,
  //   required String? questionBB,
  //   required String? questionBC,
  //   required String? questionBD,
  //   required String? startDate,
  //   required String? startTime,
  //   required String? endTime,
  //   required String? repeat,
  //   required String? alert,
  //   required String? notes,
  //   required String? eventTypeId,
  //   required String? endDate,
  //   required String? specificDate,
  //   required List<Uint8List>? galleryImage,
  //   required List<Uint8List>? galleryPdfU8,
  //   required List<String>? removeFileIds,
  // }) async {
  //   try {
  //     isLoading.value = true;
  //     update();
  //     print("jhvvhjvjhvhjjvh ==>> ${frequencyMap[repeat]}");
  //     Map<String, dynamic> data = {
  //       "contact": contactId,
  //       "location": location,
  //       "category_id": categoryId,
  //       "question_id": bAQuestionId,
  //       "question_b_a": questionBA,
  //       "question_b_b": questionBB,
  //       "question_b_c": questionBC,
  //       "question_b_d": questionBD,
  //       "start_time": startTime,
  //       "start_date": startDate?.convertDateFormatToYYYYMMDD(),
  //       "end_time": endTime,
  //       "end_date": endDate?.convertDateFormatToYYYYMMDD(),
  //       "repeat": repeat != null ?frequencyMap[repeat]:frequencyMap['Never'],
  //           // frequencyMap.containsValue(repeat) ? repeat : frequencyMap[repeat],
  //       "alert": alert,
  //       "notes": notes,
  //       "event_type_id": eventTypeId,
  //     };
  //     print('data===>> $data');
  //     if (id != null) {
  //       var idF = {
  //         "id": id,
  //         "update_all": isUpdateAllZeroOne,
  //         "horse_id": horseId?.first
  //       };
  //       data.addAll(idF);
  //     } else {
  //       data.addAll({"horse_id[]": horseId});
  //     }
  //     if (removeFileIds != null) {
  //       data.addAll({
  //         "remove_file_ids[]": removeFileIds,
  //       });
  //     }
  //     if (specificDate != null) {
  //       data.addAll({
  //         "specific_date": specificDate,
  //       });
  //     }
  //
  //     var u8PdfList = await createUniquePdfMultipartFiles(galleryPdfU8!);
  //
  //     u8PdfList.forEach((element) => print(" === ${element.filename.toString()}"),);
  //     if (galleryImage != null) {
  //       var u8List = await createUniqueMultipartFiles(galleryImage);
  //       data.addAll({"files[]": u8List+u8PdfList});
  //     }
  //
  //     var formData = dio.FormData.fromMap(data);
  //
  //
  //     await appNetworkClient.createPostRequestWithHeader(
  //         url: id != null ? updateHealthUrl : addEventHealthUrl,
  //         data: formData);
  //     return true;
  //   } catch (e) {
  //     // Get.snackbar("Error", "$e");
  //     // showMyDialogWithoutContext(e.toString());
  //     rethrow;
  //   } finally {
  //     isLoading.value = false;
  //     update();
  //   }
  // }

// edit heath/ event

  Future<void> deleteEvent(
      {required String eventId,
      required int index,
      required String? specificDate}) async {
    try {
      isLoading.value = true;
      update();
      var res = await appNetworkClient.createPostRequestWithHeader(
          url: deleteHealthUrl,
          data: {"id": eventId, "specific_date": specificDate});
      eventsByDateList.removeAt(index);
    } catch (e) {
      showMyDialogWithoutContext(e.toString());
      // log("deleteEventt ---> $e");
      // Get.snackbar("Error", "$e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> markEventDone(
      {required String eventId, required int index, required String date }) async {
    try {
      isLoading.value = true;
      update();
      var res = await appNetworkClient.createPostRequestWithHeader(
          url: markAsDoneUrl, data: {'id': eventId,'date':date });
      eventsByDateList[index].isCompleted = true;
      completedEventList.add(eventsByDateList[index]);
      eventsByDateList.remove(eventsByDateList[index]);

      update();
      // final userId = getUserID(); // Make sure to implement getUserID()
      // final eventRef =
      //     FirebaseFirestore.instance.collection('Events').doc(userId);
      // final data = {
      //   'events': FieldValue.arrayUnion([eventId])
      // };

      // await eventRef.set(data, SetOptions(merge: true));
      // eventsByDateList[index] =
      //     eventsByDateList[index].copyWith(isCompleted: true);
      // print('Marked event as done: $eventId for user: $userId');
    } catch (e) {
      print('Error marking event as done: $e');
      // Get.snackbar("Error", "$e");
      showMyDialogWithoutContext(e.toString());
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> getHealthEventAv(
      {required List<String> calenderDateList}) async {
    try {
      isLoading.value =true;
      eventAvList.clear();
      var res = await appNetworkClient.createPostRequestWithHeader(url: getHealthEventAvUrl, data: {'dates': calenderDateList});
      Map data = res.data['data'];
      List d = [];
      data.forEach((key, value) { d.add(value); },);
      eventAvList.assignAll(d);
    } catch (e) {
      showMyDialogWithoutContext(e.toString());
    }finally{
      isLoading.value =false;
    }
  }

  Future<void> getMonthHealthEventAv(
      {required List<String> calenderDateList}) async {
    try {
      isLoading.value = true;
      var res = await appNetworkClient.createPostRequestWithHeader(url: getHealthEventAvUrl, data: {'dates': calenderDateList});
      Map data = res.data['data'];
      List d = [];
      data.forEach((key, value) { d.add(value); },);
      d.addAll([false,false,false]);
      eventMonthAvList.assignAll(d);
      print('length ==>>2 ${eventMonthAvList.length}');
    } catch (e) {
      showMyDialogWithoutContext(e.toString());
    }finally{
      isLoading.value =false;
    }
  }






  //=================================================handel dynamic boxes====================================================================

  List<EventFieldsModel> listOfEventTypes = [];
  List<EventFieldsModel> listOfTextFormField = [];
  List<EventFieldsModel> radioButtonList = [];
  List<EventFieldsModel> childFields1 = [];
  List<EventFieldsModel> childFields2 = [];
  List<EventFieldsModel> childFields3 = [];
  String? selectedRadioOption;
  List<String> selectedValues = [];
  String? selectedEventHealth;
  String? selectedChildValue1;
  String? selectedChildValue2;
  String? selectedChildValue3;
  Future<void> getEventFields({required String eventTypeId, String? fieldId, String? fieldValue, required bool isFromTab}) async {
    try {
      isLoading.value = true;
      update();

      Map<String, dynamic> value = {
        "event_type_id": eventTypeId,
        "fieldId": fieldId,
        "fieldValue": fieldValue,
      };

      var res = await appNetworkClient.createGetRequestWithHeader(url: getEventFieldsUrl, data: value);
      List<dynamic> apiData = res.data['data'];
      List<EventFieldsModel> data = [];
      for (var element in apiData) {
        data.add(EventFieldsModel.fromJson(element));
      }

      if(isFromTab){
        listOfTextFormField.clear();
        childFields1.clear();
        listOfEventTypes.clear();
        radioButtonList.clear();
        selectedRadioOption =null;
      }

      if(data.last.type=="select"){
        listOfEventTypes.assignAll(data);
      }
      else{
        listOfTextFormField.assignAll(data);
      }




    } catch (e) {
      // showMyDialogWithoutContext(e.toString());
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> getEventFieldsChild1({required String eventTypeId, String? fieldId, String? fieldValue}) async {
    try {
      isLoading.value = true;
      update();

      Map<String, dynamic> value = {
        "event_type_id": eventTypeId,
        "fieldId": fieldId,
        "fieldValue": fieldValue,
      };

      var res = await appNetworkClient.createGetRequestWithHeader(url: getEventFieldsUrl, data: value);
      List<dynamic> apiData = res.data['data'];
      List<EventFieldsModel> data = [];
      for (var element in apiData) {
        data.add(EventFieldsModel.fromJson(element));
      }

     childFields1.clear();
      childFields2.clear();
      childFields3.clear();
      listOfTextFormField.clear();
      selectedChildValue1 = null;
      selectedRadioOption=null;
      radioButtonList.clear();
      // Update the child fields
      if(data.last.type=="select"){
        childFields1.addAll(data);
      }
      else if(data.last.type=="radio"){
        radioButtonList.assignAll(data);
      }
      else{
        listOfTextFormField.assignAll(data);
      }


    } catch (e) {
      // showMyDialogWithoutContext(e.toString());
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> getEventFieldsChild2({required String eventTypeId, String? fieldId, String? fieldValue}) async {
    try {
      isLoading.value = true;
      update();

      Map<String, dynamic> value = {
        "event_type_id": eventTypeId,
        "fieldId": fieldId,
        "fieldValue": fieldValue,
      };

      var res = await appNetworkClient.createGetRequestWithHeader(url: getEventFieldsUrl, data: value);
      List<dynamic> apiData = res.data['data'];
      List<EventFieldsModel> data = [];
      for (var element in apiData) {
        data.add(EventFieldsModel.fromJson(element));
      }
      listOfTextFormField.clear();
      childFields2.clear();
      childFields3.clear();

      // Update the child fields




      if(data.last.type=="select"){
        childFields2.addAll(data);
      }
      else if(data.last.type=="radio"){
        radioButtonList.assignAll(data);
      }
      else{
        listOfTextFormField.assignAll(data);
        print('skhjdcvb');
      }

    } catch (e) {
      // showMyDialogWithoutContext(e.toString());
    } finally {
      isLoading.value = false;
      update();
    }
  }

  //=====================================================================================================================
  // =================================add event method=================================================
  //====================================================================================================================


  List<Map<String, dynamic>> buildFieldsData() {
    List<Map<String, dynamic>> fieldsData = [];

    // Add event types (Parent dropdowns)
    _addFieldsData(listOfEventTypes, selectedEventHealth, fieldsData);

    // Add child fields at different levels
    _addFieldsData(childFields1, selectedChildValue1, fieldsData);
    _addFieldsData(childFields2, selectedChildValue2, fieldsData);
    _addFieldsData(childFields3, selectedChildValue3, fieldsData);

    // Collect radio button selections
    if (selectedRadioOption != null) {
      for (var radioField in radioButtonList) {
        print("1");
        if (radioField.type == 'radio') {
          fieldsData.add({
            "id": radioField.id,
            "value": selectedRadioOption,
            // "fields": [] // Assuming no nested fields for radio buttons
          });
        }
      }
    }

    // Collect text fields
    //
    // for(int i=0;i<listOfTextFormField.length;i++){
    //
    // }
    //
    // for (var textField in listOfTextFormField) {
    for(int i=0;i<listOfTextFormField.length;i++){
      print("2");
      fieldsData.add({
        "id": listOfTextFormField[i].id,
        "value": listOfTextEditingController[i].text, // Assuming the text field stores its value in 'label'
        // "fields": []
      });
    }

    return fieldsData;
  }

  /// Utility method to handle field data for both parent and child fields
  void _addFieldsData(List<EventFieldsModel> fieldsList, String? selectedValue, List<Map<String, dynamic>> fieldsData) {
    for (var field in fieldsList) {
      print("3");
      // Only process fields with type 'select' and a selected value
      if (field.type == 'select' && selectedValue != null) {
        Map<String, dynamic> parentField = {
          "id": field.id,
          "value": selectedValue,
          // "fields": _buildNestedFields(field) // Handle nested fields if present
        };

        // Add parent field along with its nested fields to the fieldsData
        fieldsData.add(parentField);
      }
    }
  }

  /// Recursive method to build nested fields for any parent field
  // List<Map<String, dynamic>> _buildNestedFields(EventFieldsModel parentField) {
  //   List<Map<String, dynamic>> nestedFields = [];
  //
  //   // Check if parentField has any values (i.e., child fields)
  //   if (parentField.values != null) {
  //     for (var value in parentField.values!) {
  //       if (value == selectedValues) { // Assuming selectedValues contains the current selection of nested fields
  //         print("4");
  //         nestedFields.add({
  //           "id": parentField.id, // Assuming nested fields use the parentField id
  //           "value": value,       // The nested value itself (from parentField.values)
  //           // "fields": []          // Assuming no deeper nested fields
  //         });
  //       }
  //     }
  //   }
  //
  //   return nestedFields;
  // }

  // printData() {
  //   List<Map<String, dynamic>> data = buildFieldsData();
  //   print("ListOfObject==>> $data");
  // }



  Future<bool?> addEditEvent({
  required String? id,
  required String? isUpdateAllZeroOne,
  required List<int>? horseId,
  required String? contactId,
  required String? location,
  required String? categoryId,
  required String? startDate,
  required String? startTime,
  required String? endTime,
  required String? repeat,
  required String? alert,
  required String? notes,
  required String? eventTypeId,
  required String? endDate,
  required String? specificDate,
  required List<Uint8List>? galleryImage,
  required List<Uint8List>? galleryPdfU8,
  required List<String>? removeFileIds,
}) async {
  try {
    List<Map<String, dynamic>> datawerfcs=  buildFieldsData();
    isLoading.value = true;
    update();

    //=================================

    Map<String, dynamic> data = {
      "contact": contactId,
      "location": location,
      "category_id": categoryId,
      "start_time": startTime,
      "start_date": startDate?.convertDateFormatToYYYYMMDD(),
      "end_time": endTime,
      "end_date": endDate?.convertDateFormatToYYYYMMDD(),
      "repeat": repeat != null ?frequencyMap[repeat]:frequencyMap['Never'],
      "fieldsData":jsonEncode(buildFieldsData()),
          // frequencyMap.containsValue(repeat) ? repeat : frequencyMap[repeat],
      "alert": alert,
      "notes": notes,
      "event_type_id": eventTypeId,
    };
    print('data===>> $data');
    if (id != null) {
      var idF = {
        "id": id,
        "update_all": isUpdateAllZeroOne,
        "horse_id": horseId?.first
      };
      data.addAll(idF);
    } else {
      data.addAll({"horse_id[]": horseId});
    }
    if (removeFileIds != null) {
      data.addAll({
        "remove_file_ids[]": removeFileIds,
      });
    }
    if (specificDate != null) {
      data.addAll({
        "specific_date": specificDate,
      });
    }

    var u8PdfList = await createUniquePdfMultipartFiles(galleryPdfU8!);

    u8PdfList.forEach((element) => print(" === ${element.filename.toString()}"),);
    if (galleryImage != null) {
      var u8List = await createUniqueMultipartFiles(galleryImage);
      data.addAll({"files[]": u8List+u8PdfList});
    }

    var formData = dio.FormData.fromMap(data);


    // await appNetworkClient.createPostRequestWithHeader(
    //     url: id != null ? updateHealthUrl : addEventHealthUrl,
    //     data: formData);
    // return true;
   } catch (e) {
    // Get.snackbar("Error", "$e");
    showMyDialogWithoutContext(e.toString());
    rethrow;
  } finally {
    isLoading.value = false;
    update();
  }
}



// =================================================================

Future<void> getEventForEdit({required String eventId}) async {
    try {
      isLoading.value = true;
      update();
      Map<String, dynamic> value = {
        "health_id": eventId.toString()
      };

      var res = await appNetworkClient.createGetRequestWithHeader(url: getEventForEditUrl, data: value);
      dynamic apiData = res.data['data'];
      data = EditEventModel.fromJson(apiData);

      update();
      // return data;
    } catch (e) {
      showMyDialogWithoutContext(e.toString());
    } finally {
      isLoading.value = false;
      update();
    }
  }
  clearData(){
    print("clear==>>");
   listOfEventTypes = [];
    listOfTextFormField = [];
    listOfTextEditingController[0].clear();
    listOfTextEditingController[1].clear();
    listOfTextEditingController[2].clear();
    radioButtonList = [];
    childFields1 = [];
    childFields2 = [];
    childFields3 = [];
   selectedRadioOption = null;
    selectedValues = [];
    selectedEventHealth =null;
    selectedChildValue1 =null;
    selectedChildValue2 =null;
    selectedChildValue3 =null;
  }

  clearlisttext(){
    listOfTextEditingController[0].clear();
   listOfTextEditingController[1].clear();
    listOfTextEditingController[2].clear();
  }
}
