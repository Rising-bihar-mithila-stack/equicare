import 'dart:developer';
import 'dart:math' as math;
import 'package:equicare/features/my_calendar/controller/calendar_controller.dart';
import 'package:equicare/features/my_stable/models/horse_details_model.dart';
import 'package:equicare/repo/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinput/pinput.dart';
import '../../../common/functions/fun.dart';
import '../../../common/widgets/app_carousel_widget.dart';
import '../../../repo/notification_services.dart';
import '../../../repo/notifications_class.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/urls/app_urls.dart';
import '../../auth/presentation/screens/create_account_screen.dart';
import '../../my_calendar/models/event_data_model.dart';
import '../../my_stable/models/my_stable_model.dart';
import '../../profile/models/profile_model.dart';

class HomeController extends GetxController {
  ProfileModel? userData;
  RxBool isLoading = false.obs;
  List<EventDataModel> eventsByDateList = [];
  List<EventDataModel> completedEventsByDateList = [];
  List<MyStableModel> birthdayHorses = [];
  List<CarouselContainerWidget> birthdayWidget = [];
  List<EventDataModel> searchHealthEventsList  = [];

  @override
  void onInit() {
    // TODO: implement onInit
    getProfile();
    // getMyBirthdayStableList();
    super.onInit();
  }

  Future<void> checkPermission({required BuildContext context}) async {
    try {
      // Map<Permission, PermissionStatus> status = await [
      //   Permission.notification,
      //   // Permission.camera,
      //   // Permission.phone,
      //   // // Permission.storage,
      //   // Permission.location,
      // ].request();
      // MyCustomNotification.getFcmToken();
      // if (await Permission.notification.request().isGranted
      //     // &&
      //     //     await Permission.camera.request().isGranted &&
      //     //     await Permission.phone.request().isGranted &&
      //     //     // await Permission.storage.request().isGranted &&
      //     //     await Permission.location.request().isGranted
      //     ) {
      //   //my custom nofications methods
      //   // MyCustomNotification.getFcmToken();
      //   // MyCustomNotification.getFcmToken();
      //   // MyCustomNotification.getFirebaseMesagingInBackground();
      //   // MyCustomNotification.getFirebaseMesagingInForeground(context);
      //   //get current location

      //   // asif
      //   NotificationServices notificationServices = NotificationServices();
      //   notificationServices.requestNotificationPermission();
      //   notificationServices.forgroundMessage();
      //   notificationServices.firebaseInit(context);
      //   notificationServices.setupInteractMessage(context);
      //   notificationServices.isTokenRefresh();
      // await  notificationServices.getDeviceToken().then((value) {
      //     print('device token $value');
      //     // print(value);
      //   });
      // } else {}
        NotificationServices notificationServices = NotificationServices();
        notificationServices.requestNotificationPermission();
        notificationServices.forgroundMessage();
        notificationServices.firebaseInit(context);
        notificationServices.setupInteractMessage(context);
        notificationServices.isTokenRefresh();
      await  notificationServices.getDeviceToken().then((value) {
          print('device token $value');
          // print(value);
        });
    } catch (e) {
      log("checkPermissionss --->  $e");
    }
  }

