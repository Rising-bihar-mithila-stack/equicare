import 'package:equicare/common/buttons/app_blue_button.dart';
import 'package:equicare/common/text_field/app_text_field.dart';
import 'package:equicare/features/auth/presentation/screens/create_account_screen.dart';
import 'package:equicare/features/settings/controller/setting_controller.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../../common/shadows/app_appbar_shadow_widget.dart';

class ChangePasswordFromSettingScreen extends StatefulWidget {
  const ChangePasswordFromSettingScreen({super.key});

  @override
  State<ChangePasswordFromSettingScreen> createState() =>
      _ChangePasswordFromSettingScreenState();
}

class _ChangePasswordFromSettingScreenState
    extends State<ChangePasswordFromSettingScreen> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  late SettingController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = Get.put(SettingController());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    disposeF();
    super.dispose();
  }

  void disposeF() {
    currentPasswordController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
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
            child: GetBuilder<SettingController>(
                builder: (controller) => SafeArea(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: appColors.primaryBlueColor,
                                size: 30,
                              )),
                          Text(
                            'Change Password',
                            textAlign: TextAlign.center,
                            style: appTextStyles.p308002E2E,
                          ),
                          SizedBox(
                            width: 40,
                          )
                        ],
                      ),
                      10.h.verticalSpace,
                      const AppAppBarShadowWidget(),
                      16.h.verticalSpace,
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextField(
                                  hintText: "Enter Old Password",
                                  textEditingController:
                                      currentPasswordController,
                                  title: "Old Password"),
                              AppTextField(
                                  hintText: "Enter New Password",
                                  textEditingController: passwordController,
                                  title: "New Password"),
                              AppTextField(
                                  hintText: "Enter New Password",
                                  textEditingController: rePasswordController,
                                  title: "Re-Type New Password"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Change Password?',
                                  style: appTextStyles.p167001EBlue,
                                ),
                              ),
                              const Spacer(),
                              AppBlueButton(
                                title: "Change",
                                onTap: () async {
                                  if (currentPasswordController.text.isEmpty) {
                                    myAlertDialog(message: 'Enter your Current Password',context: context);
                                  } else if (passwordController.text.isEmpty) {
                                    // Get.snackbar('New Password',
                                    //     'Enter your New Password');
                                    myAlertDialog(message: 'Enter your New Password', context: context);
                                  } else if (rePasswordController.text.isEmpty) {
                                    // Get.snackbar('Re-Type New Password',
                                    //     'Enter Re-Type New Password');
                                    myAlertDialog(message: 'Enter Re-Type New Password', context: context);
                                  } else if (rePasswordController.text ==
                                      passwordController.text) {
                                    if (await controller.updatePassword(
                                        oldPassword:
                                            currentPasswordController.text,
                                        newPassword: passwordController.text)) {
                                      Get.back();
                                      // Get.snackbar('Alert',
                                      //     'Password updated successfully');
                                    } else {
                                      // Get.snackbar('Alert',
                                      //     'Password Not Matched, Please enter correct old Password');
                                      myAlertDialog(message: 'Password Not Matched, Please enter correct old Password', context: context);
                                    }
                                  } else {
                                    // Get.snackbar('Alert',
                                    //     'Please check your Re-Type Password');
                                    myAlertDialog(message: 'Please check your Re-Type Password', context: context);
                                  }
                                },
                              ),
                              20.h.verticalSpace,
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ),
    ));
  }
}
