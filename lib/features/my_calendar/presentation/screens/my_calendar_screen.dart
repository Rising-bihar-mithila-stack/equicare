import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:equicare/features/auth/presentation/screens/create_account_screen.dart';
import 'package:equicare/features/my_calendar/controller/calendar_controller.dart';
import 'package:equicare/features/profile/presentation/widgets/profile_picture_widget.dart';
import 'package:equicare/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../common/buttons/app_radio_button.dart';
import '../../../../common/shadows/app_appbar_shadow_widget.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../models/event_data_model.dart';

class MyCalendarScreen extends StatefulWidget {
  const MyCalendarScreen({super.key});

  @override
  State<MyCalendarScreen> createState() => _MyCalendarScreenState();
}

class _MyCalendarScreenState extends State<MyCalendarScreen> {
  late CalendarController calendarController;
  DateTime focusedDate = DateTime.now();
  List<String> visibleDateList = [];
  List<String> visibleMonthDateList = [];
  String? openCalenderDate;

  @override
  void initState() {
    // TODO: implement initState
    init();

    getVisibleDays(focusedDate);
    getVisibleMonthDays(focusedDate);
    calendarController.monthYear.value =
        focusedDate;
//
    super.initState();
  }

  void init() {
    // await Future.wait([
    // getVisibleDays(focusedDate),
    //    getVisibleMonthDays(focusedDate),
    // ]);
    calendarController = Get.put(CalendarController(),
        tag: "calendarController", permanent: true);
    calendarController.mySelectedHorsesName = "";
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        openCalenderDate =
            "${focusedDate.year}-${focusedDate.month}-${focusedDate.day}";
        getEventsByDate(date: DateTime.now());
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
    calendarController.getAllEventsByDate(
      date: formattedDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () async {
          if (isUserHaveActiveSubscriptionConstant == true) {
            await Get.toNamed(appRouteNames.addEventScreen)?.then(
              (value) {
                // calendarController.setTextFieldsAndDropdownToFalse();
                getEventsByDate(date: focusedDate);
                getVisibleMonthDays(focusedDate);
                getVisibleDays(focusedDate);
              },
            );
          } else {
            // Get.toNamed(appRouteNames.addEventScreen);
            Get.toNamed(appRouteNames.subscriptionScreen);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: appColors.primaryBlueColor,
          ),
          child: SvgPicture.asset(
            appIcons.addIconSvg,
            color: appColors.white,
          ),
        ),
      ),
      body: GetBuilder(
          init: calendarController,
          builder: (controller) {
            return ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: SafeArea(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  'My Calendar',
                                  textAlign: TextAlign.center,
                                  style: appTextStyles.p308002E2E,
                                ),
                              ),
                            ],
                          ),
                          4.h.verticalSpace,
                          const AppAppBarShadowWidget(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            color: appColors.white,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, bottom: 15),
                                      child: Obx(
                                        () => Text(
                                          formatMonthYear(
                                              controller.monthYear.value),
                                          style: appTextStyles.p26500313131
                                              .copyWith(fontSize: 24),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, bottom: 15),
                                        child: IconButton(
                                          icon: Obx(
                                            () => controller.isMonth.value
                                                ? Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size: 30,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    size: 18,
                                                  ),
                                          ),
                                          onPressed: () {
                                            controller.isMonth.value =
                                                !controller.isMonth.value;
                                          },
                                        ))
                                  ],
                                ),
                                Obx(
                                  () => controller.eventMonthAvList.isEmpty
                                      ? controller.isMonth.value
                                          ? SizedBox(
                                              height: 250,
                                            )
                                          : SizedBox()
                                      : TableCalendar(
                                          currentDay: focusedDate,
                                          focusedDay: focusedDate,
                                          firstDay: DateTime.utc(2024),
                                          lastDay: DateTime.utc(2040),
                                          onDaySelected:
                                              (selectedDay, focusedDay) {
                                            getVisibleDaysOnDateSelect(
                                                focusedDay, selectedDay);

                                            /// ///

                                            /// ///
                                            setState(() {
                                              focusedDate = selectedDay;
                                              getEventsByDate(
                                                  date: selectedDay);
                                              getVisibleMonthDays(focusedDate);
                                              openCalenderDate =
                                                  "${selectedDay.year}-${selectedDay.month}-${selectedDay.day}";
                                            });
                                          },
                                          calendarFormat:
                                              controller.isMonth.value
                                                  ? CalendarFormat.month
                                                  : CalendarFormat.week,
                                          headerVisible: false,
                                          calendarStyle: CalendarStyle(
                                            outsideDaysVisible: false,
                                            cellMargin: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 4),
                                            todayDecoration: BoxDecoration(
                                              color: appColors.c1E4475,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            defaultTextStyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                          daysOfWeekVisible: true,
                                          onPageChanged: (focusedDay) {
                                            if (controller.isMonth.value) {
                                              focusedDate = DateTime(
                                                  focusedDay.year,
                                                  focusedDay.month,
                                                  1);
                                              getEventsByDate(
                                                  date: focusedDate);
                                              getVisibleDays(focusedDay);
                                              getVisibleMonthDays(focusedDate);
                                            } else {
                                              getVisibleDays(focusedDay);
                                            }
                                            controller.monthYear.value =
                                                focusedDay;
                                          },
                                    calendarBuilders: CalendarBuilders(
                                      // Customize the day cell
                                      defaultBuilder: (context, date, focusedDay) {
                                        return Container(
                                          margin:
                                          const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text('${date.day}'),
                                              controller.eventMonthAvList
                                                  .isNotEmpty
                                                  ? (controller.eventMonthAvList[
                                              date.day -
                                                  1] &&
                                                  controller
                                                      .isMonth
                                                      .value)
                                                  ? Container(
                                                margin:
                                                const EdgeInsets
                                                    .only(
                                                    top:
                                                    5.0),
                                                width: 8.0,
                                                height: 8.0,
                                                decoration:
                                                BoxDecoration(
                                                  color: appColors
                                                      .c1E4475,
                                                  shape: BoxShape
                                                      .circle,
                                                ),
                                              )
                                                  : Container(
                                                margin:
                                                const EdgeInsets
                                                    .only(
                                                    top:
                                                    5.0),
                                                width: 8.0,
                                                height: 8.0,
                                                decoration:
                                                BoxDecoration(
                                                  color: Colors
                                                      .transparent,
                                                  shape: BoxShape
                                                      .circle,
                                                ),
                                              )
                                                  : SizedBox(
                                                width: 0,
                                                height: 0,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      outsideBuilder: (context, date, focusedDay) => Container(
                                        margin:
                                        const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text('${date.day}', style: TextStyle(color: Colors.black38),),
                                            controller.eventMonthAvList
                                                .isNotEmpty
                                                ? (controller.eventMonthAvList[
                                            date.day -
                                                1] &&
                                                controller
                                                    .isMonth
                                                    .value)
                                                ? Container(
                                              margin:
                                              const EdgeInsets
                                                  .only(
                                                  top:
                                                  5.0),
                                              width: 8.0,
                                              height: 8.0,
                                              decoration:
                                              BoxDecoration(
                                                color: appColors
                                                    .c1E4475,
                                                shape: BoxShape
                                                    .circle,
                                              ),
                                            )
                                                : Container(
                                              margin:
                                              const EdgeInsets
                                                  .only(
                                                  top:
                                                  5.0),
                                              width: 8.0,
                                              height: 0.0,
                                              decoration:
                                              BoxDecoration(
                                                color: Colors
                                                    .transparent,
                                                shape: BoxShape
                                                    .circle,
                                              ),
                                            )
                                                : SizedBox(
                                              width: 0,
                                              height: 0,
                                            )
                                          ],
                                        ),
                                      ),
                                      // selectedBuilder: (context, day, focusedDay) =>,
                                    ),
                                        ),
                                ),
                                Obx(
                                  () => !controller.isMonth.value
                                      ? controller.eventAvList.isNotEmpty
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: List.generate(
                                                controller.eventAvList.length,
                                                (index) => controller
                                                        .eventAvList[index]
                                                    ? PhysicalModel(
                                                        color:
                                                            appColors.c1E4475,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(4),
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        width: 8,
                                                  height: 3,
                                                      ),
                                              ),
                                            )
                                          : ClipRRect(child: ShimmerEffect(width: double.infinity,height: 6,),borderRadius:BorderRadius.circular(10),)
                                          // : LinearProgressIndicator()
                                      : SizedBox(),
                                )
                              ],
                            ),
                          ),
                          20.h.verticalSpace,
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 3),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Completed Events Today ',
                                          style: appTextStyles.p18500313131),
                                      TextSpan(
                                          text:
                                              '(${controller.completedEventList.length})',
                                          style: appTextStyles.p185001E44Blue),
                                    ],
                                  ),
                                )),
                                IconButton(
                                    onPressed: () {
                                      Get.toNamed(
                                          appRouteNames.completedEventsScreen)?.then((value) {

                                      },);
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      color: appColors.c1E4475,
                                      size: 20,
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              children: [
                                5.h.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Today",
                                      style: appTextStyles.p18500313131,
                                    ),
                                    Text(
                                      "${controller.eventsByDateList.length} Events",
                                      style: appTextStyles.p14500AEB0C3,
                                    ),
                                  ],
                                ),
                                15.h.verticalSpace,
                                ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        //
                                        // 0,
                                        controller.eventsByDateList.length ?? 0,
                                    itemBuilder: (context, index) {
                                      var event =
                                          controller.eventsByDateList[index];
                                      return Visibility(
                                        visible: event.isCompleted != true,
                                        child: Slidable(
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
                                                  calendarController.markEventDone(
                                                      eventId: event.id.toString()??'',
                                                      index: index, date: event.eventDate??"");
                                                },
                                                backgroundColor: appColors.primaryBlueColor,
                                                foregroundColor: Colors.white,
                                                icon: Icons.check_circle,
                                                label: 'Complete',
                                              ),
                                            ],
                                          ),
                                          startActionPane: ActionPane(
                                            extentRatio: 0.3,
                                            motion: const ScrollMotion(),
                                            children: [
                                              SlidableAction(
                                                padding: EdgeInsets.all(20.w),
                                                spacing: 0,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                ),
                                                onPressed: (context) async {
                                                  await showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        Dialog(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(14),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Delete",
                                                              style: appTextStyles
                                                                  .p164001EBlue,
                                                            ),
                                                            15.h.verticalSpace,
                                                            InkWell(
                                                              onTap: () async {
                                                                Get.back();
                                                                DateTime dateT =
                                                                    focusedDate;
                                                                var inputDate =
                                                                    "${dateT.year}-${dateT.month}-${dateT.day}";
                                                                DateFormat
                                                                    inputFormat =
                                                                    DateFormat(
                                                                        "yyyy-M-d");
                                                                DateTime
                                                                    parsedDate =
                                                                    inputFormat
                                                                        .parse(
                                                                            inputDate);
                                                                DateFormat
                                                                    outputFormat =
                                                                    DateFormat(
                                                                        "yyyy-MM-dd");
                                                                String
                                                                    formattedDate =
                                                                    outputFormat
                                                                        .format(
                                                                            parsedDate);
                                                                controller.deleteEvent(
                                                                    eventId: event
                                                                        .id
                                                                        .toString(),
                                                                    index:
                                                                        index,
                                                                    specificDate:
                                                                        formattedDate);
                                                              },
                                                              child: Text(
                                                                "This Event",
                                                                style: appTextStyles
                                                                    .p164008183,
                                                              ),
                                                            ),
                                                            15.h.verticalSpace,
                                                            InkWell(
                                                              onTap: () async {
                                                                Get.back();
                                                                try {
                                                                  controller.deleteEvent(
                                                                      eventId: event
                                                                          .id
                                                                          .toString(),
                                                                      index:
                                                                          index,
                                                                      specificDate:
                                                                          null);
                                                                } catch (e) {
                                                                  myAlertDialog(
                                                                      message:
                                                                          '$e',
                                                                      context:
                                                                          context);
                                                                }
                                                              },
                                                              child: Text(
                                                                "All events in series",
                                                                style: appTextStyles
                                                                    .p164008183,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                backgroundColor:
                                                    appColors.cEA4335,
                                                foregroundColor:
                                                    appColors.white,
                                                icon: Icons.delete,
                                                label: 'Delete',
                                              ),
                                            ],
                                          ),
                                          child: TodaysEventCalendarCardWidget(
                                            index: index,
                                            isBack: () {
                                              getEventsByDate(
                                                date: focusedDate,
                                              );
                                            },
                                            eventDataModel: event,
                                            date: openCalenderDate ?? "",
                                          ),
                                        ),
                                      );
                                    }),
                                170.h.verticalSpace,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  void getVisibleDays(DateTime focusedDay) async {
    int weekDay = focusedDay.weekday;
    final startOfWeek =
    weekDay == 7
        ? focusedDay
        :
    focusedDay.subtract(Duration(days: focusedDay.weekday));
    final endOfWeek = startOfWeek.add(Duration(days: 6));
    visibleDateList.clear();

    for (DateTime day = startOfWeek;
        day.isBefore(endOfWeek.add(Duration(days: 1)));
        day = day.add(Duration(days: 1))) {
      var d = day.toLocal();
      visibleDateList
          .add("${d.year}-${d.month}-${d.day}".toFormattedDateWithZero());
    }
    print("Date ==>> ${visibleDateList}");
    await calendarController.getHealthEventAv(
        calenderDateList: visibleDateList);
  }

  void getVisibleMonthDays(DateTime focusedDay) async {
    // Find the start of the month and the end of the month for the current view
    final startOfMonth = DateTime(focusedDay.year, focusedDay.month, 1);
    final endOfMonth = DateTime(focusedDay.year, focusedDay.month + 1, 0);

    // Initialize the list to hold the formatted dates
    List<String> visibleMonthDateList = [];

    // Iterate through the days of the month and add formatted dates to the list
    print('length ==>>0 ${calendarController.eventMonthAvList.length}');
    // calendarController.eventMonthAvList.clear();
    print('length ==>>1 ${calendarController.eventMonthAvList.length}');
    for (DateTime day = startOfMonth;
        day.isBefore(endOfMonth.add(Duration(days: 1)));
        day = day.add(Duration(days: 1))) {
      var formattedDate =
          "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
      visibleMonthDateList.add(formattedDate);
    }

    // Print the list of visible month dates
    print("Date ==>> ${visibleMonthDateList}");
    // Call your method to get events for the visible dates
    await calendarController.getMonthHealthEventAv(
        calenderDateList: visibleMonthDateList);
  }

  String formatMonthYear(DateTime date) {
    final monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    String monthName = monthNames[date.month - 1];
    return "$monthName, ${date.year}";
  }

  void getVisibleDaysOnDateSelect(DateTime focusedDay, DateTime selectedDay) {
    visibleDateList.clear();
    int weekDay = selectedDay.weekday;
    DateTime startOfWeek = weekDay == 7
        ? selectedDay
        : selectedDay.subtract(Duration(days: weekDay - 0));
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    for (int i = 0; i < 7; i++) {
      DateTime currentDate = startOfWeek.add(Duration(days: i));
      String formattedDate = dateFormat.format(currentDate);
      visibleDateList.add(formattedDate);
    }
    print("Date ==>> ${visibleDateList}");
    calendarController.getHealthEventAv(calenderDateList: visibleDateList);
  }
}

