import 'package:cached_network_image/cached_network_image.dart';
import 'package:equicare/features/my_calendar/controller/calendar_controller.dart';
import 'package:equicare/features/my_calendar/models/event_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/shadows/app_appbar_shadow_widget.dart';
import '../../../../utils/constants/app_constants.dart';

class CompletedEventsScreen extends StatelessWidget {
   CompletedEventsScreen({super.key});

  CalendarController controller = Get.find(tag: "calendarController");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(0.95),
      body: GetBuilder<CalendarController>(builder: (controller) => SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back, color: appColors.c1E4475),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: FittedBox(
                    child: Text(
                      'Completed Events',
                      textAlign: TextAlign.center,
                      style: appTextStyles.p308002E2E.copyWith(
                        // fontSize: 25
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 40,)
              ],
            ),
            const AppAppBarShadowWidget(),
            Expanded(
              child: controller.completedEventList.isEmpty?Center(child: Text("0 Completed Events"),):ListView.builder(
                itemBuilder: (context, index) => GestureDetector(
                    child: CompletedEventsItem(
                      completedEvent: controller.completedEventList[index],),
                onTap: () {
                  Get.toNamed(appRouteNames.eventDetailsScreen, arguments:  controller.completedEventList[index])?.then((value) {
                    controller.update();
                  },);
                },),
                itemCount: controller.completedEventList.length, // Adjust as needed
              ),
            ),
          ],
        ),
      ),)
    );
  }
}

class CompletedEventsItem extends StatelessWidget {
  EventDataModel completedEvent;


   CompletedEventsItem( {required this.completedEvent, super.key});

  @override
  Widget build(BuildContext context) {
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
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: (completedEvent.profileImage?.isNotEmpty ?? false)
                      ? completedEvent.profileImage ?? ""
                      : "",
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      appImages.horseImageJpg,
                      width: 130,
                      height: 130,
                    );
                  },
                  height: 130,
                  width: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          20.w.horizontalSpace,
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      completedEvent.horseName??""
                          "Dreamer",
                      style: appTextStyles.p16500313131,
                      overflow: TextOverflow.ellipsis,
                    ),
                    10.w.horizontalSpace,
                    Text(
                      completedEvent.eventTypeName??""
                          "",
                      style: appTextStyles.p145001EBlue,
                    ),
                  ],
                ),
                20.h.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10,),
                  decoration: BoxDecoration(
                    color: appColors.primaryBlueColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 25,
                      ),
                      10.w.horizontalSpace,
                      Text(
                        "Completed",
                        style: appTextStyles.p14500White,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );


      Container(
      margin: EdgeInsets.only(right: 15, left: 15, bottom: 10,top: 5),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: appColors.cF6F6F6,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white70.withOpacity(0.4),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff000000).withOpacity(0.06),
                      offset: Offset(6, 6),
                      spreadRadius: 0,
                      blurRadius: 22,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: CachedNetworkImage(
                            imageUrl:(completedEvent.profileImage?.isNotEmpty?? false) ? completedEvent.profileImage??"" : "",
                            height: 190,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return Image.asset(appImages.horseImageJpg, height: 200,fit: BoxFit.cover,width: double.infinity,);
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          margin: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: appColors.white,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text(
                            completedEvent.completedAgo??""
                            "15 min ago",
                            style: appTextStyles.p14400313131,
                          ),
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            10.w.horizontalSpace,
                            SizedBox(
                              width: 170,
                              child: Text(
                                completedEvent.horseName??""
                                "Dreamer",
                                style: appTextStyles.p16500313131,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon(
                            //   Icons.favorite,
                            //   color: appColors.cCBCDD7,
                            //   size: 27,
                            // ),
                            10.w.horizontalSpace,
                            Text(
                              completedEvent.eventTypeName??""
                              "",
                              style: appTextStyles.p145001EBlue,
                            ),
                            10.w.horizontalSpace,
                          ],
                        ),
                      ],
                    ),
                    25.h.verticalSpace,
                  ],
                ),
              ),
              21.verticalSpace
            ],
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 50.w),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: appColors.primaryBlueColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 25,
                  ),
                  10.w.horizontalSpace,
                  Text(
                    "Completed",
                    style: appTextStyles.p14500White,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
