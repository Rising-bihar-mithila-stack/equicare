import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:equicare/features/auth/presentation/screens/create_account_screen.dart';
import 'package:equicare/features/my_stable/controller/my_stable_controller.dart';
import 'package:equicare/features/my_stable/models/horse_details_model.dart';
import 'package:equicare/features/my_stable/presentation/screens/pdf_viewer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../common/buttons/app_blue_button.dart';
import '../../../../common/buttons/app_grey_button.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../profile/presentation/widgets/profile_picture_widget.dart';
import '../widgets/horse_event_widgets.dart';
import '../widgets/horse_info_items.dart';

class SpecificHorseDetailsScreen extends StatefulWidget {
  const SpecificHorseDetailsScreen({super.key});

  @override
  State<SpecificHorseDetailsScreen> createState() =>
      _SpecificHorseDetailsScreenState();
}

class _SpecificHorseDetailsScreenState
    extends State<SpecificHorseDetailsScreen> {
  late MyStableController myStableController;
  bool isProfileInfo = true;
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() {
    myStableController = Get.find(tag: "myStableController");
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        int horseId = Get.arguments["horseId"];
        await myStableController.getEventTypes();
        await myStableController.getHorseDetail(horseId: horseId);
        // myStableController.getHorseEventByCategories(
        //     horseId: myStableController.horseDetails?.id??0,
        //     categoriesId: myStableController.eventTypeListWithCategoryList[0].categories?[0].id??0
        // );
        myStableController.getHorseEventByCategories(
            horseId: myStableController.horseDetails?.id ?? 0,
            categoriesId: myStableController
                    .eventTypeListWithCategoryList[0].categories?[0].id ??
                null, eventTypeId: myStableController.firstTabSelectedIndex+1);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: myStableController,
        builder: (controller) {
          return Scaffold(
            backgroundColor: appColors.cEAEBF1,
            body:
                //  controller.isLoading.value
                // ? Center(
                //     child: CircularProgressIndicator(
                //       color: appColors.primaryBlueColor,
                //     ),
                //   )
                // :
                ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 200.h),
                    decoration: BoxDecoration(
                      color: appColors.cFDFDFD,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.elliptical(400, 90),
                        topRight: Radius.elliptical(400, 90),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 6.h, right: 14.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: appColors.c1E4475,
                                    )),
                                Visibility(
                                  visible: controller.horseDetails?.isMyHorse ??
                                      false,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                insetPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                backgroundColor:
                                                    appColors.white,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 30.h,
                                                      horizontal: 20.w),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        "Are you sure you want to remove this horse from your stable?",
                                                        style: appTextStyles
                                                            .p167003131,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      15.h.verticalSpace,
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Flexible(
                                                              child:
                                                                  AppBlueButton(
                                                                      onTap:
                                                                          () async {
                                                                        Get.back();
                                                                        var res =
                                                                            await controller.deleteHorse(
                                                                          horseId:
                                                                              controller.horseDetails?.id ?? 0,
                                                                        );
                                                                      },
                                                                      title:
                                                                          "Yes, Remove")),
                                                          15.w.horizontalSpace,
                                                          Flexible(
                                                              child:
                                                                  AppGreyButton(
                                                                      onTap:
                                                                          () {
                                                                        Get.back();
                                                                      },
                                                                      title:
                                                                          "No, Don't")),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(12.w),
                                          decoration: ShapeDecoration(
                                            color: appColors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.delete,
                                            color: appColors.cEA4335,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                      10.w.horizontalSpace,
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                              appRouteNames.editHorseScreen);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(12.w),
                                          decoration: ShapeDecoration(
                                            color: appColors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.edit,
                                            color: appColors.c1E4475,
                                            size: 25,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          10.h.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap:(){
                                  showImageViewer(
                                    context,
                                    NetworkImage(controller.horseDetails?.profileImage??''),
                                    doubleTapZoomable: true,
                                  );
                  },
                                child: Container(
                                  width: 220,
                                  height: 220,
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: appColors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(110),
                                    // child: CachedNetworkImage(
                                    //   imageUrl:
                                    //       controller.horseDetails?.profileImage ?? "",
                                    //   fit: BoxFit.cover,
                                    //   errorWidget: (context, url, error) {
                                    //     return Image.asset(appImages.horseImageJpg,width: 100,height: 100,);
                                    //   },
                                    // ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      controller.horseDetails?.profileImage ?? "",
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
                          10.h.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(controller.horseDetails?.name ?? "",
                                    style: appTextStyles.p26700313131.copyWith(overflow: TextOverflow.ellipsis)),
                                width: MediaQuery.of(context).size.width*0.9,
                                alignment: Alignment.center,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.9,
                                alignment: Alignment.center,
                                child: Text(
                                    "${controller.horseDetails?.sex??'-------'}, ${controller.horseDetails?.breed??'-------'}",
                                    style: appTextStyles.p16500White
                                        .copyWith(color: appColors.c818393,overflow: TextOverflow.ellipsis)),
                              ),
                            ],
                          ),
                          if(controller.horseDetails?.gallery?.isNotEmpty??false)Column(
                            children: [
                              15.h.verticalSpace,

                              Container(
                                padding: const EdgeInsets.only(left: 12),
                                height: 100,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        controller.horseDetails?.gallery?.length,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      // return CircleAvatar(
                                      //   maxRadius: 48,
                                      //   backgroundImage: controller.horseDetails
                                      //               ?.gallery?[index].image !=
                                      //           null
                                      //       ? NetworkImage(controller.horseDetails
                                      //               ?.gallery?[index].image ??
                                      //           "")
                                      //       : AssetImage(appImages.horseImageJpg),
                                      // );
                                      var value = controller.horseDetails?.gallery?[index].image??"";
                                      return  !value.contains('.pdf')?GestureDetector(
                                        onTap: () {
                                          showImageViewer(
                                            context,
                                            NetworkImage(value),
                                            doubleTapZoomable: true,
                                          );
                                        },
                                        child: Container(
                                          width: 120,
                                          height: 100,
                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: appColors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(
                                                50),
                                            child:CachedNetworkImage(
                                                imageUrl:
                                                controller.horseDetails?.gallery?[index].image ?? "",
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
                                            backgroundColor: Colors.black12,
                                            maxRadius: 48,
                                            child: Icon(Icons
                                                .picture_as_pdf_outlined,size: 45,),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          10.h.verticalSpace,
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                        child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isProfileInfo = true;
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 70,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: isProfileInfo
                                                ? BorderSide(
                                                    color: appColors
                                                        .primaryBlueColor,
                                                    width: 5)
                                                : BorderSide(
                                                    color: appColors.cE5E7F4,
                                                  ),
                                          ),
                                        ),
                                        child: Text(
                                          "Profile Info",
                                          style: isProfileInfo
                                              ? appTextStyles.p16500818393
                                              : appTextStyles
                                                  .p16500313131, //  appColors.cE5E7F4
                                        ),
                                      ),
                                    )),
                                    Flexible(
                                      child: InkWell(
                                        onTap: () async {
                                          setState(() {
                                            isProfileInfo = false;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 70,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: !isProfileInfo
                                                  ? BorderSide(
                                                      color: appColors
                                                          .primaryBlueColor,
                                                      width: 5)
                                                  : BorderSide(
                                                      color: appColors.cE5E7F4,
                                                    ),
                                            ),
                                          ),
                                          child: Text(
                                            "Events",
                                            style: !isProfileInfo
                                                ? appTextStyles.p16500818393
                                                : appTextStyles.p16500313131,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              isProfileInfo
                                  ? controller.horseBioDataList.isEmpty?SizedBox():Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          color: appColors.cE5E7F4,
                                          child: HorseInfoItems(
                                            horseBioDataList:
                                                controller.horseBioDataList,
                                          )),
                                      5.verticalSpace,
                                      Text('    Notes',style: appTextStyles.p14500AEB0C3.copyWith(fontSize: 17),),
                                      Text('     ${controller.horseDetails?.notes}'),
                                      15.verticalSpace
                                    ],
                                  )
                                  : const HorseEventWidgets(),
                              // 100.h.verticalSpace
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: controller.horseDetails?.isMyHorse == true
                ? GestureDetector(
                    onTap: () {
                      if (isUserHaveActiveSubscriptionConstant == true) {
                        Get.toNamed(appRouteNames.addEventScreen);
                      } else {
                        Get.toNamed(appRouteNames.subscriptionScreen);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: appColors.primaryBlueColor,
                      ),
                      child: SvgPicture.asset(
                        appIcons.addIconSvg,
                        color: appColors.white,
                      ),
                    ),
                  )
                : null,
          );
        });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    myStableController.horseDetails = HorseDetailsModel();
    super.dispose();
  }
}
