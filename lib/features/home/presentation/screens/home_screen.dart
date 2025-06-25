// ignore_for_file: prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equicare/features/auth/presentation/screens/create_account_screen.dart';
import 'package:equicare/repo/app_preferences.dart';
import 'package:equicare/utils/extensions/extensions.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:equicare/common/buttons/app_radio_button.dart';
import 'package:equicare/common/text_field/app_text_field.dart';
import 'package:equicare/common/widgets/app_carousel_widget.dart';
import 'package:equicare/features/home/controllers/home_controller.dart';
import 'package:equicare/features/my_calendar/models/event_data_model.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController controller;

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() {
    controller = Get.put(HomeController());
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        getEventsByDate(date: DateTime.now());
        controller.checkPermission(context: context);
        controller.getMyBirthdayStableList();
      },
    );
  }

  void getEventsByDate({required DateTime date}) {
    DateTime dateT = date;
    var inputDate = "${dateT.year}-${dateT.month}-${dateT.day}";
    DateFormat inputFormat = DateFormat("yyyy-M-d");
    DateTime parsedDate = inputFormat.parse(inputDate);
    DateFormat outputFormat = DateFormat("yyyy-MM-dd");
    String formattedDate = outputFormat.format(parsedDate);
    controller.getAllEventsByDate(
      date: formattedDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.primaryBlueColor,
      body: GestureDetector(
        onTap: () {
          // FocusManager.instance.primaryFocus?.unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.62,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(appImages.splashScreenImageJpg),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: null /* add child content here */,
            ),
            GetBuilder<HomeController>(
              builder: (controller) =>

                  //  controller.isLoading.value
                  //     ? Center(
                  //         child: CircularProgressIndicator(),
                  //       )
                  //     :
                  ModalProgressHUD(
                inAsyncCall: controller.isLoading.value,
                child: SingleChildScrollView(
                  child: HomeScreenWidget(
                    controller: controller,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreenWidget extends StatelessWidget {
  HomeController controller;

  HomeScreenWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          20.h.verticalSpace,
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome,",
                          style: appTextStyles.p14500White,
                        ),
                        Text(
                          controller.userData?.firstName ?? "",
                          style: appTextStyles.p26700
                              .copyWith(color: appColors.white),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(appRouteNames.settingScreen);
                      },
                      child: Icon(
                        Icons.settings,
                        size: 40,
                        color: appColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: AppTextField(
                  hintText: "Search events here...",
                  textEditingController: controller.searchQueryController,
                  title: "",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (controller.searchQueryController.text.isNotEmpty) {
                        Get.toNamed(appRouteNames.searchEventScreen);
                      } else {
                        myAlertDialog(
                            message: 'Please Enter Something',
                            context: context);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        right: 7,
                        top: 7,
                        bottom: 7,
                      ),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: appColors.primaryBlueColor,
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      width: 50,
                      child: SvgPicture.asset(
                        appIcons.searchIconSvg,
                      ),
                    ),
                  ),
                ),
              ),
              10.h.verticalSpace,
              // ================================================================================
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w)
                        .copyWith(top: 50.h),
                    margin: EdgeInsets.only(top: 80.h),
                    decoration: BoxDecoration(
                        color: appColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(99, 50),
                          topRight: Radius.elliptical(99, 50),
                        )),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        130.verticalSpace,
                        // ================================================================================

                        // 10.h.verticalSpace,
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: [
                        //     AppDotWidget(),
                        //     8.w.horizontalSpace,
                        //     AppDotWidget(
                        //       color: appColors.cE5E7F4,
                        //     ),
                        //   ],
                        // ),
                        // 30.h.verticalSpace,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                " Today's Events",
                                style: appTextStyles.p18500313131,
                              ),
                              Text(
                                controller.eventsByDateList.length.toString() +
                                    " Events ",
                                style: appTextStyles.p14500AEB0C3,
                              ),
                            ],
                          ),
                        ),
                        20.h.verticalSpace,
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.eventsByDateList.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            print(
                                "${controller.eventsByDateList[index].toJson()}");
                            return Slidable(
                              direction: Axis.horizontal,
                              endActionPane: ActionPane(
                                extentRatio: 0.3,
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    padding: EdgeInsets.all(20.w),
                                    spacing: 0,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    onPressed: (context) {
                                      controller.markEventDone(
                                          eventId: controller
                                              .eventsByDateList[index].id
                                              .toString(),
                                          index: index,
                                          date: controller
                                                  .eventsByDateList[index]
                                                  .eventDate ??
                                              "");
                                    },
                                    backgroundColor: appColors.primaryBlueColor,
                                    foregroundColor: Colors.white,
                                    icon: Icons.check_circle,
                                    label: 'Complete',
                                  ),
                                ],
                              ),
                              child: TodaysEventCardWidget(
                                index: index,
                                controller: controller,
                              ),
                            );
                          },
                        ),
                        20.h.verticalSpace,
                        Visibility(
                          visible:
                              controller.completedEventsByDateList.isNotEmpty,
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    " Completed Events",
                                    style: appTextStyles.p18500313131,
                                  ),
                                ),
                                20.h.verticalSpace,
                                Container(
                                  color: Colors.white,
                                  alignment: Alignment.centerLeft,
                                  height: 200,
                                  child: CompletedEventsListWidget(
                                    controller: controller,
                                  ),
                                ),
                                20.verticalSpace
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              appIcons.horseHeartIconSvg,
                              color: appColors.primaryBlueColor,
                            ),
                            20.w.horizontalSpace,
                            Text(
                              "EquiCare",
                              style: appTextStyles.p26900
                                  .copyWith(color: appColors.black),
                            ),
                          ],
                        ),
                        20.h.verticalSpace,
                        if (controller.completedEventsByDateList.isEmpty ||
                            controller.eventsByDateList.isEmpty)
                          40.verticalSpace,
                        if (controller.completedEventsByDateList.isEmpty &&
                            controller.eventsByDateList.isEmpty)
                          130.h.verticalSpace,
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppCarouselWidget(
                        homeController: controller,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CompletedEventsListWidget extends StatelessWidget {
  final HomeController controller;

  const CompletedEventsListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.completedEventsByDateList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          EventDataModel data = controller.completedEventsByDateList[index];
          return GestureDetector(
            onTap: () {
              print(
                  "data ==>> ${controller.completedEventsByDateList[index].toJson()}");
              Get.toNamed(appRouteNames.eventDetailsScreen,
                      arguments: controller.completedEventsByDateList[index])
                  ?.then(
                (value) {
                  DateTime parsedDate = DateTime.now();
                  DateFormat outputFormat = DateFormat("yyyy-MM-dd");
                  String formattedDate = outputFormat.format(parsedDate);
                  controller.getAllEventsByDate(
                    date: formattedDate,
                  );
                },
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 15),
              width: MediaQuery.of(context).size.width * 0.55,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 14)
                            .copyWith(top: 14),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: appColors.cF6F6F6,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white70.withOpacity(0.2),
                          // boxShadow: [
                          // BoxShadow(
                          //   color: Color(0xff000000).withOpacity(0.06),
                          //   offset: Offset(6, 6),
                          //   spreadRadius: 0,
                          //   blurRadius: 22,
                          // )
                          // ],
                        ),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(20),
                                //   child: Image.asset(
                                //     appImages.horseImageJpg,
                                //     height: 200,
                                //     width: double.maxFinite,
                                //     fit: BoxFit.fill,
                                //   ),
                                // ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        (data.profileImage?.isNotEmpty ?? false)
                                            ? data.profileImage ?? ""
                                            : "",
                                    height: 110,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) {
                                      return Image.asset(
                                        appImages.horseImageJpg,
                                        height: 110,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                  margin: EdgeInsets.only(bottom: 8, left: 8),
                                  decoration: BoxDecoration(
                                      color: appColors.white,
                                      borderRadius: BorderRadius.circular(99)),
                                  child: Text(data.completedAgo ?? "",
                                      style: appTextStyles.p14400313131
                                          .copyWith(fontSize: 12)),
                                ), 
                              ],
                            ),
                            10.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //
                                Flexible(
                                  child: Text(
                                    data.horseName ?? "Dreamer",
                                    style: appTextStyles.p16500313131.copyWith(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    data.eventTypeName ?? "",
                                    style: appTextStyles.p145001EBlue.copyWith(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            25.h.verticalSpace,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: appColors.primaryBlueColor,
                        borderRadius: BorderRadius.circular(40)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 20,
                        ),
                        10.w.horizontalSpace,
                        Text(
                          "Completed",
                          style: appTextStyles.p14500White,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class TodaysEventCardWidget extends StatelessWidget {
  final HomeController controller;

  final int index;

  const TodaysEventCardWidget(
      {super.key, required this.index, required this.controller});

  @override
  Widget build(BuildContext context) {
    EventDataModel event = controller.eventsByDateList[index];
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8.w,
      ).copyWith(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: appColors.cF6F6F6,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withOpacity(0.06),
            offset: Offset(0, 6),
            spreadRadius: 0,
            blurRadius: 22,
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(appRouteNames.eventDetailsScreen, arguments: event)?.then(
            (value) {
              DateTime dateT = DateTime.now();
              var inputDate = "${dateT.year}-${dateT.month}-${dateT.day}";
              DateFormat inputFormat = DateFormat("yyyy-M-d");
              DateTime parsedDate = inputFormat.parse(inputDate);
              DateFormat outputFormat = DateFormat("yyyy-MM-dd");
              String formattedDate = outputFormat.format(parsedDate);
              controller.getAllEventsByDate(
                date: formattedDate,
              );
            },
          );
        },
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: (event.profileImage?.isNotEmpty ?? false)
                        ? event.profileImage ?? ""
                        : "",
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        appImages.horseImageJpg,
                        width: 90,
                        height: 90,
                      );
                    },
                    height: 90,
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            10.w.horizontalSpace,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          "${event.horseName}",
                          style: appTextStyles.p18500313131,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        // "20 min left",
                        event.eventTimeStatus ?? "",
                        style: appTextStyles.p14500AEB0C3,
                      ),
                    ],
                  ),
                  4.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${event.eventTypeName}",
                        // "Vet",
                        style: appTextStyles.p165001E4475,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: appColors.cADB0C3,
                        size: 15,
                      ),
                    ],
                  ),
                  10.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: appColors.cAEB0C3,
                            ),
                            2.w.horizontalSpace,
                            Text(
                              ((event.startTime?.length ?? 1) > 5)
                                  ? "${event.startTime}".convertToAmPm()
                                  : "${event.startTime}".convertToAmPm(),
                              style: appTextStyles.p14500AEB0C3.copyWith(fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !(event.isCompleted ?? false),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Mark as done",
                              style: appTextStyles.p145001EBlue.copyWith(fontSize: 14),
                            ),
                            6.w.horizontalSpace,
                            AppRadioButton(
                              size: 3.5,
                              isSelected: event.isCompleted,
                              onTap: (p0) {
                                controller.markEventDone(
                                    eventId: event.id.toString() ?? "0",
                                    index: index,
                                    date: event.eventDate ?? '');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/**
 * 
decoration: BoxDecoration(
                  color: appColors.primaryBlueColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
 */
