import 'package:cached_network_image/cached_network_image.dart';
import 'package:equicare/features/home/controllers/home_controller.dart';
import 'package:equicare/features/home/presentation/screens/home_screen.dart';
import 'package:equicare/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../common/buttons/app_radio_button.dart';
import '../../../../common/shadows/app_appbar_shadow_widget.dart';
import '../../../../common/text_field/app_text_field.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../my_calendar/models/event_data_model.dart';

class SearchEventScreen extends StatefulWidget {
  const SearchEventScreen({super.key});

  @override
  State<SearchEventScreen> createState() => _SearchEventScreenState();
}

class _SearchEventScreenState extends State<SearchEventScreen> {
  late HomeController controller;
  @override
  void initState() {
    // TODO: implement initState
    controller = Get.put(HomeController());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.searchHealthEvents(query: controller.searchQueryController.text);
    },);
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder(builder: (controller) => ModalProgressHUD(inAsyncCall: controller.isLoading.value, child: Column(
          children: [
            Column(
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
                        'Events',
                        textAlign: TextAlign.center,
                        style: appTextStyles.p308002E2E,
                      ),
                    ),
                    SizedBox(width: 40,)
                  ],
                ),
                10.h.verticalSpace,
                const AppAppBarShadowWidget(),
              ],
            ),
            Expanded(child: controller.searchHealthEventsList.isNotEmpty?ListView.builder(itemCount: controller.searchHealthEventsList.length,
            itemBuilder: (context, index) => SearchEventItems(controller: controller,index: index,),): Center(child: Text(controller.isLoading.value?"":"Not Found"),))
          ],
        )),init: controller,)
      ),
    );
  }
}

class SearchEventItems extends StatelessWidget {
  int index;
   SearchEventItems({super.key, required this.controller,required this.index});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    EventDataModel event = controller.searchHealthEventsList[index];
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15.w,
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
          Get.toNamed(appRouteNames.searchEventDetailsScreen, arguments: event)?.then(
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
                        width: 100,
                        height: 100,
                      );
                    },
                    height: 100,
                    width: 100,
                    fit: BoxFit.fill,
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
                      Text(
                        "${event.horseName}",
                        style: appTextStyles.p18500313131,
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
                              size: 20,
                              color: appColors.cAEB0C3,
                            ),
                            4.w.horizontalSpace,
                            Text(
                              ((event.startTime?.length ?? 1) > 5)
                                  ? "${event.startTime}".convertToAmPm()
                                  : "${event.startTime}".convertToAmPm(),
                              style: appTextStyles.p14500AEB0C3,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            )
                          ],
                        ),
                      ),
                      // Visibility(
                      //   visible: !(event.isCompleted ?? false),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       Text(
                      //         "Mark as done",
                      //         style: appTextStyles.p145001EBlue,
                      //       ),
                      //       10.w.horizontalSpace,
                      //       AppRadioButton(
                      //         size: 5, onTap: (bool ) {  },
                      //
                      //         onTap: (p0) {
                      //           controller.markEventDone(
                      //               eventId: event.id.toString() ?? "0",
                      //               index: index);
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
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