  Future<void> getAllEventsByDate({required String date}) async {
    try {
      isLoading.value = true;
      eventsByDateList.clear();
      completedEventsByDateList.clear();
      update();
      var res = await appNetworkClient.createPostRequestWithHeader(
          url: getEventHealthByDateUrl, data: {"date": date});
      var eventsJson = res.data["data"] as List;
      for (var event in eventsJson) {
        var ev = EventDataModel.fromJson(event);
          String? timeStatus = getRemainingTimeOfEvent(
            startTime: ev.startTime ?? "12:25:00",
            endTime: ev.endTime ?? "18:25:00");
        log("timeRem ---> ${timeStatus}");
        ev = ev.copyWith(eventTimeStatus: timeStatus);
        if (ev.isCompleted ?? false) {
          completedEventsByDateList.add(ev);
        } else {
          eventsByDateList.add(ev);
        }
      }
    } catch (e) {
      throw "getAllEventsByDatee $e";
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<bool> getProfile() async {
    isLoading.value = true;
    try {
      var res =
          await appNetworkClient.createGetRequestWithHeader(url: getProfileUrl);
      if (res.data['status'] == 1 && res.statusCode == 200) {
        userData = ProfileModel.fromJson(res.data['user']);
         
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

  Future<bool> deleteEvent(
      {required String eventId, required String? specificDate}) async {
    try {
      isLoading.value = true;
      update();
      var res = await appNetworkClient.createPostRequestWithHeader(
          url: deleteHealthUrl,
          data: {"id": eventId, "specific_date": specificDate});
      if (res.data['status'] == 1 && res.statusCode == 200) {
        deleteFromEventList(id: eventId);
        update(['calendarController']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      showMyDialogWithoutContext(e.toString());
      // Get.snackbar("Error", "$e");
      return false;
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void deleteFromEventList({required String id}){
    CalendarController calCnt = Get.find(tag: "calendarController");
    int ? completedEventIdx ;
    // int ? eventIdx ;
    for(var i=0;i<(calCnt. completedEventList.length??0);i++){
      if( calCnt. completedEventList[i].id.toString()==id){
        completedEventIdx=i;
        break;
      }
    }
    // for(var i=0;i<(eventsByDateList.length??0);i++){
    //   if(eventsByDateList[i].id.toString()==id){
    //     eventIdx=i;
    //     break;
    //   }
    // }
    if(completedEventIdx!=null){
      calCnt.completedEventList.removeAt(completedEventIdx);
    }
    // if(eventIdx!=null){
    //   eventsByDateList.removeAt(eventIdx);
    // }

  }



  Future<void> getMyBirthdayStableList() async {
    try {
      isLoading.value = true;
      birthdayHorses.clear();
      birthdayWidget.clear();
      update();
      var res = await appNetworkClient.createGetRequestWithHeader(
          url: getMyStableUrl);
      List myStableListJson = res.data["data"] as List;
      for (var myStableM in myStableListJson) {
        var myStable = MyStableModel.fromJson(myStableM);
        if(myStable.dateOfBirth != null){
          if (isBirthdayToday(myStable.dateOfBirth ?? "")) {
            birthdayHorses.add(myStable);
          }
        }
      }
      for (var hrse in birthdayHorses) {
        birthdayWidget.add(CarouselContainerWidget(
            imageUrl: hrse.profileImage, name: hrse.name ?? ""));
      }
     } catch (e) {
      showMyDialogWithoutContext(e.toString());
      // Get.snackbar("Error", "$e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> markEventDone(
      {required String eventId, required int? index, required String date}) async {
    try {
      isLoading.value = true;
      update();
      await appNetworkClient.createPostRequestWithHeader(
          url: markAsDoneUrl, data: {'id': eventId, 'date':date});
      if(index!= null){
        eventsByDateList[index].isCompleted = true;
        eventsByDateList[index].completedAgo = 'few seconds ago';
        completedEventsByDateList.add(eventsByDateList[index]);
        eventsByDateList.removeAt(index);
      }
      update();
    } catch (e) {
      showMyDialogWithoutContext(e.toString());
      // print('Error marking event as done: $e');
      // Get.snackbar("Error", "$e");
    } finally {
      isLoading.value = false;
      update();
    }
  }


  TextEditingController searchQueryController = TextEditingController();
  Future<void> searchHealthEvents(
      {required String query}) async {
    try {
      isLoading.value = true;
      update();
      searchHealthEventsList.clear();
      var res = await appNetworkClient.createPostRequestWithHeader(
          url: searchHealthEventsUrl, data: {'search': query});

      var eventsJson = res.data["data"] as List;
      for (var event in eventsJson) {
        var data = EventDataModel.fromJson(event);
        searchHealthEventsList.add(data);
      }
      update();
    } catch (e) {
      showMyDialogWithoutContext(e.toString());
    } finally {
      isLoading.value = false;
      update();
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    searchQueryController.dispose();
    super.dispose();
  }
}

Future<String> getCareTips() async {
  try {
    var res = await appNetworkClient.createGetRequestWithHeader(
        url: getCareTipsOfWeekUrl);

    if (res.statusCode == 200 && res.data['status'] == 1) {
      return res.data['data']['content'];
    } else {
      return 'Share';
    }
  } catch (e) {
    throw "error=======>>>>> $e";
  }
}

bool isBirthdayToday(String dateString) {
  // Define the date format used in the input string
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  // Parse the input string to a DateTime object
  DateTime inputDate = dateFormat.parse(dateString);

  // Get the current date
  DateTime now = DateTime.now();

  // Extract month and day from the input date and current date
  int inputMonth = inputDate.month;
  int inputDay = inputDate.day;
  int currentMonth = now.month;
  int currentDay = now.day;

  // Check if the month and day match
  return inputMonth == currentMonth && inputDay == currentDay;
}

// Future<String> getCareTips() async {
//   try {
//     var data = await FirebaseFirestore.instance
//         .collection('Care_tips')
//         .doc("QjckT6mobx7U3ZlPzEgf")
//         .get();
//     List listOfCares = data.data()?['cares'];
//     int index = math.Random().nextInt(8);
//     var tipsList = listOfCares
//         .map(
//           (e) => e.toString(),
//         )
//         .toList();
//     return tipsList[index];
//   } catch (e) {
//     throw "error=======>>>>> $e";
//   }
//
// }
