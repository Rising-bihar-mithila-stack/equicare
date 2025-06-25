import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:equicare/features/contacts/controller/contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../profile/presentation/widgets/profile_details_info_card_widget.dart';
import '../../../profile/presentation/widgets/profile_picture_widget.dart';

class SpecificContactDetailScreen extends StatefulWidget {
  SpecificContactDetailScreen({super.key});

  @override
  State<SpecificContactDetailScreen> createState() =>
      _SpecificContactDetailScreenState();
}

class _SpecificContactDetailScreenState
    extends State<SpecificContactDetailScreen> {
  final int id = Get.arguments ?? 0;

  late ContactController controller;
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    controller = Get.put(ContactController());
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        controller.getSingleContact(id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => 
      
      // controller.isLoading.value
      //     ? const Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     :
          
          ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
             child: GetBuilder<ContactController>(
                builder: (controller) => Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 190.h),
                      decoration: BoxDecoration(
                        color: appColors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.elliptical(400, 90),
                          topRight: Radius.elliptical(400, 90),
                        ),
                      ),
                    ),
                    SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 6.h, right: 14.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: appColors.c1E4475,
                                          )),
                                    ],
                                  ),
                                ),
                                // Container(
                                //   width: 230,
                                //   height: 230,
                                //   padding: const EdgeInsets.all(3),
                                //   decoration: BoxDecoration(
                                //     color: appColors.white,
                                //     shape: BoxShape.circle,
                                //   ),
                                //   child: ClipRRect(
                                //     borderRadius: BorderRadius.circular(110),
                                //     child: CachedNetworkImage(
                                //       imageUrl:
                                //       controller.singleContact.profile ?? "",
                                //       fit: BoxFit.cover,
                                //       errorWidget: (context, url, error) {
                                //         return Image.asset(appImages.profileDefaultImage);
                                //       },
                                //     ),
                                //   ),
                                // ),
                                GestureDetector(
                                  onTap:(){
                                    showImageViewer(
                                      context,
                                      NetworkImage(controller.singleContact.profile??''),
                                      doubleTapZoomable: true,
                                    );
                                  },
                                  child: Container(
                                    width: 230,
                                    height: 230,
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
                                        controller.singleContact.profile ?? "",
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
                                14.h.verticalSpace,
                                SizedBox(
                                  width: MediaQuery.of(context).size.width*0.9,
                                  child: Text(
                                      controller.singleContact.fullName ??
                                          "",
                                      style: appTextStyles.p26700313131, textAlign: TextAlign.center,),
                                ),
                                Text(
                                    controller.singleContact.phoneNo ??
                                        "",
                                    style: appTextStyles.p165001E4475),
                                25.h.verticalSpace,
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: appColors.cF6F6F6,
                                    // color: Colors.amber,
                                    borderRadius: BorderRadius.circular(16),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Color(0xff000000).withOpacity(0.06),
                                    //     offset: Offset(0, 6),
                                    //     spreadRadius: 0,
                                    //     blurRadius: 10,
                                    //   )
                                    // ],
                                  ),
                                  child: Column(
                                    children: [
                                      5.verticalSpace,
                                      ProfileDetailsInfoCardWidget(
                                          title: "Email",
                                          subTitle: controller
                                                  .singleContact.emailAddress ??
                                              "-------"),
                                      ProfileDetailsInfoCardWidget(
                                          title: "Company Name",
                                          subTitle:
                                              controller.singleContact.company ??
                                                  "-------"),
                                      ProfileDetailsInfoCardWidget(
                                          title: "Category",
                                          subTitle: controller
                                                  .singleContact.profession ??
                                              "-------"),
                                      ProfileDetailsInfoCardWidget(
                                        title: "Address",
                                        subTitle:
                                            controller.singleContact.address ??
                                                "-------",
                                        isDividerVisible: false,
                                      ),
                                      5.h.verticalSpace,
                                    ],
                                  ),
                                )
                              ],
                            ),
                            20.verticalSpace,
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    if (await controller.deleteContact(
                                        controller.singleContact.id ?? 0)) {
                                      controller.getAllContacts();
                                      Get.back();
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 18,
                                    ),
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: appColors.cFBEAE9,
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          size: 20,
                                          color: appColors.cEA4335,
                                        ),
                                        5.horizontalSpace,
                                        Text(
                                          'Delete Contact',
                                          style: appTextStyles.p165003DABGreen
                                              .copyWith(color: appColors.cEA4335),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                        appRouteNames.addAndEditContactScreen,
                                        arguments: controller.singleContact);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    margin: EdgeInsets.only(
                                        right: 20, left: 20, bottom: 18),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(16.r),
                                        border: Border.all(
                                            color: appColors.c1E4475, width: 3)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: appColors.c1E4475,
                                        ),
                                        5.horizontalSpace,
                                        Text(
                                          'Edit Contact',
                                          style: appTextStyles.p165003DABGreen
                                              .copyWith(color: appColors.c1E4475),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
           ),
    ));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
