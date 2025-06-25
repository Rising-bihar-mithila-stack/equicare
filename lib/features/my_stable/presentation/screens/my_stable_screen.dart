import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:equicare/features/my_stable/controller/my_stable_controller.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../common/shadows/app_appbar_shadow_widget.dart';
import '../../../profile/presentation/widgets/profile_picture_widget.dart';

class MyStableScreen extends StatefulWidget {
  const MyStableScreen({super.key});

  @override
  State<MyStableScreen> createState() => _MyStableScreenState();
}

class _MyStableScreenState extends State<MyStableScreen> {
  late MyStableController myStableController;
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  init() {
    myStableController = Get.put(MyStableController(),
        tag: "myStableController", permanent: true);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        myStableController.getMyStableList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          if (isUserHaveActiveSubscriptionConstant == true) {
            Get.toNamed(appRouteNames.addHorseScreen)?.then(
              (value) {
                myStableController.getMyStableList();
              },
            );
          } else {
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
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    'My Stable',
                    textAlign: TextAlign.center,
                    style: appTextStyles.p308002E2E,
                  ),
                ),
              ],
            ),
            3.h.verticalSpace,
            const AppAppBarShadowWidget(),
            Expanded(
              child: GetBuilder(
                  init: myStableController,
                  builder: (controller) {
                    return
                        // controller.isLoading.value
                        //     ? Center(
                        //         child: CircularProgressIndicator(
                        //           color: appColors.primaryBlueColor,
                        //         ),
                        //       )
                        //     :

                        ModalProgressHUD(
                      inAsyncCall: controller.isLoading.value,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Column(
                            children: [
                              20.h.verticalSpace,
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.myStableList.length + 1,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 15,
                                  childAspectRatio: 0.8,
                                ),
                                itemBuilder: (context, index) {
                                  if (index == controller.myStableList.length) {
                                    return InkWell(
                                      onTap: () {
                                        if (isUserHaveActiveSubscriptionConstant ==
                                            true) {
                                          Get.toNamed(
                                                  appRouteNames.addHorseScreen)
                                              ?.then(
                                            (value) {
                                              myStableController
                                                  .getMyStableList();
                                            },
                                          );
                                        } else {
                                          Get.toNamed(
                                              appRouteNames.subscriptionScreen);
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            minRadius: 51,
                                            backgroundColor: appColors.cE6E6E6,
                                            child: SvgPicture.asset(
                                                appIcons.addIconSvg),
                                          ),
                                          10.h.verticalSpace,
                                          Text(
                                            "Add Horse",
                                            style: appTextStyles.p167003131,
                                          )
                                        ],
                                      ),
                                    );
                                  } else {
                                    var stable = controller.myStableList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            appRouteNames
                                                .specificHorseDetailsScreen,
                                            arguments: {
                                              "horseId": stable.id
                                            })?.then(
                                          (value) {
                                            myStableController
                                                .getMyStableList();
                                          },
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.black12,
                                              shape: BoxShape.circle,
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(110),
                                              child: CachedNetworkImage(
                                                imageUrl: stable.profileImage ?? "",
                                                placeholder: (context, url) => ShimmerEffect(
                                                  width: 100,
                                                  height: 100,
                                                ),
                                                errorWidget: (context, url, error) {
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
                                          10.h.verticalSpace,
                                          Text(
                                            "${stable.name}",
                                            style: appTextStyles.p167003131.copyWith(
                                              overflow: TextOverflow.ellipsis
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                              40.h.verticalSpace,
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
