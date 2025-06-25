import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:equicare/features/my_stable/models/my_stable_model.dart';
import 'package:equicare/features/profile/controller/profile_controller.dart';
import 'package:equicare/features/profile/models/profile_model.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:equicare/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/profile_details_info_card_widget.dart';
import '../widgets/profile_picture_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = Get.put(ProfileController());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.wait([controller.getMyStableList(), controller.getProfile()]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appColors.c1E4475,
        body: Obx(
          () =>

              //  controller.isLoading.value
              //     ? const Center(
              //         child: CircularProgressIndicator(),
              //       )
              //     :

              ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            child: GetBuilder<ProfileController>(
              builder: (controller) => Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 180.h),
                    decoration: BoxDecoration(
                      color: appColors.cFDFDFD,
                      // color: Colors.amber,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.elliptical(100, 50),
                        topRight: Radius.elliptical(100, 50),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 45,
                              ),
                              Flexible(
                                child: Text(
                                  'Your Profile',
                                  textAlign: TextAlign.center,
                                  style: appTextStyles.p30800white,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(appRouteNames.profileEditScreen);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(9.w),
                                  margin: EdgeInsets.only(right: 15.w),
                                  decoration: ShapeDecoration(
                                    color: appColors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
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
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      children: [
                                        20.h.verticalSpace,
                                        ProfilePictureWidget(
                                          controller: controller,
                                        ),
                                        8.h.verticalSpace,
                                        Text(
                                            "${controller.userData.firstName ?? ""} ${controller.userData.lastName ?? ""}" ??
                                                "Jennifer Herrin",
                                            style: appTextStyles.p287003131),
                                        Text(
                                            controller.userData.email ??
                                                "" ??
                                                "jenniferherrin@gmail.com",
                                            style: appTextStyles.p14500818393),
                                        18.h.verticalSpace,
                                        ProfileInfoWidget(
                                          userData: controller.userData,
                                        ),
                                        20.h.verticalSpace,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Your Horses",
                                              style: appTextStyles.p18500313131,
                                            ),
                                            Text(
                                              controller.myStableList.length
                                                  .toString(),
                                              style: appTextStyles.p14500AEB0C3,
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                10.verticalSpace,
                                SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.myStableList.length,
                                      itemBuilder: (context, index) {
                                        MyStableModel data =
                                            controller.myStableList[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                                  horizontal: 8)
                                              .copyWith(left: 14),
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap:(){
                                                  showImageViewer(
                                                    context,
                                                    NetworkImage(data.profileImage??''),
                                                    doubleTapZoomable: true,
                                                  );
                                                },
                                                child: Container(
                                                  width: 100,
                                                  height: 100,
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    color: appColors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            110),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          data.profileImage ?? "",
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
                                              ),
                                              4.h.verticalSpace,
                                              SizedBox(
                                                width:100,
                                                child: Text(
                                                  data.name ?? "Horses",
                                                  style: appTextStyles.p167003131,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class ProfileInfoWidget extends StatelessWidget {
  ProfileModel userData;
  ProfileInfoWidget({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: appColors.cF6F6F6,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withOpacity(0.06),
            offset: Offset(0, 6),
            spreadRadius: 0,
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          5.verticalSpace,
          ProfileDetailsInfoCardWidget(
              title: "Date of Birth",
              subTitle: userData.dateOfBirth?.convertDateFormatToDMYYYY() ??
                  "------"),
          ProfileDetailsInfoCardWidget(
              title: "Sex", subTitle: userData.gender ?? "------"),
          ProfileDetailsInfoCardWidget(
            title: "Country",
            subTitle: userData.country ?? "------",
            isDividerVisible: false,
          ),
          5.h.verticalSpace,
        ],
      ),
    );
  }
}