class TodaysEventCalendarCardWidget extends StatelessWidget {
  String date;
  TodaysEventCalendarCardWidget({
    super.key,
    required this.eventDataModel,
    required this.isBack,
    required this.index,
    required this.date,
  });
  final EventDataModel? eventDataModel;
  final void Function() isBack;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w)
          .copyWith(right: 15.w),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: appColors.cF6F6F6,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.06),
            offset: const Offset(0, 6),
            spreadRadius: 0,
            blurRadius: 22,
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          // CalendarController calendarController =
          //     Get.find(tag: "calendarController");
          Get.toNamed(appRouteNames.eventDetailsScreen,
              arguments: eventDataModel)?.then((value) {
              
                CalendarController controller = Get.find(tag: 'calendarController');
                DateFormat inputFormat = DateFormat("yyyy-M-d");
                DateTime parsedDate = inputFormat.parse(date);
                DateFormat outputFormat = DateFormat("yyyy-MM-dd");
                String formattedDate = outputFormat.format(parsedDate);
                controller.getAllEventsByDate(
                  date: formattedDate,
                );
              },);
          // calendarController.setEventForEdit(event: eventDataModel);
          // Get.toNamed(appRouteNames.editEventScreen, arguments: {"date": date})
          //     ?.then(
          //   (value) {
          //     calendarController.setTextFieldsAndDropdownToFalse();
          //     isBack();
          //   },
          // );
        },
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl:
                        (eventDataModel?.profileImage?.isNotEmpty ?? false)
                            ? eventDataModel?.profileImage ?? ""
                            : "",
                    height: 90,
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        appImages.horseImageJpg,
                        width: 90,
                        height: 90,
                      );
                    },
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
                      SizedBox(width:140,
                        child: Text(
                          "${eventDataModel?.horseName}",
                          style: appTextStyles.p18500313131,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        // "20 min left",
                        "${eventDataModel?.eventTimeStatus ?? ""}",
                        style: appTextStyles.p14500AEB0C3,
                      ),
                    ],
                  ),
                  2.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${eventDataModel?.eventTypeName}",
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
                  7.h.verticalSpace,
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
                              (eventDataModel?.startDate?.length ?? 1) > 5
                                  ? "${eventDataModel?.startTime}".convertToAmPm()
                                      // .substring(0, 5)
                                  : "${eventDataModel?.startTime}".convertToAmPm(),
                              // "14:30",
                              style: appTextStyles.p14500AEB0C3,
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !(eventDataModel?.isCompleted ?? false),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Mark as done",
                              style: appTextStyles.p145001EBlue,
                            ),
                            6.w.horizontalSpace,
                            AppRadioButton(
                              size: 3.5,
                              isSelected: eventDataModel?.isCompleted,
                              onTap: (p0) {
                                CalendarController cC =
                                    Get.find(tag: "calendarController");
                                cC.markEventDone(
                                    eventId:
                                        eventDataModel?.id.toString() ?? "0",
                                    index: index, date: eventDataModel?.eventDate??'');
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
