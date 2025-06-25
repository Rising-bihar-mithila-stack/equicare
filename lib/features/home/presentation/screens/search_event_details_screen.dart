// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:equicare/common/buttons/app_blue_button.dart';
import 'package:equicare/common/buttons/app_grey_button.dart';
import 'package:equicare/common/widgets/app_dot_widget.dart';
import 'package:equicare/features/my_calendar/models/event_data_model.dart';
import 'package:equicare/features/my_calendar/presentation/screens/add_event_screen.dart';
import 'package:equicare/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../common/shadows/app_appbar_shadow_widget.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../auth/presentation/screens/create_account_screen.dart';
import '../../../my_calendar/controller/calendar_controller.dart';
import '../../../my_stable/presentation/screens/pdf_viewer_screen.dart';
import '../../../profile/presentation/widgets/profile_picture_widget.dart';
import '../../controllers/home_controller.dart';
import '../widgets/event_details_info_card_widget.dart';
import 'event_details_screen.dart';

class SearchEventDetailsScreen extends StatefulWidget {
  SearchEventDetailsScreen({super.key});

  final EventDataModel? eventDataModel = Get.arguments;

  @override
  State<SearchEventDetailsScreen> createState() => _SearchEventDetailsScreenState();
}

class _SearchEventDetailsScreenState extends State<SearchEventDetailsScreen> {
  late bool value;
  late EventDataModel event;
  late HomeController controller;
  late CalendarController calendarController;

  @override
  void initState() {
    // TODO: implement initState
    controller = Get.put(HomeController());
    calendarController = Get.put(CalendarController(), tag: 'calendarController');
    event = widget.eventDataModel??EventDataModel();
    value = event.isCompleted ?? true;
    print(event.toJson());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() =>
        ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: GetBuilder<HomeController>(
            builder: (controller) => SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: appColors.primaryBlueColor,
                              size: 30,
                            )),
                      ),
                      Flexible(
                        child: Text(
                          'Event Details',
                          textAlign: TextAlign.center,
                          style: appTextStyles.p308002E2E,
                        ),
                      ),
                      SizedBox(width: 40,)
                    ],
                  ),
                  10.h.verticalSpace,
                  const AppAppBarShadowWidget(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            20.h.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    showImageViewer(
                                      context,
                                      NetworkImage(event.profileImage??''),
                                      doubleTapZoomable: true,
                                    );
                                  },
                                  child: Container(
                                    width: 220,
                                    height: 220,
                                    padding:
                                    const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: appColors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(110),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        event.profileImage ?? "",
                                        placeholder:
                                            (context, url) =>
                                            ShimmerEffect(
                                              width: 0,
                                              height: 0,
                                            ),
                                        errorWidget:
                                            (context, url, error) {
                                          return ShimmerEffect(
                                            width: 0,
                                            height: 0,
                                          );
                                        },
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            10.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  event.horseName ?? "",
                                  style: appTextStyles.p26700313131,
                                ),
                              ],
                            ),
                            5.h.verticalSpace,

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  event.eventTypeName ?? "----",
                                  style: appTextStyles.p16500818393,
                                ),
                              ],
                            ),
                            5.h.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Today",
                                  style: appTextStyles.p167001EBlue,
                                ),
                                8.w.horizontalSpace,
                                AppDotWidget(
                                  color: appColors.primaryBlueColor,
                                  size: 6,
                                ),
                                8.w.horizontalSpace,
                                Text(
                                  event.startDate?.convertDateFormatToDMYYYY() ?? "16-10-1995",
                                  style: appTextStyles.p167003131,
                                ),
                              ],
                            ),
                            25.h.verticalSpace,
                            EventInfoWidget(
                              event: event,
                            ),
                            15.h.verticalSpace,
                            Row(
                              children: [
                                Text(
                                  "Note",
                                  style: appTextStyles.p14500AEB0C3,
                                ),
                              ],
                            ),
                            10.h.verticalSpace,
                            Text(
                              event.notes ??
                                  "Lorem ipsum dolor sit amet consectetur. Quis quis vitae pharetra quis egestas ultricies accumsan non auctor. In suspendisse aliquet facilisi ornare. Malesuada ut est sit in cras montes turpis. Volutpat facilisis facilisis mattis purus donec dictum.",
                              style: appTextStyles.p16400313131,
                            ),
                            20.h.verticalSpace,
                            Visibility(
                              visible:
                              event.eventImage?.isNotEmpty ?? false,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Images",
                                        style: appTextStyles.p14500AEB0C3,
                                      ),
                                    ],
                                  ),
                                  10.h.verticalSpace,
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 120,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: event.eventImage?.length,
                                        itemBuilder: (context, index) {
                                          // var image =
                                          //     event.eventImage?[index];
                                          var value = event.eventImage?[index].image??"";
                                          return  !value.contains('.pdf')?GestureDetector(
                                            onTap:(){
                                              showImageViewer(
                                                context,
                                                NetworkImage(value??''),
                                                doubleTapZoomable: true,
                                              );
                                            },
                                            child: Container(
                                              width: 130,
                                              height: 120,
                                              padding:
                                              const EdgeInsets.symmetric(horizontal: 5),
                                              decoration: BoxDecoration(
                                                color: appColors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    100),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                  value ?? "",
                                                  placeholder:
                                                      (context, url) =>
                                                      ShimmerEffect(
                                                        width: 100,
                                                        height: 100,
                                                      ),
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return ShimmerEffect(
                                                      width: 100,
                                                      height: 100,
                                                    );
                                                    // return Image.asset(appIcons.userPng);
                                                  },
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ): GestureDetector(
                                            onTap: () {
                                              if(value.isNotEmpty){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => PdfViewerScreen(
                                                        pdfUrl: value
                                                    ),
                                                  ),
                                                );
                                              }else{
                                                myAlertDialog(message: 'Something went wrong', context: context);
                                              }

                                            },
                                            child: Container(
                                              margin:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal:
                                                  5),
                                              child: CircleAvatar(
                                                maxRadius: 58,
                                                backgroundColor: Colors.black12,
                                                child: Icon(Icons
                                                    .picture_as_pdf_outlined, size: 50,),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  20.verticalSpace
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}