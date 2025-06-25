import 'package:cached_network_image/cached_network_image.dart';
import 'package:equicare/features/my_calendar/controller/calendar_controller.dart';
import 'package:equicare/features/my_calendar/models/event_data_model.dart';
import 'package:equicare/features/my_stable/controller/my_stable_controller.dart';
import 'package:equicare/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/buttons/app_radio_button.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../models/horse_event_model/horse_event_model.dart';

class HorseEventWidgets extends StatefulWidget {
  const HorseEventWidgets({super.key});

  @override
  State<HorseEventWidgets> createState() => _HorseEventWidgetsState();
}

class _HorseEventWidgetsState extends State<HorseEventWidgets> {
  late MyStableController myStableController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() {
    myStableController = Get.find(tag: "myStableController");
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        // myStableController.getHorseEventByCategories(
        //     horseId: myStableController.horseDetails?.id ?? 0,
        //     categoriesId: myStableController
        //             .eventTypeListWithCategoryList[0].categories?[0].id ??
        //         0);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.h.verticalSpace,
        Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            height: 43,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount:
                  myStableController.eventTypeListWithCategoryList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    myStableController.firstTabSelectedIndex = index;
                    myStableController.secondTabSelectedIndex = 0;
                    setState(() {});
                    await myStableController.getHorseEventByCategories(
                        eventTypeId:
                            myStableController.firstTabSelectedIndex + 1,
                        horseId: myStableController.horseDetails?.id ?? 0,
                        categoriesId: myStableController
                                .eventTypeListWithCategoryList[
                                    myStableController.firstTabSelectedIndex]
                                .categories?[index]
                                .id ??
                            null);
                    setState(() {});
                    // myStableController.update();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 5, left: 5),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration:
                        myStableController.firstTabSelectedIndex == index
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: appColors.c1E4475)
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: appColors.cF6F6F6),
                    child: Center(
                        child: Text(
                      myStableController
                              .eventTypeListWithCategoryList[index].name ??
                          "--",
                      style: myStableController.firstTabSelectedIndex == index
                          ? appTextStyles.p16500White
                          : appTextStyles.p16500White
                              .copyWith(color: appColors.cAEB0C3),
                    )),
                  ),
                );
              },
            )),
        10.h.verticalSpace,
        Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            height: 43,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: myStableController
                  .eventTypeListWithCategoryList[
                      myStableController.firstTabSelectedIndex]
                  .categories
                  ?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    myStableController.secondTabSelectedIndex = index;
                    setState(() {});
                    await myStableController.getHorseEventByCategories(
                        eventTypeId:
                            myStableController.firstTabSelectedIndex + 1,
                        horseId: myStableController.horseDetails?.id ?? 0,
                        categoriesId: myStableController
                                .eventTypeListWithCategoryList[
                                    myStableController.firstTabSelectedIndex]
                                .categories?[index]
                                .id ??
                            null);
                    setState(() {});
                    // myStableController.update();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 5, left: 5),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: myStableController.secondTabSelectedIndex == index
                          ? appColors.c1E4475.withOpacity(0.07)
                          : Colors.transparent,
                      border: Border.all(
                          color:
                              myStableController.secondTabSelectedIndex == index
                                  ? appColors.c1E4475
                                  : appColors.cF0F2F2,
                          width: 1.5),
                    ),
                    child: Center(
                        child: Text(
                      myStableController
                              .eventTypeListWithCategoryList[
                                  myStableController.firstTabSelectedIndex]
                              .categories?[index]
                              .name ??
                          '--',
                      style: myStableController.secondTabSelectedIndex == index
                          ? appTextStyles.p165001E4475
                          : appTextStyles.p16500White
                              .copyWith(color: appColors.cAEB0C3),
                    )),
                  ),
                );
              },
            )),
        10.h.verticalSpace,
        myStableController.horseEventList.isNotEmpty?ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: myStableController.horseEventList.length,
          itemBuilder: (context, index) {
            var event = myStableController.horseEventList[index];
            return HorseEventCardItem(
              horseEventModel: event,
              subCategory: myStableController
                      .eventTypeListWithCategoryList[
                          myStableController.firstTabSelectedIndex]
                      .categories?[myStableController.secondTabSelectedIndex]
                      .name ??
                  "",
            );
          },
        ):Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Center(child: Text("Not Found"),),
        )
      ],
    );
  }
}

class HorseEventCardItem extends StatefulWidget {
  final EventDataModel? horseEventModel;
  final String subCategory;
  const HorseEventCardItem({
    super.key,
    required this.horseEventModel,
    required this.subCategory,
  });

  @override
  State<HorseEventCardItem> createState() => _HorseEventCardItemState();
}

class _HorseEventCardItemState extends State<HorseEventCardItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(appRouteNames.searchEventDetailsScreen, arguments:widget.horseEventModel);
        // CalendarController calendarController = Get.put(CalendarController(),
        //     tag: "calendarController", permanent: true);
        // var currentDateTime = DateTime.now();
        // var date = "${currentDateTime.year}-${currentDateTime.month}-${currentDateTime.day}";
        // Get.toNamed(appRouteNames.editEventScreen, arguments: {"date":date, "eventId":widget.horseEventModel?.id??""})?.then(
        //   (value) {
        //     MyStableController myStableController = Get.find(tag: "myStableController");
        //        myStableController.getHorseEventByCategories(
        //            eventTypeId:myStableController.firstTabSelectedIndex+1,
        //     horseId: myStableController.horseDetails?.id ?? 0,
        //     categoriesId: myStableController
        //             .eventTypeListWithCategoryList[0].categories?[0].id ??
        //         null);
        //        setState(() {});
        //     // myStableController.update();
        //
        //   },
        // );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        decoration: BoxDecoration(
          color: appColors.white,
          borderRadius: BorderRadius.circular(10),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl:(widget.horseEventModel?.profileImage?.isNotEmpty?? false) ?widget.horseEventModel?.profileImage ?? "":"",
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
              12.w.horizontalSpace,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.horseEventModel?.horseName ?? "Goldie",
                                style: appTextStyles.p18500313131,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          widget.horseEventModel?.alert ?? "20 min left",
                          style: appTextStyles.p14500AEB0C3,
                        ),
                      ],
                    ),
                    2.h.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // "Vet",
                                widget.subCategory,
                                style: appTextStyles.p165001E4475,
                              ),
                            ],
                          ),
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
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 20,
                              color: appColors.cAEB0C3,
                            ),
                            4.w.horizontalSpace,
                            Text(
                              widget.horseEventModel?.startTime?.convertToAmPm() ?? "",
                              style: appTextStyles.p14500AEB0C3,
                            )
                          ],
                        ),
                        // !(1 == 1)
                        //     ?
                        Text(
                          "${widget.horseEventModel?.eventRepeat}",
                          // "All Day",
                          style: appTextStyles.p145001EBlue,
                        )
                        // : Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       Text(
                        //         "All",
                        //         style: appTextStyles.p145001EBlue,
                        //       ),
                        //       10.w.horizontalSpace,
                        //       AppRadioButton(
                        //         size: 5,
                        //         onTap: (p0) {},
                        //       ),
                        //     ],
                        //   ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
