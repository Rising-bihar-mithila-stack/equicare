import 'package:equicare/features/auth/presentation/screens/create_account_screen.dart';
import 'package:equicare/features/settings/controller/setting_controller.dart';
import 'package:equicare/repo/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../common/buttons/app_blue_button.dart';
import '../../../../common/buttons/app_grey_button.dart';
import '../../../../common/shadows/app_appbar_shadow_widget.dart';
import '../../../../utils/constants/app_constants.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List itemsList = [
    {
      'title': 'Associated Users',
      'leading': Icons.group_add_rounded,
      'trailing': true
    },
    {
      'title': 'Push Notifications',
      'leading': Icons.notifications,
      'trailing': true
    },
    // {'title': 'Change Email', 'leading': Icons.email, 'trailing': true},
    {'title': 'Change Password', 'leading': Icons.lock, 'trailing': true},
    // {
    //   'title': 'Cancel Subscription?',
    //   'leading': Icons.clear,
    //   'trailing': false
    // },
    {'title': 'Delete Account', 'leading': Icons.delete, 'trailing': false},
  ];
  late SettingController controller;

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() {
    controller = Get.put(
      SettingController(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () =>

          // controller.isLoading.value
          //     ? Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     :

          ModalProgressHUD(
        inAsyncCall: controller.isLoading.value,
        child: GetBuilder<SettingController>(
          builder: (controller) => SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    5.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Get.back(),
                          icon:
                              Icon(Icons.arrow_back, color: appColors.c1E4475),
                        ),
                        Text(
                          'Settings',
                          textAlign: TextAlign.center,
                          style: appTextStyles.p308002E2E,
                        ),
                        SizedBox(width: 32.w),
                      ],
                    ),
                    5.verticalSpace,
                    AppAppBarShadowWidget(),
                    20.verticalSpace,
                    Column(
                        children: List.generate(
                      itemsList.length,
                      (index) {
                        var singleItem = itemsList[index];
                        return GestureDetector(
                          onTap: () {
                            if (singleItem['title'] == 'Cancel Subscription?') {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    insetPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    backgroundColor: appColors.white,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 30.h, horizontal: 20.w),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Are you sure you want to cancel your subscription?",
                                            textAlign: TextAlign.center,
                                            style: appTextStyles.p167003131,
                                          ),
                                          15.h.verticalSpace,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                  child: AppBlueButton(
                                                      title: "Yes, Delete")),
                                              15.w.horizontalSpace,
                                              Flexible(
                                                  child: AppGreyButton(
                                                title: "No, Don't",
                                                onTap: () {
                                                  Get.back();
                                                },
                                              )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            if (singleItem['title'] == 'Delete Account') {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    insetPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    backgroundColor: appColors.white,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 30.h, horizontal: 20.w),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Are you sure you want to delete your account?",
                                            textAlign: TextAlign.center,
                                            style: appTextStyles.p167003131,
                                          ),
                                          15.h.verticalSpace,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                  child: AppBlueButton(
                                                title: "Yes, Delete",
                                                onTap: () async {
                                                  if (await controller
                                                      .deleteAccount()) {
                                                    Get.offAllNamed(
                                                        appRouteNames
                                                            .loginScreen);
                                                    // Get.snackbar('Message',
                                                    //     'User deleted successfully');
                                                  } else {
                                                    myAlertDialog(
                                                        message:
                                                            'Something Went Wrong',
                                                        context: context);
                                                  }
                                                },
                                              )),
                                              15.w.horizontalSpace,
                                              Flexible(
                                                  child: AppGreyButton(
                                                title: "No, Don't",
                                                onTap: () {
                                                  Get.back();
                                                },
                                              )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            if (singleItem['title'] == 'Push Notifications') {
                              Get.toNamed(appRouteNames.pushNotificationScreen);
                            }
                            // if (singleItem['title'] == 'Change Email') {
                            //   Get.toNamed(appRouteNames.changeEmailScreen);
                            // }
                            if (singleItem['title'] == 'Change Password') {
                              Get.toNamed(appRouteNames
                                  .changePasswordFromSettingScreen);
                            }
                            if (singleItem['title'] == 'Associated Users') {
                              Get.toNamed(appRouteNames.associatedUsersScreen);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 20.w,
                            ).copyWith(bottom: 10.h),
                            padding: EdgeInsets.symmetric(
                                vertical: 20.h, horizontal: 20.w),
                            decoration: BoxDecoration(
                              color: appColors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                  color: appColors.cCBCDD7.withOpacity(0.5),
                                  width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xff000000).withOpacity(0.06),
                                  offset: const Offset(0, 6),
                                  spreadRadius: 0,
                                  blurRadius: 18,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      singleItem['leading'],
                                      color: singleItem['title'] ==
                                              'Delete Account'
                                          ? appColors.cEA4335
                                          : appColors.c1E4475,
                                    ),
                                    15.w.horizontalSpace,
                                    Text(
                                      singleItem['title'],
                                      style: appTextStyles.p167003131,
                                    ),
                                  ],
                                ),
                                Icon(
                                  singleItem['trailing']
                                      ? Icons.arrow_forward
                                      : null,
                                  color: appColors.c818393,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (cnt) {
                        return Dialog(
                          insetPadding: EdgeInsets.symmetric(horizontal: 15),
                          backgroundColor: appColors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 30.h, horizontal: 15.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Are you sure you want to Logout your Account ?",
                                  style: appTextStyles.p167003131,
                                ),
                                15.h.verticalSpace,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                        child: AppBlueButton(
                                      title: "Yes, Logout",
                                      onTap: () async {
                                        Get.offAllNamed(
                                            appRouteNames.loginScreen);
                                            controller.logoutAccount();
                                        // if (await ) {
                                        // } else {
                                        //   myAlertDialog(
                                        //       message: 'Something Went Wrong',
                                        //       context: context);
                                        // }
                                      },
                                    )),
                                    15.w.horizontalSpace,
                                    Flexible(
                                      child: AppGreyButton(
                                        title: "No, Don't",
                                        onTap: () {
                                          Get.back();
                                        },
                                      ),
                                    ),
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
                    padding: EdgeInsets.symmetric(
                      vertical: 18.h,
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: appColors.cFBEAE9,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout_rounded,
                          size: 20,
                          color: appColors.cEA4335,
                        ),
                        5.horizontalSpace,
                        Text(
                          'Logout',
                          style: appTextStyles.p165003DABGreen
                              .copyWith(color: appColors.cEA4335),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
